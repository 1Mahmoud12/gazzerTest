import 'package:flutter/material.dart';
import 'package:gazzer/core/presentation/theme/app_theme.dart';
import 'package:gazzer/core/presentation/utils/navigate.dart';
import 'package:gazzer/core/presentation/views/widgets/helper_widgets/helper_widgets.dart';

import 'faq_list_screen.dart';

class SupportScreen extends StatefulWidget {
  const SupportScreen({super.key});

  static const route = '/support-screen';

  @override
  State<SupportScreen> createState() => _SupportScreenState();
}

class _SupportScreenState extends State<SupportScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Support'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _SupportOptionTile(
              title: 'Order Issue',
              onTap: () {
                // TODO: Implement order-issue flow screen when available.
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Order Issue flow coming soon')),
                );
              },
            ),
            const VerticalSpacing(12),
            _SupportOptionTile(
              title: 'General Issue - Inquiry',
              onTap: () {
                context.navigateToPage(
                  const FaqListScreen(
                    args: FaqListArgs(title: 'General Issue - Inquiry'),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _SupportOptionTile extends StatelessWidget {
  const _SupportOptionTile({required this.title, required this.onTap});

  final String title;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
        decoration: BoxDecoration(
          color: Co.purple100,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          children: [
            Expanded(
              child: Text(
                title,
                style: TStyle.blackMedium(16),
              ),
            ),
            const Icon(Icons.chevron_right, color: Co.purple),
          ],
        ),
      ),
    );
  }
}
