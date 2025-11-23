import 'package:flutter/material.dart';
import 'package:gazzer/core/presentation/theme/app_theme.dart';
import 'package:gazzer/core/presentation/utils/navigate.dart';
import 'package:gazzer/core/presentation/views/widgets/helper_widgets/helper_widgets.dart';
import 'package:gazzer/features/supportScreen/domain/entities/faq_entity.dart';

import 'faq_question_answer_screen.dart';

class FaqListArgs {
  const FaqListArgs({
    required this.title,
    this.nodes,
    this.categories,
    this.showCategoriesOnly = false,
  });

  final String title;
  final List<FaqNode>? nodes;
  final List<FaqCategoryEntity>? categories;
  final bool showCategoriesOnly;
}

class FaqListScreen extends StatelessWidget {
  const FaqListScreen({super.key, required this.args});

  static const route = '/faq-list';

  final FaqListArgs args;

  List<FaqNode> _convertCategoriesToNodes(List<FaqCategoryEntity> categories, bool showCategoriesOnly) {
    return categories.map((category) {
      if (showCategoriesOnly) {
        // For order-issue: show categories only
        return FaqNode(
          title: category.name,
          children: _convertCategoriesToNodes(category.children, showCategoriesOnly),
        );
      } else {
        // For general: handle based on structure
        if (category.hasChildren && category.children.isNotEmpty) {
          // Has children: create node with children
          return FaqNode(
            title: category.name,
            children: _convertCategoriesToNodes(category.children, showCategoriesOnly),
          );
        } else if (category.questions.isNotEmpty) {
          // Has questions: create nodes for questions
          if (category.questions.length == 1) {
            // Single question: return leaf node (will be handled in navigation)
            return FaqNode(
              title: category.questions.first.question,
              answer: category.questions.first.answer,
            );
          } else {
            // Multiple questions: create parent node with question children
            return FaqNode(
              title: category.name,
              children: category.questions.map((q) => FaqNode(title: q.question, answer: q.answer)).toList(),
            );
          }
        } else {
          // Empty category
          return FaqNode(title: category.name);
        }
      }
    }).toList();
  }

  List<FaqNode> _getItemsToDisplay() {
    if (args.categories != null) {
      return _convertCategoriesToNodes(args.categories!, args.showCategoriesOnly);
    }
    return args.nodes ?? [];
  }

  void _handleItemTap(BuildContext context, FaqNode node) {
    if (args.categories != null && !args.showCategoriesOnly) {
      // Handle API-based navigation for general type
      _handleApiBasedNavigation(context, node);
    } else {
      // Handle legacy node-based navigation
      _handleNodeBasedNavigation(context, node);
    }
  }

  void _handleApiBasedNavigation(BuildContext context, FaqNode node) {
    if (node.isLeaf) {
      // Direct question: open answer screen
      context.navigateToPage(
        FaqQuestionAnswerScreen(
          args: FaqQAArgs(title: node.title, answer: node.answer ?? ''),
        ),
      );
    } else if (node.children.isNotEmpty) {
      // Has children: navigate to sub-list
      context.navigateToPage(
        FaqListScreen(
          args: FaqListArgs(
            title: node.title,
            nodes: node.children,
            showCategoriesOnly: false,
          ),
        ),
      );
    }
  }

  void _handleNodeBasedNavigation(BuildContext context, FaqNode node) {
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
  }

  void _handleCategoryTap(BuildContext context, FaqCategoryEntity category) {
    if (args.showCategoriesOnly) {
      // For order-issue: show categories only
      if (category.children.isNotEmpty) {
        context.navigateToPage(
          FaqListScreen(
            args: FaqListArgs(
              title: category.name,
              categories: category.children,
              showCategoriesOnly: true,
            ),
          ),
        );
      }
    } else {
      // For general: handle based on structure
      if (category.hasChildren && category.children.isNotEmpty) {
        // Has children: navigate to children
        context.navigateToPage(
          FaqListScreen(
            args: FaqListArgs(
              title: category.name,
              categories: category.children,
              showCategoriesOnly: false,
            ),
          ),
        );
      } else if (category.questions.isNotEmpty) {
        // Has questions
        if (category.questions.length == 1) {
          // Single question: open directly
          context.navigateToPage(
            FaqQuestionAnswerScreen(
              args: FaqQAArgs(
                title: category.questions.first.question,
                answer: category.questions.first.answer,
              ),
            ),
          );
        } else {
          // Multiple questions: show list
          context.navigateToPage(
            FaqListScreen(
              args: FaqListArgs(
                title: category.name,
                nodes: category.questions.map((q) => FaqNode(title: q.question, answer: q.answer)).toList(),
                showCategoriesOnly: false,
              ),
            ),
          );
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    // If we have categories directly, use them for better control
    if (args.categories != null && args.categories!.isNotEmpty) {
      return Scaffold(
        appBar: AppBar(
          title: Text(args.title),
          centerTitle: true,
        ),
        body: ListView.separated(
          padding: const EdgeInsets.all(16),
          itemCount: args.categories!.length,
          separatorBuilder: (_, _) => const VerticalSpacing(12),
          itemBuilder: (context, index) {
            final category = args.categories![index];
            return InkWell(
              onTap: () => _handleCategoryTap(context, category),
              borderRadius: BorderRadius.circular(16),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                decoration: BoxDecoration(
                  color: Co.purple100,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Row(
                  children: [
                    Expanded(child: Text(category.name, style: TStyle.blackMedium(15))),
                    const Icon(Icons.chevron_right, color: Co.purple),
                  ],
                ),
              ),
            );
          },
        ),
      );
    }

    // Fallback to node-based display
    final items = _getItemsToDisplay();
    return Scaffold(
      appBar: AppBar(
        title: Text(args.title),
        centerTitle: true,
      ),
      body: items.isEmpty
          ? const Center(child: Text('No items available'))
          : ListView.separated(
              padding: const EdgeInsets.all(16),
              itemCount: items.length,
              separatorBuilder: (_, _) => const VerticalSpacing(12),
              itemBuilder: (context, index) {
                final node = items[index];
                return InkWell(
                  onTap: () => _handleItemTap(context, node),
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
