import 'package:flutter/material.dart';
import 'package:gazzer/core/data/network/result_model.dart';
import 'package:gazzer/core/presentation/localization/l10n.dart';
import 'package:gazzer/core/presentation/utils/navigate.dart';
import 'package:gazzer/core/presentation/views/components/loading_full_screen.dart';
import 'package:gazzer/core/presentation/views/widgets/helper_widgets/alerts.dart';
import 'package:gazzer/core/presentation/views/widgets/helper_widgets/helper_widgets.dart';
import 'package:gazzer/di.dart';
import 'package:gazzer/features/supportScreen/domain/entities/faq_entity.dart';
import 'package:gazzer/features/supportScreen/domain/faq_repo.dart';

import 'faq_list_screen.dart';
import 'widgets/support_option_tile.dart';

class SupportScreen extends StatefulWidget {
  const SupportScreen({super.key});

  static const route = '/support-screen';

  @override
  State<SupportScreen> createState() => _SupportScreenState();
}

class _SupportScreenState extends State<SupportScreen> {
  bool _isLoading = false;
  final _faqRepo = di<FaqRepo>();

  Future<void> _loadFaqCategories(String type) async {
    setState(() => _isLoading = true);
    final result = await _faqRepo.getFaqCategories(type);
    setState(() => _isLoading = false);

    if (!mounted) return;

    switch (result) {
      case Ok<List<FaqCategoryEntity>> ok:
        final categories = ok.value;
        if (type == 'order_issue') {
          // For order-issue, show categories only
          context.navigateToPage(
            FaqListScreen(
              args: FaqListArgs(
                title: L10n.tr().orderIssue,
                categories: categories,
                showCategoriesOnly: true,
              ),
            ),
          );
        } else {
          // For general, handle navigation based on structure
          context.navigateToPage(
            FaqListScreen(
              args: FaqListArgs(
                title: 'General Issue - Inquiry',
                categories: categories,
                showCategoriesOnly: false,
              ),
            ),
          );
        }
        break;
      case Err<List<FaqCategoryEntity>> err:
        Alerts.showToast(err.error.message);
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = L10n.tr();
    return LoadingFullScreen(
      isLoading: _isLoading,
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
                onTap: () {
                  _loadFaqCategories('order_issue');
                },
              ),
              const VerticalSpacing(12),
              SupportOptionTile(
                title: 'General Issue - Inquiry',
                onTap: () {
                  _loadFaqCategories('general');
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
