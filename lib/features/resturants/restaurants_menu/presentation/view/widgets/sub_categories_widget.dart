import 'package:flutter/material.dart';
import 'package:gazzer/core/data/fakers.dart';
import 'package:gazzer/core/presentation/pkgs/gradient_border/box_borders/gradient_box_border.dart';
import 'package:gazzer/core/presentation/resources/app_const.dart';
import 'package:gazzer/core/presentation/theme/app_theme.dart';
import 'package:gazzer/core/presentation/views/widgets/helper_widgets/spacing.dart';
import 'package:gazzer/core/presentation/views/widgets/products/circle_gradient_image.dart';
import 'package:gazzer/features/resturants/restaurants_menu/data/subcategory_model.dart';

class SubCategoriesWidget extends StatelessWidget {
  const SubCategoriesWidget({
    super.key,
    required this.addsIndeces,
    this.selectedId = 0,
    required this.onSubCategorySelected,
  });
  final Set<int> addsIndeces;
  final int selectedId;
  final Function(int) onSubCategorySelected;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 48,
      child: ListView.separated(
        padding: AppConst.defaultHrPadding,
        scrollDirection: Axis.horizontal,
        itemCount: Fakers.fakeSubCats.length,
        separatorBuilder: (context, index) =>
            addsIndeces.contains(index) ? const SizedBox.shrink() : const HorizontalSpacing(12),
        itemBuilder: (context, index) {
          if (addsIndeces.contains(index)) {
            return const SizedBox.shrink();
          }
          return SubCategoryItem(
            subcategory: Fakers.fakeSubCats[index],
            isSelected: Fakers.fakeSubCats[index].id == selectedId,
            ontap: onSubCategorySelected,
          );
        },
      ),
    );
  }
}

class SubCategoryItem extends StatelessWidget {
  const SubCategoryItem({super.key, required this.subcategory, required this.isSelected, required this.ontap});
  final SubcategoryModel subcategory;
  final bool isSelected;
  final Function(int) ontap;
  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: AppConst.defaultInnerBorderRadius,
        border: GradientBoxBorder(gradient: Grad.shadowGrad(), width: 2),
        // color: isSelected ? null : Co.bg,
        gradient: isSelected ? Grad.hoverGradient : null,
      ),
      child: ElevatedButton(
        onPressed: () => ontap(subcategory.id),
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
            CircleGradientBorderedImage(image: subcategory.imageUrl),

            Padding(
              padding: AppConst.defaultHrPadding,
              child: Text(subcategory.name, style: TStyle.blackSemi(13)),
            ),
          ],
        ),
      ),
    );
  }
}
