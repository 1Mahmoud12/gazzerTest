import 'package:flutter/material.dart';
import 'package:gazzer/core/presentation/theme/app_theme.dart';
import 'package:gazzer/core/presentation/utils/navigate.dart';
import 'package:gazzer/core/presentation/views/widgets/helper_widgets/helper_widgets.dart';

import 'faq_question_answer_screen.dart';

class FaqListArgs {
  const FaqListArgs({required this.title, this.nodes});

  final String title;
  final List<FaqNode>? nodes;
}

class FaqListScreen extends StatelessWidget {
  const FaqListScreen({super.key, required this.args});

  static const route = '/faq-list';

  final FaqListArgs args;

  List<FaqNode> get _sampleData => const [
    FaqNode(
      title: 'Payment methods didn\'t work',
      children: [
        FaqNode(
          title: 'Check your payment method',
          answer: 'Make sure you\'re using a supported card or payment option in your region.',
        ),
        FaqNode(
          title: 'Verify your details',
          answer: 'Ensure your card number, expiry date, and CVV are entered correctly, and the card has sufficient balance.',
        ),
        FaqNode(
          title: 'Try a different method',
          answer: 'If the issue continues, you can try another card or choose Cash on Delivery.',
        ),
      ],
    ),
    FaqNode(title: 'Is there a delivery fee?', answer: 'Delivery fee varies based on your area and the store.'),
    FaqNode(title: 'How do I place an order?', answer: 'Browse items, add to cart, and proceed to checkout.'),
    FaqNode(title: 'Can I track my order in real time?', answer: 'Yes, you can track your order status from the orders page.'),
  ];

  @override
  Widget build(BuildContext context) {
    final nodes = args.nodes ?? _sampleData;
    return Scaffold(
      appBar: AppBar(
        title: Text(args.title),
        centerTitle: true,
      ),
      body: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: nodes.length,
        separatorBuilder: (_, __) => const VerticalSpacing(12),
        itemBuilder: (context, index) {
          final node = nodes[index];
          return InkWell(
            onTap: () {
              if (node.isLeaf) {
                context.navigateToPage(
                  FaqQuestionAnswerScreen(
                    args: FaqQAArgs(title: node.title, answer: node.answer ?? ''),
                  ),
                );
              } else {
                context.navigateToPage(
                  FaqListScreen(
                    args: FaqListArgs(title: node.title, nodes: node.children),
                  ),
                );
              }
            },
            borderRadius: BorderRadius.circular(16),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              decoration: BoxDecoration(
                color: Co.purple100,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Row(
                children: [
                  Expanded(child: Text(node.title, style: TStyle.blackMedium(15))),
                  const Icon(Icons.chevron_right, color: Co.purple),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class FaqNode {
  const FaqNode({required this.title, this.answer, this.children = const []});

  final String title;
  final String? answer;
  final List<FaqNode> children;

  bool get isLeaf => answer != null;
}
