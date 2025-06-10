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
    if (oldWidget.initialIndex != widget.initialIndex) {
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
          padding: const EdgeInsets.fromLTRB(6, 6, 6, 2),
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
                    padding: const EdgeInsets.all(6),
                    backgroundColor: Colors.transparent,
                    elevation: 0,
                    iconSize: 21,
                    maximumSize: const Size(50, 50),
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    minimumSize: Size.zero,
                  ),
                  child: CircleAvatar(
                    radius: 20,
                    backgroundColor: index == selectedIndex ? const Color(0xFFFFE6E6) : Colors.transparent,
                    child: SvgPicture.asset(icons[index], height: 21, width: 21),
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
