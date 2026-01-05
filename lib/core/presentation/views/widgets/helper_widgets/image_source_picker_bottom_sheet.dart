import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gazzer/core/presentation/localization/l10n.dart';
import 'package:gazzer/core/presentation/resources/assets.dart';
import 'package:gazzer/core/presentation/theme/app_theme.dart';
import 'package:gazzer/core/presentation/views/widgets/helper_widgets/alerts.dart';
import 'package:gazzer/core/presentation/views/widgets/helper_widgets/helper_widgets.dart';
import 'package:gazzer/core/presentation/views/widgets/vector_graphics_widget.dart';
import 'package:image_picker/image_picker.dart';

/// Shows a bottom sheet for selecting image source (Gallery or Camera)
///
/// Example usage:
/// ```dart
/// final file = await ImageSourcePickerBottomSheet.show(
///   context: context,
/// );
/// if (file != null) {
///   // Handle the selected file
/// }
/// ```
class ImageSourcePickerBottomSheet {
  /// Shows the image source picker bottom sheet
  /// Returns the selected File, or null if cancelled or no file selected
  static Future<File?> show({required BuildContext context}) async {
    final file = await showModalBottomSheet(context: context, backgroundColor: Colors.transparent, builder: (context) => const SelectImageDialog());
    return file;
  }
}

class SelectImageDialog extends StatefulWidget {
  const SelectImageDialog({super.key});

  @override
  State<SelectImageDialog> createState() => _SelectImageDialogState();
}

class _SelectImageDialogState extends State<SelectImageDialog> {
  File? selectedFile;
  final ImagePicker imagePicker = ImagePicker();

  Future<File?> pickImageFromGallery() async {
    try {
      final XFile? image = await imagePicker.pickImage(source: ImageSource.gallery, imageQuality: 80);
      if (image != null) {
        return File(image.path);
      }
      return null;
    } catch (e) {
      Alerts.showToast(L10n.tr().errorTakingPhoto);
      return null;
    }
  }

  Future<File?> pickImageFromCamera() async {
    try {
      final XFile? image = await imagePicker.pickImage(source: ImageSource.camera, imageQuality: 80);
      if (image != null) {
        return File(image.path);
      }
      return null;
    } catch (e) {
      Alerts.showToast(L10n.tr().errorTakingPhoto);
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Top card with options
            Container(
              decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12)),
              child: Column(
                children: [
                  InkWell(
                    onTap: () async {
                      final file = await pickImageFromGallery();
                      if (context.mounted) {
                        Navigator.pop(context, file);
                      }
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const VectorGraphicsWidget(Assets.galleryIc),
                          const HorizontalSpacing(16),
                          Text(L10n.tr().gallery, style: TStyle.robotBlackMedium()),
                        ],
                      ),
                    ),
                  ),
                  const Divider(height: 1),
                  InkWell(
                    onTap: () async {
                      final file = await pickImageFromCamera();
                      if (context.mounted) {
                        Navigator.pop(context, file);
                      }
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SvgPicture.asset(Assets.cameraIc),
                          const HorizontalSpacing(16),
                          Text(L10n.tr().camera, style: TStyle.robotBlackMedium()),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 8),
            // Bottom card with cancel button
            Container(
              decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12)),
              child: ListTile(
                title: Text(
                  L10n.tr().cancel,
                  textAlign: TextAlign.center,
                  style: TStyle.robotBlackRegular().copyWith(color: Co.purple),
                ),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
