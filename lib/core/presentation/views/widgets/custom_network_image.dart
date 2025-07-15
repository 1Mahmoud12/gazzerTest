import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gazzer/core/presentation/views/widgets/products/insta_image_viewer.dart';

class CustomNetworkImage extends StatelessWidget {
  const CustomNetworkImage(
    this.imageUrl, {
    super.key,
    this.height,
    this.width,
    this.fit,
    this.blendMode,
    this.borderReduis,
    this.isInsta = false,
    this.errorWidget,
    this.alignment = Alignment.center,
  });
  final String imageUrl;
  final double? height;
  final double? width;
  final BoxFit? fit;
  final BlendMode? blendMode;
  final double? borderReduis;
  final bool isInsta;
  final AlignmentGeometry alignment;
  final Widget? errorWidget;
  @override
  Widget build(BuildContext context) {
    Widget child;
    if (imageUrl.endsWith('svg')) {
      child = SvgPicture.network(
        imageUrl,
        height: height,
        width: width,
        alignment: alignment,
        fit: fit ?? BoxFit.cover,
        // ignore: avoid_print
        errorBuilder: (context, url, error) {
          return errorWidget ??
              ColoredBox(
                color: Colors.grey.shade200,
                child: Icon(
                  Icons.image,
                  color: Colors.black,
                  size: (height ?? width ?? 100) * 0.5,
                ),
              );
        },
      );
    } else {
      child = CachedNetworkImage(
        imageUrl: imageUrl,
        height: height,
        width: width,
        fit: fit ?? BoxFit.cover,
        colorBlendMode: blendMode,
        // ignore: avoid_print
        errorListener: (value) => debugPrint(value.toString()),
        errorWidget: (context, url, error) {
          return errorWidget ??
              ColoredBox(
                color: Colors.grey.shade200,
                child: Icon(
                  Icons.image,
                  color: Colors.black,
                  size: (height ?? width ?? 100) * 0.5,
                ),
              );
        },
      );
    }
    return ClipRRect(
      borderRadius: BorderRadius.circular(borderReduis ?? 0),
      child: isInsta ? InstaImageViewer(imageUrl: imageUrl, child: child) : child,
    );
  }
}
