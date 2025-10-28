import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gazzer/core/data/network/result_model.dart';
import 'package:gazzer/core/data/resources/session.dart';
import 'package:gazzer/core/presentation/extensions/enum.dart';
import 'package:gazzer/core/presentation/extensions/irretable.dart';
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

  // Calculate base price - if any option controls price, use its default value's price
  static double _calculateBasePrice(
    List<ItemOptionEntity> options,
    double itemPrice,
  ) {
    final controlsPriceOption = options.firstWhereOrNull(
      (e) => e.controlsPrice,
    );
    if (controlsPriceOption != null) {
      final defaultAddon = controlsPriceOption.subAddons.firstWhereOrNull(
        (v) => v.isDefault,
      );
      return defaultAddon?.price ?? 0;
    }
    return itemPrice;
  }

  // Calculate initial total price
  static double _calculateInitialPrice(
    List<ItemOptionEntity> options,
    double itemPrice,
  ) {
    final controlsPriceOption = options.firstWhereOrNull(
      (e) => e.controlsPrice,
    );
    if (controlsPriceOption != null) {
      final defaultAddon = controlsPriceOption.subAddons.firstWhereOrNull(
        (v) => v.isDefault,
      );
      return defaultAddon?.price ?? 0;
    }
    return itemPrice;
  }

  // Initialize default selections recursively with path-based keys
  static Map<String, Set<String>> _initializeDefaultSelections(
    List<ItemOptionEntity> options,
  ) {
    final map = <String, Set<String>>{};

    // Process each top-level option
    for (var option in options) {
      // Find default values (items with isDefault = true and isLeafValue = true)
      final defaultValues = option.subAddons
          .where(
            (addon) => addon.isDefault && addon.isLeafValue,
          )
          .toList();

      if (defaultValues.isNotEmpty) {
        // Select the default values
        map[option.id] = defaultValues.map((v) => v.id).toSet();

        // Process sub-addons of each default value (only if they have sub-addons)
        for (var defaultValue in defaultValues) {
          if (defaultValue.subAddons.isNotEmpty) {
            _processSubAddons(
              defaultValue.subAddons,
              '${option.id}_${defaultValue.id}',
              map,
            );
          }
        }
      }
    }

    return map;
  }

  // Helper method to recursively process sub-addons
  static void _processSubAddons(
    List<SubAddonEntity> subAddons,
    String parentPath,
    Map<String, Set<String>> map,
  ) {
    for (var subAddon in subAddons) {
      if (subAddon.type != null) {
        // This sub-addon is itself an option group
        final optionPath = '${parentPath}_${subAddon.id}';

        // Find default values within this option group (leaf values only)
        final defaultValues = subAddon.subAddons
            .where(
              (value) => value.isDefault && value.isLeafValue,
            )
            .toList();

        if (defaultValues.isNotEmpty) {
          // Select the default values for this option
          map[optionPath] = defaultValues.map((v) => v.id).toSet();

          // Process nested sub-addons of each default value (only if they have sub-addons)
          for (var defaultValue in defaultValues) {
            if (defaultValue.subAddons.isNotEmpty) {
              _processSubAddons(
                defaultValue.subAddons,
                '${optionPath}_${defaultValue.id}',
                map,
              );
            }
          }
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

  // Method to ensure all default items are selected and added to cart
  void ensureDefaultSelections() {
    final newMap = Map<String, Set<String>>.from(state.selectedOptions);
    bool hasChanges = false;

    // Process all top-level options to find unselected defaults
    for (var option in options) {
      final currentSelections = newMap[option.id] ?? <String>{};
      // Only select leaf values (final values that can be selected)
      final defaultValues = option.subAddons.where((v) => v.isDefault && v.isLeafValue).toList();

      for (var defaultValue in defaultValues) {
        if (!currentSelections.contains(defaultValue.id)) {
          if (!newMap.containsKey(option.id)) {
            newMap[option.id] = <String>{};
          }
          newMap[option.id]!.add(defaultValue.id);
          hasChanges = true;
        }
      }
    }

    if (hasChanges) {
      emit(state.copyWith(selectedOptions: newMap, hasUserInteracted: false));

      // Automatically add to cart if there are default selections and no user interaction yet
      if (!state.hasUserInteracted && !state.hasAddedToCArt) {
        // Add a small delay to ensure the UI is updated
        Future.delayed(const Duration(milliseconds: 100), () {
          addToCart();
        });
      }
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
    double total = basePrice;
    double addonsCost = 0;

    // Recursively calculate price for all selected addons
    double calculateAddonsPrice(
      List<SubAddonEntity> addons,
      String parentPath,
    ) {
      double nestedCost = 0;

      for (var addon in addons) {
        if (addon.type != null) {
          // This is an option group, check its selections
          final optionPath = parentPath.isEmpty ? addon.id : '${parentPath}_${addon.id}';
          final selectedValueIds = state.selectedOptions[optionPath];

          if (selectedValueIds != null) {
            for (var subAddon in addon.subAddons) {
              if (selectedValueIds.contains(subAddon.id)) {
                // Add price if not free
                if (!subAddon.isFree) {
                  if (addon.controlsPrice == true) {
                    total = subAddon.price;
                  } else {
                    nestedCost += subAddon.price;
                  }
                }

                // Process nested sub-addons
                if (subAddon.subAddons.isNotEmpty) {
                  final valuePath = '${optionPath}_${subAddon.id}';
                  nestedCost += calculateAddonsPrice(
                    subAddon.subAddons,
                    valuePath,
                  );
                }
              }
            }
          }
        }
      }

      return nestedCost;
    }

    // Process top-level options
    for (var option in options) {
      final selectedValueIds = state.selectedOptions[option.id];

      if (selectedValueIds != null) {
        for (var addon in option.subAddons) {
          if (selectedValueIds.contains(addon.id)) {
            // Add price if not free
            if (!addon.isFree) {
              if (option.controlsPrice) {
                total = addon.price;
              } else {
                addonsCost += addon.price;
              }
            }

            // Process nested sub-addons
            if (addon.subAddons.isNotEmpty) {
              final valuePath = '${option.id}_${addon.id}';
              addonsCost += calculateAddonsPrice(addon.subAddons, valuePath);
            }
          }
        }
      }
    }

    return (total + addonsCost) * state.quantity;
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
