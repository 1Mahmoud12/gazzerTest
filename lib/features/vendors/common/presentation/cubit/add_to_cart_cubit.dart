import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gazzer/core/data/network/result_model.dart';
import 'package:gazzer/core/data/resources/session.dart';
import 'package:gazzer/core/presentation/extensions/enum.dart';
import 'package:gazzer/core/presentation/localization/l10n.dart';
import 'package:gazzer/features/cart/data/dtos/cart_response.dart';
import 'package:gazzer/features/cart/data/requests/cart_item_request.dart';
import 'package:gazzer/features/cart/domain/cart_repo.dart';
import 'package:gazzer/features/cart/domain/entities/cart_item_entity.dart';
import 'package:gazzer/features/cart/presentation/bus/cart_bus.dart';
import 'package:gazzer/features/vendors/common/domain/generic_item_entity.dart.dart';
import 'package:gazzer/features/vendors/common/domain/item_option_entity.dart';
import 'package:gazzer/features/vendors/common/presentation/cubit/add_to_cart_states.dart';

class AddToCartCubit extends Cubit<AddToCartStates> {
  @override
  void emit(AddToCartStates state) {
    if (isClosed) return;
    super.emit(state.copyWith(totalPrice: _calculatePrice(state)));
  }

  final CartRepo _repo;
  CartItemEntity? cartItem;
  final GenericItemEntity item;
  final List<ItemOptionEntity> options;
  late final double basePrice;
  final CartBus _bus;

  AddToCartCubit(
    this.item,
    this.options,
    this._repo,
    this._bus, [
    this.cartItem,
  ]) : basePrice = _calculateBasePrice(options, item.price),
       super(
         AddToCartStates(
           message: '',
           status: ApiStatus.initial,
           hasUserInteracted: false,
           hasAddedToCArt: false,
           note: cartItem?.notes,
           quantity: cartItem?.quantity ?? 1,
           totalPrice: cartItem?.totalPrice ?? _calculateInitialPrice(options, item.price),
           selectedOptions: _initializeDefaultSelections(options),
         ),
       ) {
    emit(state);
  }

  // Calculate base price - always use item base price
  static double _calculateBasePrice(
    List<ItemOptionEntity> options,
    double itemPrice,
  ) {
    return itemPrice;
  }

  // Calculate initial total price: base + default selected addons
  static double _calculateInitialPrice(
    List<ItemOptionEntity> options,
    double itemPrice,
  ) {
    double total = itemPrice;
    for (var option in options) {
      for (var addon in option.subAddons) {
        if (addon.isDefault && !addon.isFree) {
          total += addon.price;
        }
      }
    }
    return total;
  }

  // Initialize default selections - select all items with isDefault = true
  static Map<String, Set<String>> _initializeDefaultSelections(
    List<ItemOptionEntity> options,
  ) {
    final map = <String, Set<String>>{};

    for (var option in options) {
      // Find all default values (isDefault = true)
      final defaultValues = option.subAddons.where((addon) => addon.isDefault).toList();

      if (defaultValues.isNotEmpty) {
        map[option.id] = defaultValues.map((v) => v.id).toSet();

        // Process nested defaults
        _processNestedDefaults(defaultValues, option.id, map);
      }
    }

    return map;
  }

  // Helper method to process nested default selections
  static void _processNestedDefaults(
    List<SubAddonEntity> subAddons,
    String parentPath,
    Map<String, Set<String>> map,
  ) {
    for (var subAddon in subAddons) {
      if (subAddon.type != null) {
        // This is an option group, find its defaults
        final optionPath = '${parentPath}_${subAddon.id}';
        final defaultValues = subAddon.subAddons.where((value) => value.isDefault).toList();

        if (defaultValues.isNotEmpty) {
          map[optionPath] = defaultValues.map((v) => v.id).toSet();

          // Process deeper nested defaults
          _processNestedDefaults(defaultValues, optionPath, map);
        }
      }
    }
  }

  void increment() {
    emit(state.copyWith(qntity: state.quantity + 1, hasUserInteracted: true));
  }

  void decrement() {
    if (state.quantity > 1) {
      emit(state.copyWith(qntity: state.quantity - 1, hasUserInteracted: true));
    }
  }

  void setNote(String note) {
    emit(state.copyWith(note: note, hasUserInteracted: true));
  }

  // Method to ensure all default items are selected (no auto add to cart)
  void ensureDefaultSelections() {
    final newMap = Map<String, Set<String>>.from(state.selectedOptions);
    bool hasChanges = false;

    for (var option in options) {
      final currentSelections = newMap[option.id] ?? <String>{};
      final defaultValues = option.subAddons.where((v) => v.isDefault).toList();

      for (var defaultValue in defaultValues) {
        if (!currentSelections.contains(defaultValue.id)) {
          if (!newMap.containsKey(option.id)) {
            newMap[option.id] = <String>{};
          }
          newMap[option.id]!.add(defaultValue.id);
          hasChanges = true;
        }
      }

      // Process nested defaults
      if (hasChanges) {
        _processNestedDefaults(defaultValues, option.id, newMap);
      }
    }

    if (hasChanges) {
      emit(state.copyWith(selectedOptions: newMap, hasUserInteracted: false));
    }
  }

  // Main method to set option value with path-based selection
  void setOptionValue(String optionPath, String fullPath, OptionType type) {
    final newMap = Map<String, Set<String>>.from(state.selectedOptions);

    // Extract the actual value ID from the full path (last segment)
    final pathSegments = fullPath.split('_');
    final valueId = pathSegments.last;

    // For nested selections, we need to determine the correct option key
    // If it's a top-level selection, use the option ID
    // If it's a nested selection, use the parent path as the option key
    String optionKey;
    if (pathSegments.length == 1) {
      // Top-level selection
      optionKey = pathSegments.first;
    } else {
      // Nested selection - use the parent path as the option key
      optionKey = pathSegments.sublist(0, pathSegments.length - 1).join('_');
    }

    if (type == OptionType.radio) {
      // Radio: clear previous selection and set new one
      if (newMap.containsKey(optionKey)) {
        // Clear sub-addons of previously selected values
        for (var oldValueId in newMap[optionKey]!) {
          _clearChildSelections(newMap, '${optionKey}_$oldValueId');
        }
      }
      newMap[optionKey] = {valueId};
    } else {
      // Checkbox: toggle selection
      if (!newMap.containsKey(optionKey)) {
        newMap[optionKey] = {valueId};
      } else {
        if (newMap[optionKey]!.contains(valueId)) {
          // Deselecting - clear child selections
          _clearChildSelections(newMap, '${optionKey}_$valueId');
          newMap[optionKey] = newMap[optionKey]!.where((id) => id != valueId).toSet();
          if (newMap[optionKey]!.isEmpty) {
            newMap.remove(optionKey);
          }
        } else {
          // Selecting
          newMap[optionKey] = {...newMap[optionKey]!, valueId};
        }
      }
    }

    emit(state.copyWith(selectedOptions: newMap, hasUserInteracted: true));
  }

  // Clear all selections under a given path (recursive)
  void _clearChildSelections(
    Map<String, Set<String>> selections,
    String parentPath,
  ) {
    final keysToRemove = <String>[];
    for (var key in selections.keys) {
      if (key.startsWith('${parentPath}_')) {
        keysToRemove.add(key);
      }
    }
    for (var key in keysToRemove) {
      selections.remove(key);
    }
  }

  // Get all top-level options (no dynamic visibility needed)
  List<ItemOptionEntity> getAllOptions() {
    return options;
  }

  double _calculatePrice(AddToCartStates state) {
    double total = item.price; // Start with base price (app_price)

    // Calculate price for all selected options
    for (var option in options) {
      final selectedValueIds = state.selectedOptions[option.id];
      if (selectedValueIds != null) {
        for (var addon in option.subAddons) {
          if (selectedValueIds.contains(addon.id) && !addon.isFree) {
            total += addon.price; // Always add on top of base price

            // Process nested sub-addons
            total += _calculateNestedPrice(
              addon.subAddons,
              '${option.id}_${addon.id}',
              state,
            );
          }
        }
      }
    }

    return total * state.quantity;
  }

  // Helper method to calculate nested sub-addon prices (always additive)
  double _calculateNestedPrice(
    List<SubAddonEntity> subAddons,
    String parentPath,
    AddToCartStates state,
  ) {
    double cost = 0;

    for (var subAddon in subAddons) {
      if (subAddon.type != null) {
        // This is an option group
        final optionPath = '${parentPath}_${subAddon.id}';
        final selectedValueIds = state.selectedOptions[optionPath];

        if (selectedValueIds != null) {
          for (var value in subAddon.subAddons) {
            if (selectedValueIds.contains(value.id) && !value.isFree) {
              cost += value.price; // Always add to accumulated cost

              // Process deeper nested sub-addons
              cost += _calculateNestedPrice(
                value.subAddons,
                '${optionPath}_${value.id}',
                state,
              );
            }
          }
        }
      }
    }

    return cost;
  }

  Future<void> addToCart() async {
    final msg = _validateCart();
    print('msg is $msg');
    if (msg != null) return emit(state.copyWith(message: msg, status: ApiStatus.error));

    // Convert String-based selections to int-based for API
    final convertedOptions = _convertToIntBasedMap(state.selectedOptions);

    final req = CartableItemRequest(
      cartItemId: cartItem?.cartId,
      id: item.id,
      quantity: state.quantity,
      note: state.note,
      options: convertedOptions,
      type: item is PlateEntity ? CartItemType.plate : CartItemType.product,
    );
    if (cartItem != null) {
      _updateCart(req);
    } else {
      _addCartToRemote(req);
    }
  }

  // Convert String-based path map to int-based flat map for API
  Map<int, Set<int>> _convertToIntBasedMap(
    Map<String, Set<String>> selections,
  ) {
    final result = <int, Set<int>>{};

    for (var entry in selections.entries) {
      try {
        // Extract the option ID from the path (first segment before '_')
        final pathParts = entry.key.split('_');
        final optionIdStr = pathParts.first;

        // Try to parse as int, skip if it's a ULID
        final optionId = int.tryParse(optionIdStr);
        if (optionId == null) continue;

        final valueIds = <int>{};
        for (var valueIdStr in entry.value) {
          final valueId = int.tryParse(valueIdStr);
          if (valueId != null) {
            valueIds.add(valueId);
          }
        }

        if (valueIds.isNotEmpty) {
          result[optionId] = valueIds;
        }
      } catch (e) {
        print('Error converting selection: ${entry.key} -> ${entry.value}');
      }
    }

    return result;
  }

  Future<void> _addCartToRemote(CartableItemRequest req) async {
    emit(state.copyWith(status: ApiStatus.loading));
    final response = await _repo.addToCartItem(req);
    switch (response) {
      case Ok<CartResponse> res:
        _bus.cartResponseToValues(res.value);
        emit(
          state.copyWith(
            status: ApiStatus.success,
            message: res.value.message,
            hasUserInteracted: false,
          ),
        );
      case Err err:
        emit(
          state.copyWith(
            status: ApiStatus.error,
            message: err.error.message,
            hasUserInteracted: false,
          ),
        );
    }
  }

  Future<void> _updateCart(CartableItemRequest req) async {
    emit(state.copyWith(status: ApiStatus.loading));
    final response = await _repo.updateCartItem(req);
    switch (response) {
      case Ok<CartResponse> res:
        _bus.cartResponseToValues(res.value);
        emit(
          state.copyWith(
            status: ApiStatus.success,
            message: res.value.message,
            hasUserInteracted: false,
          ),
        );
      case Err err:
        emit(
          state.copyWith(
            status: ApiStatus.error,
            message: err.error.message,
            hasUserInteracted: false,
          ),
        );
    }
  }

  String? _validateCart() {
    if (Session().client == null) return L10n.tr().pleaseLoginToUseCart;
    if (state.quantity < 1) return L10n.tr().quantityValidation;

    // Validate only top-level required options
    for (var option in options) {
      if (option.isRequired) {
        final selectedValueIds = state.selectedOptions[option.id];
        if (selectedValueIds == null || selectedValueIds.isEmpty) {
          return L10n.tr().pleaseSelectAtLeastOneValueOptionForName(
            option.name,
          );
        }
      }
    }

    return null;
  }

  void userRequestClose() {
    emit(state.copyWith(hasUserInteracted: false));
  }

  void resetState() {
    emit(
      AddToCartStates(
        message: '',
        status: ApiStatus.initial,
        hasUserInteracted: false,
        hasAddedToCArt: false,
        note: null,
        quantity: 1,
        totalPrice: _calculateInitialPrice(options, item.price),
        selectedOptions: _initializeDefaultSelections(options),
      ),
    );
  }
}
