import 'package:flutter/material.dart';
import 'package:vector_graphics/vector_graphics.dart';

/// A widget that displays vector graphics, similar to SvgPicture.asset
/// This is a drop-in replacement for SvgPicture.asset when using vector_graphics
///
/// Usage:
/// ```dart
/// VectorGraphicsWidget('assets/svg/icon.vg', width: 24, height: 24)
/// ```
///
/// Note: SVG files should be converted to .vg format using vector_graphics_compiler
/// For network SVGs, continue using flutter_svg's SvgPicture.network
class VectorGraphicsWidget extends StatelessWidget {
  const VectorGraphicsWidget(
    this.assetPath, {
    super.key,
    this.width,
    this.height,
    this.fit = BoxFit.contain,
    this.alignment = Alignment.center,
    this.colorFilter,
    this.placeholderBuilder,
  });

  final String assetPath;
  final double? width;
  final double? height;
  final BoxFit fit;
  final AlignmentGeometry alignment;
  final ColorFilter? colorFilter;
  final WidgetBuilder? placeholderBuilder;

  /// Convert .svg path to .vg path
  /// During migration, assets might still have .svg extension
  static String _getVectorPath(String path) {
    if (path.endsWith('.svg')) {
      return path.replaceAll('.svg', '.vg');
    }
    return path;
  }

  @override
  Widget build(BuildContext context) {
    final vectorPath = _getVectorPath(assetPath);

    return VectorGraphic(
      loader: AssetBytesLoader(vectorPath),
      width: width,
      height: height,
      fit: fit,
      alignment: alignment,
      colorFilter: colorFilter,
      placeholderBuilder: placeholderBuilder ?? (context) => SizedBox(width: width, height: height),
    );
  }
}

/// Helper function to create a VectorGraphics widget from asset
/// Similar to SvgPicture.asset but uses vector_graphics
///
/// Example:
/// ```dart
/// vectorAsset('assets/svg/icon.svg', width: 24, height: 24, colorFilter: ColorFilter.mode(Colors.red, BlendMode.srcIn))
/// ```
VectorGraphicsWidget vectorAsset(
  String assetPath, {
  Key? key,
  double? width,
  double? height,
  BoxFit fit = BoxFit.contain,
  AlignmentGeometry alignment = Alignment.center,
  ColorFilter? colorFilter,
  WidgetBuilder? placeholderBuilder,
}) {
  return VectorGraphicsWidget(
    assetPath,
    key: key,
    width: width,
    height: height,
    fit: fit,
    alignment: alignment,
    colorFilter: colorFilter,
    placeholderBuilder: placeholderBuilder,
  );
}
