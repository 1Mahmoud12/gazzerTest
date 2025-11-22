import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gazzer/core/presentation/localization/l10n.dart';
import 'package:gazzer/core/presentation/pkgs/dialog_loading_animation.dart';
import 'package:gazzer/features/supportScreen/presentation/chat/cubit/chat_cubit.dart';
import 'package:gazzer/features/supportScreen/presentation/chat/cubit/chat_states.dart';
import 'package:gazzer/features/supportScreen/presentation/chat/widgets/chat_app_bar.dart';
import 'package:gazzer/features/supportScreen/presentation/chat/widgets/chat_input_field.dart';
import 'package:gazzer/features/supportScreen/presentation/chat/widgets/chat_message_bubble.dart';

class GazzerSupportChatScreen extends StatefulWidget {
  const GazzerSupportChatScreen({super.key});

  static const route = '/gazzer-support-chat';

  @override
  State<GazzerSupportChatScreen> createState() => _GazzerSupportChatScreenState();
}

class _GazzerSupportChatScreenState extends State<GazzerSupportChatScreen> {
  final ScrollController _scrollController = ScrollController();

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollToBottom() {
    if (_scrollController.hasClients) {
      Future.delayed(const Duration(milliseconds: 100), () {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ChatCubit(),
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: const ChatAppBar(),
        body: BlocConsumer<ChatCubit, ChatStates>(
          listener: (context, state) {
            if (state is ChatLoadedState) {
              _scrollToBottom();
            }
          },
          builder: (context, state) {
            if (state is ChatLoadingState) {
              return const Center(
                child: LoadingWidget(),
              );
            }

            if (state is ChatErrorState) {
              return Center(
                child: Text(
                  state.error,
                  style: const TextStyle(color: Colors.red),
                ),
              );
            }

            if (state is ChatLoadedState) {
              return Column(
                children: [
                  // Messages List
                  Expanded(
                    child: state.messages.isEmpty
                        ? Center(
                            child: Text(
                              L10n.tr().noMessagesYet,
                              style: TextStyle(
                                color: Colors.grey.shade500,
                                fontSize: 16,
                              ),
                            ),
                          )
                        : ListView.builder(
                            controller: _scrollController,
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            itemCount: state.messages.length,
                            itemBuilder: (context, index) {
                              final message = state.messages[index];
                              return ChatMessageBubble(message: message);
                            },
                          ),
                  ),
                  // Input Field
                  ChatInputField(
                    onSendMessage: (text) {
                      context.read<ChatCubit>().sendMessage(text);
                    },
                    onPickImage: () {
                      context.read<ChatCubit>().pickImageFromGallery();
                    },
                    onPickCamera: () {
                      context.read<ChatCubit>().pickImageFromCamera();
                    },
                    isSending: state.isSending,
                    imagePreviewPath: state.imagePreviewPath,
                    onRemoveImage: () {
                      context.read<ChatCubit>().removeImagePreview();
                    },
                  ),
                ],
              );
            }

            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}
