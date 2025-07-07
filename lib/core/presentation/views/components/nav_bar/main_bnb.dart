import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gazzer/core/presentation/extensions/with_hot_spot.dart';
import 'package:gazzer/core/presentation/localization/l10n.dart';
import 'package:gazzer/core/presentation/resources/assets.dart';
import 'package:gazzer/core/presentation/theme/app_theme.dart';
import 'package:gazzer/core/presentation/views/widgets/decoration_widgets/doubled_decorated_widget.dart';

class MainBnb extends StatefulWidget {
  const MainBnb({super.key, this.initialIndex = 0, required this.onItemSelected});
  final int initialIndex;
  final Function(int index) onItemSelected;
  @override
  State<MainBnb> createState() => _MainBnbState();
}

class _MainBnbState extends State<MainBnb> {
  late int selectedIndex;
  final items = {
    "Home": Assets.assetsSvgHomeIcon,
    "Favorite": Assets.assetsSvgFavoriteIcon,
    "Orders": Assets.assetsSvgMenyIcon,
    "Menu": Assets.assetsSvgDrawerIcon,
  };

  @override
  void initState() {
    selectedIndex = widget.initialIndex;
    super.initState();
  }

  @override
  void didUpdateWidget(covariant MainBnb oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.initialIndex != widget.initialIndex) {
      setState(() => selectedIndex = widget.initialIndex);
    }
  }

  @override
  Widget build(BuildContext context) {
    return DoubledDecoratedWidget(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(6, 6, 6, 2),
        child: SafeArea(
          child: LayoutBuilder(
            builder: (context, constraints) {
              final width = (constraints.maxWidth - 12) / items.length;
              return Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: List.generate(items.length, (index) {
                  final color = Co.secondary.withAlpha(index == selectedIndex ? 255 : 180);
                  return ElevatedButton(
                    onPressed: () {
                      SystemSound.play(SystemSoundType.click);
                      widget.onItemSelected(index);
                    },
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.all(6),
                      backgroundColor: Colors.transparent,
                      elevation: 0,
                      iconSize: 21,
                      maximumSize: Size(width, 150),
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      minimumSize: Size.zero,
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Builder(
                          builder: (context) {
                            final child = CircleAvatar(
                              radius: 20,
                              backgroundColor: index == selectedIndex ? const Color(0xFFFFE6E6) : Colors.transparent,
                              child: SvgPicture.asset(
                                items.values.elementAt(index),
                                height: 21,
                                width: 21,
                                colorFilter: ColorFilter.mode(color, BlendMode.srcIn),
                              ),
                            );
                            if (index == items.length - 1) {
                              return child.withHotspot(order: 5, title: "", text: L10n.tr().sideMenuSetting);
                            }
                            return child;
                          },
                        ),
                        Text(items.keys.elementAt(index), style: TStyle.secondaryBold(12).copyWith(color: color)),
                      ],
                    ),
                  );
                }),
              );
            },
          ),
        ),
      ),
    );
  }
}
