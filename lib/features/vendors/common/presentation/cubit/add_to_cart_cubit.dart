import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gazzer/core/data/network/error_models.dart';
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
import 'package:gazzer/features/vendors/common/presentation/exceed_bottom_sheet.dart';

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
  final Map<int, int> _orderedWith = {};
  final Map<int, double> _orderedWithPrices = {};

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
    if (cartItem != null) {
      _hydrateFromExistingCartItem(cartItem!);
    }
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

      // Only apply defaults if this option has NO selection yet
      // (for new items there is none; for existing cart items we don't want to
      //  override a user's previous non‑default choice)
      final currentSelections = map[option.id] ?? <String>{};
      if (defaultValues.isNotEmpty && currentSelections.isEmpty) {
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
    // Check if item is ProductEntity and has quantityInStock limit
    if (item is ProductEntity) {
      final product = item as ProductEntity;
      if (product.quantityInStock != null && state.quantity >= product.quantityInStock!) {
        // Already at or above max quantity, show toast
        emit(
          state.copyWith(
            message: L10n.tr().maximumQuantityReachedForItem,
            status: ApiStatus.error,
            hasUserInteracted: true,
          ),
        );
        return;
      }
    }

    emit(
      state.copyWith(
        qntity: state.quantity + 1,
        hasUserInteracted: true,
        message: '',
        status: ApiStatus.initial,
      ),
    );
  }

  void decrement() {
    if (state.quantity > 1) {
      emit(
        state.copyWith(
          qntity: state.quantity - 1,
          hasUserInteracted: true,
          message: '',
          status: ApiStatus.initial,
        ),
      );
    }
  }

  void setNote(String note) {
    emit(
      state.copyWith(
        note: note,
        hasUserInteracted: true,
        message: '',
        status: ApiStatus.initial,
      ),
    );
  }

  // Ordered-with helpers
  void setOrderedWithQuantity(int id, int quantity) {
    if (quantity <= 0) {
      _orderedWith.remove(id);
    } else {
      _orderedWith[id] = quantity;
    }
    emit(
      state.copyWith(
        hasUserInteracted: true,
        message: '',
        status: ApiStatus.initial,
      ),
    );
  }

  int getOrderedWithQuantity(int id) => _orderedWith[id] ?? 0;

  Map<int, int> get orderedWithSelections => Map.unmodifiable(_orderedWith);

  void setOrderedWithPrices(Map<int, double> idToPrice) {
    _orderedWithPrices
      ..clear()
      ..addAll(idToPrice);
  }

  // Method to ensure all default items are selected (no auto add to cart)
  void ensureDefaultSelections() {
    final newMap = Map<String, Set<String>>.from(state.selectedOptions);
    bool hasChanges = false;

    for (var option in options) {
      final currentSelections = newMap[option.id] ?? <String>{};

      // If there is already any selection for this option (even if it's not the
      // default one), DO NOT add defaults. This prevents re‑selecting default
      // items when user opens an existing cart item and changes options.
      if (currentSelections.isNotEmpty) {
        continue;
      }

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

    // Determine the correct option key based on the path structure
    String optionKey;
    if (pathSegments.length == 2 && pathSegments.first == optionPath) {
      // Top-level selection: "optionId_valueId" -> use "optionId"
      optionKey = pathSegments.first;
    } else if (pathSegments.length > 2) {
      // Nested selection: "optionId_valueId_groupId_childId" -> use "optionId_valueId_groupId"
      optionKey = pathSegments.sublist(0, pathSegments.length - 1).join('_');
    } else {
      // Fallback: use the first segment as option key
      optionKey = pathSegments.first;
    }

    // Resolve actual group type from path to avoid UI/type mismatches
    final resolvedType = _resolveOptionTypeForKey(optionKey) ?? type;

    if (resolvedType == OptionType.radio) {
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
    log('=== SETTING OPTION VALUE ===');
    log('optionKey: $optionKey');
    log('valueId: $valueId');
    log('newMap: $newMap');
    log('============================');

    emit(
      state.copyWith(
        selectedOptions: newMap,
        hasUserInteracted: true,
        message: '',
        status: ApiStatus.initial,
      ),
    );
  }

  // Determine option group's type (radio/checkbox) from optionKey path
  OptionType? _resolveOptionTypeForKey(String optionKey) {
    if (optionKey.isEmpty) return null;
    final segments = optionKey.split('_');
    if (segments.isEmpty) return null;

    // First segment is top-level option id
    final topId = segments.first;
    final topOption = options.firstWhereOrNull((o) => o.id == topId);
    if (topOption == null) return null;
    if (segments.length == 1) return topOption.type;

    // Walk down the tree to the last group id
    List<SubAddonEntity> current = topOption.subAddons;
    OptionType? currentType = topOption.type;

    for (int i = 1; i < segments.length; i++) {
      final groupId = segments[i];
      final node = current.firstWhereOrNull((n) => n.id == groupId);
      if (node == null) break;
      currentType = node.type ?? currentType;
      current = node.subAddons;
    }

    return currentType;
  }

  // Clear all selections under a given path (recursive)
  void _clearChildSelections(
    Map<String, Set<String>> selections,
    String parentPath,
  ) {
    final keysToRemove = <String>[];
    // Remove the immediate group key itself
    if (selections.containsKey(parentPath)) {
      keysToRemove.add(parentPath);
    }
    // Remove all nested children under this path
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

  void _hydrateFromExistingCartItem(CartItemEntity existing) {
    final hydratedSelections = <String, Set<String>>{};

    for (final opt in existing.options) {
      if (opt.values.isEmpty) continue;
      final topOption = options.firstWhereOrNull((o) => o.id == opt.id);
      if (topOption == null) continue;

      for (final val in opt.values) {
        final idPath = _findIdPath(topOption, val.id);
        if (idPath == null || idPath.isEmpty) {
          hydratedSelections[topOption.id] = {
            ...(hydratedSelections[topOption.id] ?? <String>{}),
            val.id,
          };
          continue;
        }

        // Top-level selection
        final firstSeg = idPath.first;
        hydratedSelections[topOption.id] = {
          ...(hydratedSelections[topOption.id] ?? <String>{}),
          firstSeg,
        };

        // Nested selections for each level
        for (int i = 0; i < idPath.length - 1; i++) {
          final parentKey = [topOption.id, ...idPath.take(i + 1)].join('_');
          final childId = idPath[i + 1];
          hydratedSelections[parentKey] = {
            ...(hydratedSelections[parentKey] ?? <String>{}),
            childId,
          };
        }
      }
    }

    _orderedWith
      ..clear()
      ..addEntries(existing.orderedWith.map((e) => MapEntry(e.id, e.quantity)));

    emit(
      state.copyWith(
        qntity: existing.quantity,
        note: existing.notes,
        selectedOptions: hydratedSelections.isNotEmpty ? hydratedSelections : state.selectedOptions,
        hasUserInteracted: false,
      ),
    );
  }

  // Returns the chain of ids from the first child under the option to the target id, including group ids
  List<String>? _findIdPath(ItemOptionEntity option, String targetId) {
    final out = <String>[];
    final ok = _dfsFind(option.subAddons, targetId, out);
    return ok ? out : null;
  }

  bool _dfsFind(List<SubAddonEntity> nodes, String targetId, List<String> out) {
    for (final node in nodes) {
      if (node.id == targetId) {
        out.add(node.id);
        return true;
      }
      if (node.subAddons.isNotEmpty) {
        out.add(node.id);
        final found = _dfsFind(node.subAddons, targetId, out);
        if (found) return true;
        out.removeLast();
      }
    }
    return false;
  }

  double _calculatePrice(AddToCartStates state) {
    double total = item.price; // Start with base price (app_price)
    log('=== PRICE CALCULATION ===');
    log('Base price: $total');
    log('All selections: ${state.selectedOptions}');

    // Calculate price for all selected options (top-level and nested)
    for (var entry in state.selectedOptions.entries) {
      final path = entry.key;
      final selectedValueIds = entry.value;
      log('Processing path: $path with values: $selectedValueIds');

      // Find the corresponding option for this path
      final optionAndAddon = _findOptionAndAddonByPath(path);
      if (optionAndAddon != null) {
        final option = optionAndAddon['option'] as ItemOptionEntity;

        // Resolve the actual group type for this specific path (not just the top-level option type)
        final groupType = _resolveOptionTypeForKey(path) ?? option.type;

        // For radio type, only add the first selected item (radio = single selection)
        // For checkbox type, add all selected items (checkbox = multiple selection)
        final valuesToProcess = groupType == OptionType.radio ? selectedValueIds.take(1) : selectedValueIds;

        for (var valueId in valuesToProcess) {
          // Find the specific sub-addon that matches this valueId
          final subAddon = _findSubAddonById(option, valueId);
          if (subAddon != null && !subAddon.isFree) {
            log(
              'Adding ${subAddon.name}: +${subAddon.price} (${groupType == OptionType.radio ? 'radio' : 'checkbox'})',
            );
            total += subAddon.price;
          }
        }
      }
    }

    // Subtotal for main item including selected options multiplied by main quantity
    final mainSubtotal = total * state.quantity;

    // Add ordered-with items (not multiplied by main item quantity)
    double orderedWithTotal = 0.0;
    _orderedWith.forEach((id, qty) {
      final price = _orderedWithPrices[id] ?? 0.0;
      orderedWithTotal += price * qty;
    });

    final grandTotal = mainSubtotal + orderedWithTotal;
    log('Ordered-with total: $orderedWithTotal');
    log('Grand total: $grandTotal');
    log('=======================');
    return grandTotal;
  }

  // Find option and addon by path (handles both top-level and nested paths)
  Map<String, dynamic>? _findOptionAndAddonByPath(String path) {
    final segments = path.split('_');

    if (segments.length == 1) {
      // Top-level option
      final option = options.firstWhereOrNull((opt) => opt.id == segments[0]);
      if (option != null) {
        return {'option': option, 'addon': null};
      }
    } else if (segments.length >= 2) {
      // Nested path: optionId_addonId_...
      final optionId = segments[0];
      final addonId = segments[1];

      final option = options.firstWhereOrNull((opt) => opt.id == optionId);
      if (option != null) {
        final addon = _findSubAddonById(option, addonId);
        return {'option': option, 'addon': addon};
      }
    }

    return null;
  }

  // Find sub-addon by ID recursively
  SubAddonEntity? _findSubAddonById(ItemOptionEntity option, String id) {
    for (var addon in option.subAddons) {
      if (addon.id == id) return addon;

      // Search in nested sub-addons
      final found = _findSubAddonInList(addon.subAddons, id);
      if (found != null) return found;
    }
    return null;
  }

  // Helper to search in a list of sub-addons
  SubAddonEntity? _findSubAddonInList(
    List<SubAddonEntity> subAddons,
    String id,
  ) {
    for (var addon in subAddons) {
      if (addon.id == id) return addon;

      // Search deeper
      final found = _findSubAddonInList(addon.subAddons, id);
      if (found != null) return found;
    }
    return null;
  }

  Future<void> addToCart(BuildContext context) async {
    final msg = _validateCart();
    if (msg != null) return emit(state.copyWith(message: msg, status: ApiStatus.error));

    // Build options payload as a list of { option_id, value_ids }
    final optionsPayload = _buildOptionsPayload(state.selectedOptions);
    log('options payload: $optionsPayload');
    // If your API still expects the legacy map<int, Set<int>> format, keep this line until you switch
    final convertedOptions = _convertToIntBasedMap(state.selectedOptions);

    // Build ordered_with payload: [{ id, quantity }]
    final orderedWithPayload = _orderedWith.entries
        .map(
          (e) => {
            'id': e.key,
            'quantity': e.value,
          },
        )
        .toList();

    final req = CartableItemRequest(
      cartItemId: cartItem?.cartId,
      id: item.id,
      quantity: state.quantity,
      note: state.note,
      options: convertedOptions,
      orderedWith: orderedWithPayload.isEmpty ? null : orderedWithPayload,
      type: item is PlateEntity ? CartItemType.plate : CartItemType.product,
    );
    final shouldUpdate = req.cartItemId != null;
    if (shouldUpdate) {
      _updateCart(context, req);
    } else {
      _addCartToRemote(context, req);
    }
  }

  // Convert String-based path map to int-based flat map for API
  Map<int, Set<String>> _convertToIntBasedMap(
    Map<String, Set<String>> selections,
  ) {
    final result = <int, Set<String>>{};

    for (var entry in selections.entries) {
      try {
        // Extract the option ID from the path (first segment before '_')
        final pathParts = entry.key.split('_');
        final optionIdStr = pathParts.first;

        // Try to parse as int, skip if it's a ULID
        final optionId = int.tryParse(optionIdStr);
        if (optionId == null) continue;

        final valueIds = <String>{};
        for (var valueIdStr in entry.value) {
          valueIds.add(valueIdStr);
        }

        if (valueIds.isNotEmpty) {
          result[optionId] = valueIds;
        }
      } catch (e) {
        log('Error converting selection: ${entry.key} -> ${entry.value}');
      }
    }

    return result;
  }

  // Build API-ready payload: [{ option_id, value_ids }]
  // - option_id is derived from the LAST segment of the option path (works for nested groups)
  // - value_ids are kept as strings to support ULID/UUID

  List<Map<String, dynamic>> _buildOptionsPayload(
    Map<String, Set<String>> selections,
  ) {
    final List<Map<String, dynamic>> payload = [];

    for (final entry in selections.entries) {
      final segments = entry.key.split('_');
      final optionIdStr = segments.isNotEmpty ? segments.last : entry.key;
      final optionIdInt = int.tryParse(optionIdStr);

      payload.add({
        'option_id': optionIdInt ?? optionIdStr,
        'value_ids': entry.value.toList(),
      });
    }

    return payload;
  }

  Future<void> _addCartToRemote(
    BuildContext context,
    CartableItemRequest req,
  ) async {
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
        if (context.mounted && err.error is CartError && (err.error as CartError).needsNewPouchApproval) {
          final confirmed = await warningAlert(
            title: L10n.tr().exceedPouch,
            context: context,
            cancelBtn: L10n.tr().editItems,
            okBtn: L10n.tr().assignAdditionalDelivery,
          );
          if (confirmed == true && context.mounted) {
            // Keep loading state and make recursive call - it will handle state management

            await _addCartToRemote(context, req.copyWith(exceedPouch: true));
          }
          emit(
            state.copyWith(
              status: ApiStatus.error,
              message: '',
              hasUserInteracted: false,
            ),
          );
          return;
        }
        // Only emit error if user didn't confirm or it's not a pouch approval error
        emit(
          state.copyWith(
            status: ApiStatus.error,
            message: err.error.message,
            hasUserInteracted: false,
          ),
        );
    }
  }

  Future<void> _updateCart(
    BuildContext context,
    CartableItemRequest req,
  ) async {
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
        if (context.mounted && err.error is CartError && (err.error as CartError).needsNewPouchApproval) {
          final confirmed = await warningAlert(
            title: L10n.tr().exceedPouch,
            context: context,
            cancelBtn: L10n.tr().editItems,
            okBtn: L10n.tr().assignAdditionalDelivery,
          );
          if (confirmed == true) {
            // Keep loading state and make recursive call - it will handle state management
            if (context.mounted) {
              await _updateCart(context, req.copyWith(exceedPouch: true));
            }

            return; // Exit early - recursive call handled state
          }
          emit(
            state.copyWith(
              status: ApiStatus.error,
              message: '',
              hasUserInteracted: false,
            ),
          );
          return;
        }
        // Only emit error if user didn't confirm or it's not a pouch approval error
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

    // Validate that all selected options with children have their children selected
    final incompleteSelection = _validateNestedSelections();
    if (incompleteSelection != null) {
      return incompleteSelection;
    }

    return null;
  }

  /// Validates that all selected options with children have at least one child selected
  /// Returns error message if validation fails, null if valid
  String? _validateNestedSelections() {
    // Check all selected options recursively
    for (var option in options) {
      final selectedValueIds = state.selectedOptions[option.id];
      if (selectedValueIds != null && selectedValueIds.isNotEmpty) {
        for (var valueId in selectedValueIds) {
          final subAddon = _findSubAddonById(option, valueId);
          if (subAddon != null && subAddon.subAddons.isNotEmpty) {
            // This selected value has children - check if at least one child is selected
            final childPath = '${option.id}_$valueId';
            final childSelections = state.selectedOptions[childPath];
            if (childSelections == null || childSelections.isEmpty) {
              return L10n.tr().pleaseSelectAtLeastOneValueOptionForName(
                subAddon.name,
              );
            }
            // Recursively validate children
            final childError = _validateSubAddonSelections(
              subAddon,
              childPath,
            );
            if (childError != null) return childError;
          }
        }
      }
    }
    return null;
  }

  /// Recursively validates that all selected sub-addons with children have their children selected
  String? _validateSubAddonSelections(
    SubAddonEntity parentSubAddon,
    String parentPath,
  ) {
    final childSelections = state.selectedOptions[parentPath];
    if (childSelections == null || childSelections.isEmpty) {
      return null; // No children selected, but this is handled by caller
    }

    for (var childId in childSelections) {
      final childSubAddon = _findSubAddonInList(
        parentSubAddon.subAddons,
        childId,
      );
      if (childSubAddon != null && childSubAddon.subAddons.isNotEmpty) {
        // This child has its own children - check if at least one is selected
        final grandChildPath = '${parentPath}_$childId';
        final grandChildSelections = state.selectedOptions[grandChildPath];
        if (grandChildSelections == null || grandChildSelections.isEmpty) {
          return L10n.tr().pleaseSelectAtLeastOneValueOptionForName(
            childSubAddon.name,
          );
        }
        // Recursively validate deeper levels
        final deeperError = _validateSubAddonSelections(
          childSubAddon,
          grandChildPath,
        );
        if (deeperError != null) return deeperError;
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
