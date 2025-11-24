import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gazzer/core/presentation/localization/l10n.dart';
import 'package:gazzer/core/presentation/utils/navigate.dart';
import 'package:gazzer/core/presentation/views/components/loading_full_screen.dart';
import 'package:gazzer/core/presentation/views/widgets/helper_widgets/alerts.dart';
import 'package:gazzer/core/presentation/views/widgets/helper_widgets/helper_widgets.dart';
import 'package:gazzer/di.dart';
import 'package:gazzer/features/supportScreen/domain/entities/enums_support.dart';
import 'package:gazzer/features/supportScreen/presentation/cubit/faq_cubit.dart';
import 'package:gazzer/features/supportScreen/presentation/cubit/faq_states.dart';
import 'package:go_router/go_router.dart';

import 'faq_list_screen.dart';
import 'widgets/support_option_tile.dart';

class SupportScreen extends StatefulWidget {
  const SupportScreen({super.key});

  static const route = '/support-screen';

  @override
  State<SupportScreen> createState() => _SupportScreenState();
}

class _SupportScreenState extends State<SupportScreen> {
  String? _pendingType;

  void _handleFaqSuccess(
    BuildContext context,
    FaqSuccessState state,
    String type,
  ) {
    final l10n = L10n.tr();
    if (type == CategoryType.orderIssue.value) {
      // For order-issue, show categories only
      context.navigateToPage(
        FaqListScreen(
          args: FaqListArgs(
            title: l10n.orderIssue,
            categories: state.categories,
            showCategoriesOnly: true,
          ),
        ),
      );
    } else {
      // For general, handle navigation based on structure
      context.navigateToPage(
        FaqListScreen(
          args: FaqListArgs(
            title: l10n.generalIssues,
            categories: state.categories,
            showCategoriesOnly: false,
          ),
        ),
      );
    }
    _pendingType = null;
  }

  @override
  Widget build(BuildContext context) {
    final l10n = L10n.tr();
    return BlocProvider(
      create: (context) => di<FaqCubit>(),
      child: Builder(
        builder: (context) {
          return BlocConsumer<FaqCubit, FaqStates>(
            listener: (context, state) {
              if (state is FaqErrorState) {
                Alerts.showToast(state.error);
                _pendingType = null;
              } else if (state is FaqSuccessState && _pendingType != null) {
                _handleFaqSuccess(context, state, _pendingType!);
              }
            },
            builder: (context, state) {
              return LoadingFullScreen(
                isLoading: state is FaqLoadingState,
                child: Scaffold(
                  appBar: AppBar(
                    title: Text(l10n.support),
                    centerTitle: true,
                  ),
                  body: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        SupportOptionTile(
                          title: l10n.orderIssue,
                          onTap: () async {
                            // _pendingType = 'order_issue';
                            // await context.read<FaqCubit>().getFaqCategories(
                            //   'order_issue',
                            // );
                            context.go(
                              '/orders',
                              extra: {"showGetHelpInsteadOfReorder": true},
                            );
                          },
                        ),
                        const VerticalSpacing(12),
                        SupportOptionTile(
                          title: L10n.tr().generalIssues,
                          onTap: () {
                            _pendingType = CategoryType.general.value;
                            context.read<FaqCubit>().getFaqCategories(
                              CategoryType.general.value,
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
