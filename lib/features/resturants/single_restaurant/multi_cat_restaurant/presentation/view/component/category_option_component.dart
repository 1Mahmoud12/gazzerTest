part of '../multi_cat_restaurant_screen.dart';

class CategoryOptionComponent extends StatelessWidget {
  const CategoryOptionComponent({super.key, required this.subCat, required this.builder, this.height, this.separator, required this.itemCount});
  final SubcategoryModel subCat;
  final Widget Function(BuildContext context, int index) builder;
  final double? height;
  final double? separator;
  final int itemCount;

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 12,
      children: [
        Padding(
          padding: AppConst.defaultHrPadding,
          child: TitleWithMore(title: subCat.name, onPressed: () {}),
        ),
        SizedBox(
          height: height ?? 130,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            padding: AppConst.defaultHrPadding,
            itemCount: itemCount,
            separatorBuilder: (context, index) => HorizontalSpacing(separator ?? 24),
            itemBuilder: builder,
          ),
        ),
      ],
    );
  }
}
