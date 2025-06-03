import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gazzer/core/presentation/resources/app_const.dart';
import 'package:gazzer/core/presentation/resources/assets.dart';
import 'package:gazzer/core/presentation/theme/app_theme.dart';

class MainBnb extends StatefulWidget {
  const MainBnb({super.key, this.initialIndex = 0, required this.onItemSelected});
  final int initialIndex;
  final Function(int index) onItemSelected;
  @override
  State<MainBnb> createState() => _MainBnbState();
}

class _MainBnbState extends State<MainBnb> {
  late int selectedIndex;
  final icons = [
    Assets.assetsSvgHomeIcon,
    Assets.assetsSvgFavoriteIcon,
    Assets.assetsSvgMenyIcon,
    Assets.assetsSvgDrawerIcon,
  ];

  @override
  void initState() {
    selectedIndex = widget.initialIndex;
    super.initState();
  }

  @override
  void didUpdateWidget(covariant MainBnb oldWidget) {
    super.didUpdateWidget(oldWidget);
    print(" ** MainBnb didUpdateWidget ** ");
    if (oldWidget.initialIndex != widget.initialIndex) {
      print(" ** MainBnb didUpdateWidget - updating index ** ");
      setState(() => selectedIndex = widget.initialIndex);
    }
  }

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(AppConst.defaultInnerRadius),
          topRight: Radius.circular(AppConst.defaultInnerRadius),
        ),
        gradient: Grad.radialGradient,
      ),
      child: DecoratedBox(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(AppConst.defaultInnerRadius),
            topRight: Radius.circular(AppConst.defaultInnerRadius),
          ),
          gradient: Grad.linearGradient,
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
          child: SafeArea(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: List.generate(icons.length, (index) {
                return ElevatedButton(
                  onPressed: () {
                    SystemSound.play(SystemSoundType.click);
                    setState(() => selectedIndex = index);
                    widget.onItemSelected(index);
                  },
                  style: ElevatedButton.styleFrom(
                    shape: const CircleBorder(),
                    padding: const EdgeInsets.all(8),
                    backgroundColor: Colors.transparent,
                    elevation: 0,
                    minimumSize: Size.zero,
                  ),
                  child: CircleAvatar(
                    radius: 28,
                    backgroundColor: index == selectedIndex ? const Color(0xFFFFE6E6) : Colors.transparent,
                    child: SvgPicture.asset(icons[index], height: 24, width: 24),
                  ),
                );
              }),
            ),
          ),
        ),
      ),
    );
  }
}
