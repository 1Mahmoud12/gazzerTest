# Unused Keys in Top Vendors Widget API Response

## Root Level

- `pagination` - Not parsed (contains: current_page, total_records, current_records, has_next,
  has_previous, total_pages, per_page)

## Banner Level (in BannerDTO)

The following keys exist in the API response but are NOT parsed in `BannerDTO`:

- `page` - Not parsed
- `bannerable_id` - Not parsed (commented out in BannerDTO)
- `button_displayed` - Not parsed
- `button_text` - Not parsed

## Store Info Level (TopVendorStoreInfoDto)

All keys are parsed in the DTO, but the following are NOT used when converting to `VendorEntity` via
`TopVendorEntityDto.toEntity()`:

- `store_category_id` - Parsed but not used in `toEntity()`
- `store_name` - Parsed but not used in `toEntity()`
- `is_open` - Parsed but not used in `toEntity()`
- `is_busy` - Parsed but not used in `toEntity()`
- `rating` - Parsed but not used in `toEntity()`
- `store_category_name` - Parsed but not used in `toEntity()`
- `work_from` - Parsed but not used in `toEntity()`
- `work_to` - Parsed but not used in `toEntity()`
- `estimated_delivery_time` - Parsed but not used in `toEntity()`

Note: Only `storeId`, `storeCategoryType`, `orderCount`, and `storeImage` from store_info are used
in `VendorEntity`.

