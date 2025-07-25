import 'package:circular_motion/circular_motion.dart';
import 'package:flutter/material.dart';
import 'package:gazzer/core/presentation/theme/app_theme.dart';
import 'package:gazzer/features/stores/domain/generic_item_entity.dart.dart';

class RotatingItemWidget extends StatelessWidget {
  const RotatingItemWidget({super.key, required this.items, required this.onTap, required this.shadowColor});
  final List<GenericItemEntity> items;
  final Function(GenericItemEntity item) onTap;
  final Color backgroundColor = Colors.transparent;
  final topPadding = 20.0;
  final ValueNotifier<Color> shadowColor;
  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.hardEdge,
      decoration: const BoxDecoration(),
      height: 381,
      width: 762,
      child: Stack(
        alignment: Alignment.topCenter,
        clipBehavior: Clip.hardEdge,
        children: [
          Positioned(
            top: topPadding,
            left: 0,
            right: 0,
            bottom: 0,
            child: OverflowBox(
              minHeight: 726,
              maxHeight: 726,
              maxWidth: 726,
              minWidth: 726,
              alignment: Alignment.topCenter,
              child: ValueListenableBuilder(
                valueListenable: shadowColor,
                builder: (context, value, child) => DecoratedBox(
                  decoration: BoxDecoration(
                    color: Co.bg,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        offset: const Offset(24, 4),
                        blurRadius: 17,
                        spreadRadius: 12,
                        color: value.withAlpha(50),
                      ),
                    ],
                  ),
                  child: child,
                ),
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: Grad().shadowGrad(),
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            top: topPadding * 2,
            left: 0,
            right: 0,
            bottom: 0,
            child: OverflowBox(
              minHeight: 726,
              maxHeight: 726,
              maxWidth: 726,
              minWidth: 726,
              alignment: Alignment.topCenter,
              child: LayoutBuilder(
                builder: (context, constraints) => CircularMotion.builder(
                  itemCount: 21,
                  builder: (context, index) {
                    final item = items[index % items.length];
                    return GestureDetector(
                      onTap: () => onTap(item),
                      child: ColoredBox(
                        color: Colors.transparent,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            CircleAvatar(
                              radius: 28,
                              backgroundImage: NetworkImage(item.image),
                            ),
                            Text(
                              item.name,
                              style: TStyle.greySemi(16),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
