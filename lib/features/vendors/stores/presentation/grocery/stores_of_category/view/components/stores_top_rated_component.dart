import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gazzer/core/presentation/localization/l10n.dart';
import 'package:gazzer/core/presentation/resources/assets.dart';
import 'package:gazzer/core/presentation/theme/app_theme.dart';
import 'package:gazzer/core/presentation/views/widgets/helper_widgets/helper_widgets.dart';
import 'package:gazzer/features/vendors/common/domain/generic_item_entity.dart.dart';
import 'package:gazzer/features/vendors/stores/presentation/grocery/stores_of_category/view/widgets/rotating_items_widget.dart';
import 'package:gazzer/features/vendors/stores/presentation/grocery/stores_of_category/view/widgets/top_rated_item_details.dart';

class StoresTopRatedComponent extends StatefulWidget {
  const StoresTopRatedComponent({super.key, required this.items});
  final List<GenericItemEntity> items;
  @override
  State<StoresTopRatedComponent> createState() => _StoresTopRatedComponentState();
}

class _StoresTopRatedComponentState extends State<StoresTopRatedComponent> {
  late GenericItemEntity item;
  late final ValueNotifier<Color> shadowColor = ValueNotifier<Color>(Co.second2);
  @override
  void initState() {
    item = widget.items.first;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Badge(
      alignment: Alignment.bottomLeft,
      backgroundColor: Colors.transparent,
      label: Badge(
        alignment: const Alignment(-0.6, 0),
        backgroundColor: Colors.transparent,
        label: GradientText(
          text: L10n.tr().exploreBest,
          style: TStyle.blackBold(32),
        ),
        child: SvgPicture.asset(
          Assets.assetsSvgBadge,
          width: 520,
          fit: BoxFit.cover,
        ),
      ),
      child: SizedBox(
        height: 600,
        child: Stack(
          children: [
            RotatingItemWidget(
              items: widget.items.length > 5 ? widget.items.sublist(0, 5) : widget.items,
              onTap: (item) {
                setState(() => this.item = item);
                shadowColor.value = item is ProductEntity ? item.color ?? Co.second2 : Co.second2;
              },
              shadowColor: shadowColor,
            ),
            OverflowBox(
              minHeight: 464,
              maxHeight: 464,
              maxWidth: 464,
              minWidth: 464,
              alignment: Alignment.bottomCenter,
              child: ClipOval(
                child: DecoratedBox(
                  decoration: BoxDecoration(gradient: Grad().shadowGrad()),
                  child: AnimatedSwitcher(
                    duration: Durations.extralong1,
                    transitionBuilder: (Widget child, Animation<double> animation) {
                      return FadeTransition(opacity: animation, child: child);
                    },
                    child: TopRatedItemDetails(key: ValueKey(item.id), item: item, shadowColor: shadowColor),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
