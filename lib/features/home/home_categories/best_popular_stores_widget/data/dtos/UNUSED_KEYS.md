# Unused Keys in Best Popular Stores Widget API Response

## Root Level

- `pagination` - Not parsed (contains: current_page, total_records, current_records, has_next,
  has_previous, total_pages, per_page)

## Banner Level (in BannerDTO)

The following keys exist in the API response but are NOT parsed in `BannerDTO`:

- `page` - Not parsed
- `bannerable_id` - Not parsed (commented out in BannerDTO)
- `button_displayed` - Not parsed
- `button_text` - Not parsed

Note: All other banner keys are parsed and used.

## Entity Level (StoreDTO)

The following keys exist in the API response but are NOT parsed in `StoreDTO.fromJson()`:

- `store_category_type` - Not parsed (exists in constructor parameter but not assigned in fromJson)
- `store_image` - Not parsed (uses `image` instead)
- `is_busy` - Not parsed
- `order_count` - Not parsed (uses `totalOrders` instead)
- `rating` - Not parsed (uses `rate` instead)
- `store_category_name` - Not parsed
- `max_delivery_time` - Not parsed
- `min_delivery_time` - Not parsed
- `rate_count` - Not parsed (hardcoded to 20 in `toEntity()`)
- `is_always_close` - Not parsed
- `address` - Not parsed (commented out)

The following keys are parsed but NOT used in `StoreDTO.toEntity()`:

- `tags` - Parsed but set to `null` in `toEntity()`
- `vendorId` - Parsed but not used in `toEntity()`

Note: Most other fields are parsed and used in `toEntity()`. The `StoreDTO` uses `totalOrders` from
the API (not `order_count`), and `rate` is used. The `storeCategoryType` field exists in the
constructor but is never assigned in `fromJson()`, so it will always be null.

