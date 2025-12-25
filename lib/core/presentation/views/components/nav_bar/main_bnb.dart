import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gazzer/core/presentation/extensions/color.dart';
import 'package:gazzer/core/presentation/localization/l10n.dart';
import 'package:gazzer/core/presentation/resources/assets.dart';
import 'package:gazzer/core/presentation/theme/app_theme.dart';
import 'package:gazzer/core/presentation/views/widgets/vector_graphics_widget.dart';

class MainBnb extends StatefulWidget {
  const MainBnb({super.key, this.initialIndex = 0, required this.onItemSelected});
  final int initialIndex;
  final Function(int index) onItemSelected;
  @override
  State<MainBnb> createState() => _MainBnbState();
}

class _MainBnbState extends State<MainBnb> {
  late int selectedIndex;

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

  void _onItemTapped(int index) {
    SystemSound.play(SystemSoundType.click);
    widget.onItemSelected(index);
  }

  // Map route index to visual bar index
  // Routes: 0=Home, 1=Favorites, 2=Cart, 3=Orders, 4=Profile
  // Visual bar: 0=Home, 1=Favorites, 2=Orders, 3=Profile (Cart is persistent button)
  int _getBarIndex(int routeIndex) {
    switch (routeIndex) {
      case 0:
        return 0; // Home
      case 1:
        return 1; // Favorites
      case 2:
        return -1; // Cart (persistent button, not in bar)
      case 3:
        return 2; // Orders
      case 4:
        return 3; // Profile
      default:
        return 0;
    }
  }

  // Map visual bar index to route index
  // Visual bar: 0=Home, 1=Favorites, 2=Orders, 3=Profile
  // Routes: 0=Home, 1=Favorites, 2=Cart, 3=Orders, 4=Profile
  int _getRouteIndex(int barIndex) {
    switch (barIndex) {
      case 0:
        return 0; // Home
      case 1:
        return 1; // Favorites
      case 2:
        return 3; // Orders
      case 3:
        return 4; // Profile
      default:
        return 0;
    }
  }

  Widget _buildTab(int index, bool isActive) {
    final color = isActive ? Colors.white : Colors.white.withOpacityNew(0.5);
    final String label;
    final String iconAsset;

    switch (index) {
      case 0:
        label = L10n.tr().home;
        iconAsset = Assets.unSelectedHomeIc;
        break;
      case 1:
        label = L10n.tr().favorites;
        iconAsset = Assets.unSelectedFavoriteIc;
        break;
      case 2:
        label = L10n.tr().orders;
        iconAsset = Assets.unSelectedOrdersIc;
        break;
      case 3:
        label = L10n.tr().profile;
        iconAsset = Assets.unSelectedProfileIc;
        break;
      default:
        label = '';
        iconAsset = Assets.unSelectedHomeIc;
    }

    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        VectorGraphicsWidget(iconAsset, height: 24, width: 24, colorFilter: ColorFilter.mode(color, BlendMode.srcIn)),
        const SizedBox(height: 4),
        Text(label, style: TStyle.robotBlackMedium().copyWith(color: color, fontSize: 10)),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final barIndex = _getBarIndex(selectedIndex);
    final currentIndex = barIndex == -1 ? 0 : barIndex;

    return AnimatedBottomNavigationBar.builder(
      itemCount: 4,
      tabBuilder: (int index, bool isActive) {
        return _buildTab(index, isActive);
      },
      activeIndex: currentIndex,
      gapLocation: GapLocation.center,
      leftCornerRadius: 12,
      rightCornerRadius: 12,
      backgroundColor: Co.purple,
      splashColor: Co.purple,
      splashRadius: 24,
      notchSmoothness: NotchSmoothness.verySmoothEdge,
      gapWidth: 70,
      notchMargin: 20,
      onTap: (index) {
        // Map visual bar index to route index
        // Visual: 0=Home, 1=Favorites, 2=Orders, 3=Profile (Cart is persistent button)
        // Routes: 0=Home, 1=Favorites, 2=Cart, 3=Orders, 4=Profile
        final actualIndex = _getRouteIndex(index);
        _onItemTapped(actualIndex);
      },
      safeAreaValues: const SafeAreaValues(top: false, bottom: false),
      height: 70,
    );
  }
}
