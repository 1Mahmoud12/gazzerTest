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
    print("cart item is ${cartItem?.prod.name}");
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

    void processAddons(List<SubAddonEntity> addons, String parentPath) {
      // Group addons by their parent option (if they have type)
      final addonsByOption = <String, List<SubAddonEntity>>{};

      for (var addon in addons) {
        if (addon.type != null) {
          // This addon is itself an option
          final key = addon.id;
          if (!addonsByOption.containsKey(key)) {
            addonsByOption[key] = [];
          }
        } else {
          // This is a value for the parent option
          final defaults = addons.where((a) => a.isDefault && a.type == null);
          if (defaults.isNotEmpty) {
            map[parentPath] = defaults.map((a) => a.id).toSet();

            // Process sub-addons of default values
            for (var defaultAddon in defaults) {
              if (defaultAddon.subAddons.isNotEmpty) {
                final valuePath = '${parentPath}_${defaultAddon.id}';
                processAddons(defaultAddon.subAddons, valuePath);
              }
            }
          }
          break;
        }
      }
    }

    for (var option in options) {
      final defaultAddons = option.subAddons.where(
        (v) => v.isDefault && v.type == null,
      );
      if (defaultAddons.isNotEmpty) {
        map[option.id] = defaultAddons.map((v) => v.id).toSet();

        // Process sub-addons of default values
        for (var defaultAddon in defaultAddons) {
          if (defaultAddon.subAddons.isNotEmpty) {
            final valuePath = '${option.id}_${defaultAddon.id}';
            processAddons(defaultAddon.subAddons, valuePath);
          }
        }
      }
    }

    return map;
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

  // Main method to set option value with path-based selection
  void setOptionValue(String optionPath, String valueId, OptionType type) {
    final newMap = Map<String, Set<String>>.from(state.selectedOptions);

    if (type == OptionType.radio) {
      // Radio: clear previous selection and set new one
      if (newMap.containsKey(optionPath)) {
        // Clear sub-addons of previously selected values
        for (var oldValueId in newMap[optionPath]!) {
          _clearChildSelections(newMap, '${optionPath}_$oldValueId');
        }
      }
      newMap[optionPath] = {valueId};
    } else {
      // Checkbox: toggle selection
      if (!newMap.containsKey(optionPath)) {
        newMap[optionPath] = {valueId};
      } else {
        if (newMap[optionPath]!.contains(valueId)) {
          // Deselecting - clear child selections
          _clearChildSelections(newMap, '${optionPath}_$valueId');
          newMap[optionPath] = newMap[optionPath]!.where((id) => id != valueId).toSet();
          if (newMap[optionPath]!.isEmpty) {
            newMap.remove(optionPath);
          }
        } else {
          // Selecting
          newMap[optionPath] = {...newMap[optionPath]!, valueId};
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

  // Get all visible options as a flat list (including visible sub-addons based on selections)
  List<({String optionId, String optionName, List<SubAddonEntity> values, OptionType type, bool isRequired, String path})> getAllVisibleOptions() {
    final result = <({String optionId, String optionName, List<SubAddonEntity> values, OptionType type, bool isRequired, String path})>[];

    void processAddons(List<SubAddonEntity> addons, String parentPath) {
      for (var addon in addons) {
        // If this addon has a type, it's an option group
        if (addon.type != null) {
          final optionPath = parentPath.isEmpty ? addon.id : '${parentPath}_${addon.id}';

          // This addon itself is an option, so add it
          result.add((
            optionId: addon.id,
            optionName: addon.name,
            values: addon.subAddons,
            type: addon.type!,
            isRequired: addon.isRequired ?? false,
            path: optionPath,
          ));

          // Check if any value of this option is selected and has sub-addons
          final selectedValueIds = state.selectedOptions[optionPath];
          if (selectedValueIds != null) {
            for (var subAddon in addon.subAddons) {
              if (selectedValueIds.contains(subAddon.id) && subAddon.subAddons.isNotEmpty) {
                final valuePath = '${optionPath}_${subAddon.id}';
                processAddons(subAddon.subAddons, valuePath);
              }
            }
          }
        }
      }
    }

    // Process top-level options
    for (var option in options) {
      result.add((
        optionId: option.id,
        optionName: option.name,
        values: option.subAddons,
        type: option.type,
        isRequired: option.isRequired,
        path: option.id,
      ));

      // Check if any value is selected and has sub-addons
      final selectedValueIds = state.selectedOptions[option.id];
      if (selectedValueIds != null) {
        for (var addon in option.subAddons) {
          if (selectedValueIds.contains(addon.id) && addon.subAddons.isNotEmpty) {
            final valuePath = '${option.id}_${addon.id}';
            processAddons(addon.subAddons, valuePath);
          }
        }
      }
    }

    return result;
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

    // Validate only visible required options
    final visibleOptions = getAllVisibleOptions();
    for (var record in visibleOptions) {
      if (record.isRequired) {
        final selectedValueIds = state.selectedOptions[record.path];
        if (selectedValueIds == null || selectedValueIds.isEmpty) {
          return L10n.tr().pleaseSelectAtLeastOneValueOptionForName(
            record.optionName,
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
