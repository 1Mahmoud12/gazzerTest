import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gazzer/core/presentation/extensions/color.dart';
import 'package:gazzer/core/presentation/localization/l10n.dart';
import 'package:gazzer/core/presentation/resources/assets.dart';
import 'package:gazzer/core/presentation/theme/app_theme.dart';
import 'package:gazzer/core/presentation/views/widgets/helper_widgets/image_source_picker_bottom_sheet.dart';

class ChatInputField extends StatefulWidget {
  final Function(String) onSendMessage;
  final Function({required File image}) onPickImageOrCamera;
  final bool isSending;
  final String? imagePreviewPath;
  final VoidCallback onRemoveImage;

  const ChatInputField({
    super.key,
    required this.onSendMessage,
    required this.onPickImageOrCamera,
    required this.isSending,
    this.imagePreviewPath,
    required this.onRemoveImage,
  });

  @override
  State<ChatInputField> createState() => _ChatInputFieldState();
}

class _ChatInputFieldState extends State<ChatInputField> {
  final TextEditingController _controller = TextEditingController();
  bool _hasText = false;

  @override
  void initState() {
    super.initState();
    _controller.addListener(() {
      setState(() {
        _hasText = _controller.text.trim().isNotEmpty;
      });
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _handleSend() {
    if (widget.isSending) return;

    final text = _controller.text.trim();
    if (text.isEmpty && widget.imagePreviewPath == null) return;

    widget.onSendMessage(text);
    _controller.clear();
  }

  Future<File?> _showImageSourceDialog() async {
    return ImageSourcePickerBottomSheet.show(context: context);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [BoxShadow(color: Colors.black.withOpacityNew(0.05), offset: const Offset(0, -2), blurRadius: 8)],
      ),
      child: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Image Preview
            if (widget.imagePreviewPath != null)
              Container(
                margin: const EdgeInsets.all(12),
                child: Stack(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.file(File(widget.imagePreviewPath!), height: 160, width: double.infinity, fit: BoxFit.fill),
                    ),
                    Positioned(
                      top: 4,
                      right: 4,
                      child: GestureDetector(
                        onTap: widget.onRemoveImage,
                        child: Container(
                          padding: const EdgeInsets.all(4),
                          decoration: const BoxDecoration(color: Colors.black54, shape: BoxShape.circle),
                          child: const Icon(Icons.close, color: Colors.white, size: 16),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            // Input Field
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              child: Row(
                children: [
                  // Add Image Button
                  GestureDetector(
                    onTap: widget.isSending
                        ? null
                        : () async {
                            final result = await _showImageSourceDialog();
                            if (result != null) {
                              widget.onPickImageOrCamera(image: result);
                            }
                          },
                    child: Container(
                      width: 44,
                      height: 44,
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(color: widget.isSending ? Colors.grey : Co.purple, shape: BoxShape.circle),
                      child: SvgPicture.asset(Assets.addImageIc),
                    ),
                  ),
                  const SizedBox(width: 12),
                  // Text Field
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      decoration: BoxDecoration(color: const Color(0xFFF5F5F5), borderRadius: BorderRadius.circular(24)),
                      child: TextField(
                        controller: _controller,
                        enabled: !widget.isSending,
                        maxLines: null,
                        textInputAction: TextInputAction.newline,
                        decoration: InputDecoration(
                          hintText: L10n.tr().typeMessage,
                          hintStyle: TStyle.blackRegular(14).copyWith(color: Colors.black38),
                          border: InputBorder.none,
                          contentPadding: const EdgeInsets.symmetric(vertical: 12),
                        ),
                        style: TStyle.blackRegular(14),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  // Send Button
                  GestureDetector(
                    onTap: (_hasText || widget.imagePreviewPath != null) && !widget.isSending ? _handleSend : null,
                    child: Container(
                      width: 44,
                      height: 44,
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: (_hasText || widget.imagePreviewPath != null) ? Co.purple : Colors.grey.shade300,
                        shape: BoxShape.circle,
                      ),
                      child: widget.isSending
                          ? const SizedBox(
                              width: 20,
                              height: 20,
                              child: CircularProgressIndicator(strokeWidth: 2, valueColor: AlwaysStoppedAnimation<Color>(Colors.white)),
                            )
                          : SvgPicture.asset(
                              Assets.sendMessageIc,
                              colorFilter: ColorFilter.mode(
                                (_hasText || widget.imagePreviewPath != null) ? Colors.white : Colors.grey.shade500,
                                BlendMode.srcIn,
                              ),
                            ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
