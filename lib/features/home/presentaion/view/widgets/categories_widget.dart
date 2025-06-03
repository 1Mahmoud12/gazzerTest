import 'package:flutter/material.dart';
import 'package:gazzer/core/presentation/theme/app_theme.dart';
import 'package:gazzer/features/home/presentaion/view/widgets/category_item.dart';

class CategoriesWidget extends StatelessWidget {
  const CategoriesWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 12,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Categories", style: TStyle.primaryBold(20)),
            TextButton(onPressed: () {}, child: Text("View All")),
          ],
        ),
        GridView.builder(
          padding: EdgeInsets.all(0),
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 90,
            mainAxisSpacing: 18,
            crossAxisSpacing: 18,
            childAspectRatio: 0.58,
          ),
          itemCount: 12,
          itemBuilder: (context, index) {
            return const CategoryItem();
          },
        ),
      ],
    );
  }
}
