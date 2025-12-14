# Unused Keys in Top Items API Response

## Root Level (TopItemsDto)

- `pagination` - Not parsed (contains: current_page, total_records, current_records, has_next,
  has_previous, total_pages, per_page)

## Data Level (TopItemsDtoData)

- `banner` - Parsed but stored as `dynamic` instead of `BannerDTO` (should be properly typed)

## Entity Level (TopItemEntity)

All keys are parsed and used:

- `id` ✓
- `item_type` ✓
- `item_id` ✓
- `item` ✓

## Item Level (TopItemData)

The following keys exist in the API response but are NOT parsed in `TopItemData.fromJson()`:

- `sold` - **NOT PARSED** ⚠️ **NEEDED** - Sold quantity/count for the item (as mentioned by user)
- `order_count` - **NOT PARSED** ⚠️ **NEEDED** - Number of orders/times this item was sold (used in
  UI to display "totalUnitSolid")
- `quantity` - **NOT PARSED** (if exists in API - available quantity in stock)
- `total_sold` - **NOT PARSED** (if exists in API - alternative to sold)

Note: The `GenericItemEntity` has an `orderCount` field that is used in the UI (see
`best_selling_card.dart` and `groc_prod_card.dart`), but `TopItemData` doesn't parse it from the API
response.

### Currently Parsed Keys (all used):

- `id` ✓
- `store_id` ✓
- `plate_name` ✓
- `plate_category_id` ✓
- `plate_description` ✓
- `plate_image` ✓
- `price` ✓
- `rate` ✓
- `rate_count` ✓
- `app_price` ✓
- `item_type` ✓
- `ordered_with` ✓
- `offer` ✓
- `is_favorite` ✓
- `is_have_cart_times` ✓
- `cart_time_quantity` ✓
- `has_options` ✓
- `store_info` ✓

## Store Info Level (SimpleStoreDTO)

Based on the API response structure, the following keys from `store_info` may exist but are NOT
parsed:

- `is_busy` - Not parsed
- `rating` - Not parsed (uses different field)
- `store_category_name` - Not parsed
- `work_from` - Not parsed
- `work_to` - Not parsed
- `estimated_delivery_time` - Not parsed
- `order_count` - Not parsed (if exists in store_info)

Note: `SimpleStoreDTO` only parses: `store_id`, `store_name`, `store_category_type`, `store_image`.

## Needed Keys (Missing from DTO - Should be Added)

The following keys should be added to `TopItemData`:

1. **`sold`** - Sold quantity/count for the item (as mentioned by user) ⚠️ **HIGH PRIORITY**
2. **`order_count`** - Number of orders/times this item was sold (used in UI) ⚠️ **HIGH PRIORITY**
3. `quantity` - Available quantity in stock (if exists in API)
4. `total_sold` - Total sold count (if exists as alternative to sold)

## Implementation Notes

- The `GenericItemEntity` already supports `orderCount` field
- UI components (`best_selling_card.dart`, `groc_prod_card.dart`) display `orderCount` using
  `L10n.tr().totalUnitSolid`
- Need to map `sold` or `order_count` from API to `orderCount` in the entity

