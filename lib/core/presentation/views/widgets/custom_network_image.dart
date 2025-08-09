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
    this.borderRaduis,
    this.isInsta = false,
    this.errorWidget,
    this.alignment = Alignment.center,
    this.opacity,
  });
  final String imageUrl;
  final double? height;
  final double? width;
  final BoxFit? fit;
  final BlendMode? blendMode;
  final double? borderRaduis;
  final bool isInsta;
  final AlignmentGeometry alignment;
  final Widget? errorWidget;
  final double? opacity;
  @override
  Widget build(BuildContext context) {
    Widget child;
    final errorShown = SizedBox(
      width: width ?? 42,
      child:
          errorWidget ??
          ColoredBox(
            color: Colors.grey.shade200,
            child: const Icon(
              Icons.broken_image,
              color: Colors.grey,
              size: 42,
            ),
          ),
    );
    if (imageUrl.endsWith('svg')) {
      child = SvgPicture.network(
        imageUrl,
        height: height,
        width: width,
        alignment: alignment,
        fit: fit ?? BoxFit.cover,
        // ignore: avoid_print
        errorBuilder: (context, url, error) {
          return errorShown;
        },
      );
    } else {
      child = CachedNetworkImage(
        imageUrl: imageUrl,
        imageBuilder: (context, imageProvider) => Image(
          image: imageProvider,
          height: height,
          width: width,
          fit: fit ?? BoxFit.cover,
          alignment: alignment,
          colorBlendMode: blendMode,
          opacity: AlwaysStoppedAnimation(opacity ?? 1.0),
        ),
        // ignore: avoid_print
        errorListener: (value) => debugPrint(value.toString()),
        errorWidget: (context, url, error) {
          return errorShown;
        },
      );
    }
    return ClipRRect(
      borderRadius: BorderRadius.circular(borderRaduis ?? 0),
      child: isInsta ? InstaImageViewer(imageUrl: imageUrl, child: child) : child,
    );
  }
}
