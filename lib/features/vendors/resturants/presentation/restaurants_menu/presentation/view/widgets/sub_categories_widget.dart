import 'package:flutter/material.dart';
import 'package:gazzer/core/presentation/extensions/context.dart';
import 'package:gazzer/core/presentation/pkgs/gradient_border/box_borders/gradient_box_border.dart';
import 'package:gazzer/core/presentation/resources/app_const.dart';
import 'package:gazzer/core/presentation/theme/app_theme.dart';
import 'package:gazzer/core/presentation/views/widgets/helper_widgets/spacing.dart';
import 'package:gazzer/core/presentation/views/widgets/products/circle_gradient_image.dart';

class SubCategoriesWidget extends StatelessWidget {
  const SubCategoriesWidget({super.key, required this.selectedId, required this.onSubCategorySelected, required this.subCategories});
  final int selectedId;
  final Function(int index) onSubCategorySelected;
  final List<({String name, String image, int id, bool isAdd})> subCategories;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 48,
      child: ListView.separated(
        padding: AppConst.defaultHrPadding,
        scrollDirection: Axis.horizontal,
        itemCount: subCategories.length,
        separatorBuilder: (context, index) => subCategories[index].isAdd ? const SizedBox.shrink() : const HorizontalSpacing(12),
        itemBuilder: (context, index) {
          if (subCategories[index].isAdd) {
            print('SubCategoriesWidget: Skipping index $index as it is an add index');
            return const SizedBox.shrink();
          }
          return SubCategoryItem(
            name: subCategories[index].name,
            image: subCategories[index].image,
            isSelected: subCategories[index].id == selectedId,
            ontap: () => onSubCategorySelected(index),
          );
        },
      ),
    );
  }
}

class SubCategoryItem extends StatelessWidget {
  const SubCategoryItem({super.key, required this.name, required this.isSelected, required this.ontap, required this.image});
  final String name;
  final String image;
  final bool isSelected;
  final Function()? ontap;
  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: AppConst.defaultInnerBorderRadius,
        border: GradientBoxBorder(gradient: Grad().bgLinear, width: 2),
        // color: isSelected ? null : Co.bg,
        gradient: isSelected ? Grad().bglightLinear : null,
      ),
      child: ElevatedButton(
        onPressed: ontap,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          minimumSize: Size.zero,
          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          shadowColor: Colors.transparent,
          shape: RoundedRectangleBorder(borderRadius: AppConst.defaultInnerBorderRadius),
          padding: EdgeInsets.zero,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            CircleGradientBorderedImage(image: image),

            Padding(
              padding: AppConst.defaultHrPadding,
              child: Text(name, style: context.style14400),
            ),
          ],
        ),
      ),
    );
  }
}
