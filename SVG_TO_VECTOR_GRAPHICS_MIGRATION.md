# Migrating from flutter_svg to vector_graphics

This guide explains how to migrate from `flutter_svg` to `vector_graphics` in your Flutter app.

## Why Migrate?

- **Better Performance**: Vector graphics are pre-compiled and rendered more efficiently
- **Smaller Bundle Size**: Compiled .vg files are typically smaller than SVG files
- **Type Safety**: Better integration with Flutter's build system

## Migration Steps

### 1. Convert SVG Files to .vg Format

First, convert all your SVG files to .vg format using the conversion script:

```bash
dart run scripts/convert_svg_to_vg.dart
```

This will:

- Find all `.svg` files in `assets/svg/`
- Convert them to `.vg` format using `vector_graphics_compiler`
- Place the `.vg` files next to their corresponding `.svg` files

**Alternative: Manual Conversion**

You can also convert individual files manually:

```bash
dart run vector_graphics_compiler assets/svg/soldCartIc.svg -o assets/svg/soldCartIc.vg
```

### 2. Update Imports

Replace `flutter_svg` imports with the vector_graphics widget:

**Before:**

```dart
import 'package:flutter_svg/svg.dart';

// or
import 'package:flutter_svg/flutter_svg.dart';
```

**After:**

```dart
import 'package:gazzer/core/presentation/views/widgets/vector_graphics_widget.dart';
```

### 3. Replace SvgPicture.asset with VectorGraphicsWidget

**Before:**

```dart
SvgPicture.asset
('assets/svg/icon.svg
'
,width: 24,
height: 24,
colorFilter: ColorFilter.mode(Colors.red, BlendMode.srcIn)
,
)
```

**After:**

```dart
VectorGraphicsWidget
('assets/svg/icon.svg
'
, // Can use .svg path, will automatically use .vg
width: 24,
height: 24,
colorFilter: ColorFilter.mode(Colors.red, BlendMode.srcIn)
,
)
```

**Or use the helper function:**

```dart
vectorAsset
('assets/svg/icon.svg
'
,width: 24,
height: 24,
colorFilter: ColorFilter.mode(Colors.red, BlendMode.srcIn)
,
)
```

### 4. Handle Network SVGs

**Important**: `vector_graphics` does not support network SVGs directly. For network SVGs, you have
two options:

**Option A: Keep using flutter_svg for network SVGs** (Recommended)

```dart
import 'package:flutter_svg/flutter_svg.dart'; // Keep this import

// For network SVGs, continue using SvgPicture.network
if (
imageUrl.endsWith('svg')) {
child = SvgPicture.network(
imageUrl,
width: width,
height: height,
);
} else {
// Use VectorGraphicsWidget for assets
child = VectorGraphicsWidget(assetPath, width: width, height: height);
}
```

**Option B: Download and cache network SVGs first**

Convert network SVGs to .vg format and cache them locally, then use VectorGraphicsWidget.

### 5. Update pubspec.yaml

The `pubspec.yaml` has already been updated to include `.vg` files:

```yaml
assets:
  - assets/svg/
  - assets/svg/**/*.vg  # Include all .vg files
```

### 6. Remove flutter_svg (Optional)

Once you've migrated all asset-based SVGs, you can optionally remove `flutter_svg` from
`pubspec.yaml` **if** you're no longer using `SvgPicture.network`:

```yaml
dependencies:
# flutter_svg: ^2.2.1  # Remove this line if not using SvgPicture.network
```

**Note**: If you're still using `SvgPicture.network` for network SVGs, keep `flutter_svg` in your
dependencies.

## Migration Checklist

- [ ] Convert all SVG files to .vg format
- [ ] Update all imports from `flutter_svg` to `vector_graphics_widget`
- [ ] Replace all `SvgPicture.asset` with `VectorGraphicsWidget`
- [ ] Handle network SVGs (keep using `SvgPicture.network` or implement caching)
- [ ] Update `pubspec.yaml` to include `.vg` files
- [ ] Test all screens that use SVG icons
- [ ] Optionally remove `flutter_svg` if no longer needed

## Common Patterns

### With Color Filter

```dart
VectorGraphicsWidget
(
Assets.assetsSvgCart,
width: 24,
height: 24,
colorFilter: ColorFilter.mode(Colors.white,
BlendMode
.
srcIn
)
,
)
```

### Without Size Constraints

```dart
VectorGraphicsWidget
(
Assets.assetsSvgNotification,
fit: BoxFit.contain,
)
```

### In Conditional Rendering

```dart
child: imagePath.endsWith
('svg
'
)
? VectorGraphicsWidget(imagePath, height: 150, fit: BoxFit.contain)
    : Image.asset(imagePath, height: 150, fit: BoxFit.contain),
```

## Troubleshooting

### Error: "Unable to load asset"

- Ensure the `.vg` file exists next to the `.svg` file
- Check that `pubspec.yaml` includes `assets/svg/**/*.vg`
- Run `flutter pub get` and rebuild the app

### VectorGraphicsWidget shows nothing

- Verify the SVG was successfully converted to .vg format
- Check the console for error messages
- Ensure the asset path is correct

### Network SVGs not working

- Use `SvgPicture.network` for network SVGs (vector_graphics doesn't support network assets)
- Or implement a caching/download mechanism to convert network SVGs to local .vg files

## Performance Benefits

After migration, you should see:

- Faster initial render times for vector graphics
- Reduced app bundle size
- Smoother animations with vector graphics
- Better memory efficiency

