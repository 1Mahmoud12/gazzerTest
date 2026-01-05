import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gazzer/core/presentation/localization/l10n.dart';
import 'package:gazzer/core/presentation/utils/navigate.dart';
import 'package:gazzer/core/presentation/views/components/failure_component.dart';
import 'package:gazzer/core/presentation/views/components/loading_full_screen.dart';
import 'package:gazzer/core/presentation/views/widgets/helper_widgets/alerts.dart';
import 'package:gazzer/core/presentation/views/widgets/helper_widgets/helper_widgets.dart';
import 'package:gazzer/di.dart';
import 'package:gazzer/features/supportScreen/domain/entities/enums_support.dart';
import 'package:gazzer/features/supportScreen/domain/entities/faq_entity.dart';
import 'package:gazzer/features/supportScreen/presentation/chat/views/gazzer_support_chat_screen.dart';
import 'package:gazzer/features/supportScreen/presentation/cubit/faq_cubit.dart';
import 'package:gazzer/features/supportScreen/presentation/cubit/faq_states.dart';
import 'package:gazzer/features/supportScreen/presentation/views/faq_list_screen.dart';
import 'package:gazzer/features/supportScreen/presentation/views/faq_question_answer_screen.dart';
import 'package:gazzer/features/supportScreen/presentation/views/ordersIssueScreens/incorrect_items_screen.dart';

import 'ordersIssueScreens/missing_items_screen.dart';
import 'widgets/order_issue_option_tile.dart';

class OrderIssueScreen extends StatefulWidget {
  const OrderIssueScreen({super.key, this.orderId});

  final int? orderId;

  static const route = '/order-issue';

  @override
  State<OrderIssueScreen> createState() => _OrderIssueScreenState();
}

class _OrderIssueScreenState extends State<OrderIssueScreen> {
  late final FaqCubit cubit;

  @override
  void initState() {
    super.initState();
    cubit = di<FaqCubit>();
    // Load FAQ categories when screen opens
    WidgetsBinding.instance.addPostFrameCallback((_) {
      cubit.getFaqCategories(CategoryType.orderIssue.value, orderId: widget.orderId);
    });
  }

  void _handleCategoryTap(BuildContext context, FaqCategoryEntity category) {
    if (category.typeOrderIssue == OrderIssueType.missing.name) {
      // Navigate to missing items screen
      if (widget.orderId != null) {
        context.navigateToPage(MissingItemsScreen(orderId: widget.orderId!, faqCategoryId: category.id));
      } else {
        Alerts.showToast(L10n.tr().mustChooseOrderFirst);
      }
    } else if (category.typeOrderIssue == OrderIssueType.incorrect.name) {
      // Navigate to missing items screen
      if (widget.orderId != null) {
        context.navigateToPage(IncorrectItemsScreen(orderId: widget.orderId!, faqCategoryId: category.id));
      } else {
        Alerts.showToast(L10n.tr().mustChooseOrderFirst);
      }
    } else if (category.typeOrderIssue == OrderIssueType.chat.name) {
      // Navigate to missing items screen
      if (widget.orderId != null) {
        context.navigateToPage(GazzerSupportChatScreen(orderId: widget.orderId));
      } else {
        Alerts.showToast('Order ID is required');
      }
    } else {
      // Handle chat type - show FAQ flow
      if (category.hasChildren && category.children.isNotEmpty) {
        // Has children: navigate to sub-list
        context.navigateToPage(
          FaqListScreen(
            args: FaqListArgs(title: category.name, categories: category.children, showCategoriesOnly: true),
          ),
        );
      } else if (category.questions.isNotEmpty) {
        // Has questions
        if (category.questions.length == 1) {
          // Single question: open directly
          _showQuestionAndHandleResult(context, category.questions.first, category.id);
        } else {
          // Multiple questions: show list
          context.navigateToPage(
            FaqListScreen(
              args: FaqListArgs(title: category.name, categories: [category]),
            ),
          );
        }
      }
    }
  }

  Future<void> _showQuestionAndHandleResult(BuildContext context, question, int categoryId) async {
    final result =
        await context.navigateToPage(
              FaqQuestionAnswerScreen(
                args: FaqQAArgs(title: question.question, answer: question.answer, faqQuestionId: question.id, faqCategoryId: categoryId),
              ),
            )
            as bool?;

    // Handle yes/no result
    if (result == false && widget.orderId != null) {
      // No - open chat
      context.navigateToPage(GazzerSupportChatScreen(orderId: widget.orderId));
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = L10n.tr();
    return BlocProvider.value(
      value: cubit,
      child: BlocConsumer<FaqCubit, FaqStates>(
        listener: (context, state) {
          if (state is FaqErrorState) {
            Alerts.showToast(state.error);
          }
        },
        builder: (context, state) {
          return LoadingFullScreen(
            isLoading: state is FaqLoadingState,
            child: Scaffold(
              appBar: MainAppBar(title: l10n.orderIssue),

              body: state is FaqSuccessState && state.categories.isNotEmpty
                  ? Padding(
                      padding: const EdgeInsets.all(16),
                      child: ListView.separated(
                        itemCount: state.categories.length,
                        separatorBuilder: (_, __) => const VerticalSpacing(12),
                        itemBuilder: (context, index) {
                          final FaqCategoryEntity category = state.categories[index];
                          return OrderIssueOptionTile(title: category.name, onTap: () => _handleCategoryTap(context, category));
                        },
                      ),
                    )
                  : state is FaqErrorState
                  ? FailureComponent(
                      message: state.error,
                      onRetry: () {
                        cubit.getFaqCategories('order_issue');
                      },
                    )
                  : const SizedBox.shrink(),
            ),
          );
        },
      ),
    );
  }
}
