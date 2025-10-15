import 'package:flutter/material.dart';
import 'package:gazzer/core/presentation/localization/l10n.dart';
import 'package:gazzer/core/presentation/theme/app_theme.dart';
import 'package:gazzer/core/presentation/views/widgets/main_search_widget.dart';
import 'package:gazzer/core/presentation/views/widgets/products/main_cart_widget.dart';
import 'package:gazzer/features/home/main_home/presentaion/utils/home_utils.dart';

class HomeCategoriesHeader extends StatefulWidget {
  const HomeCategoriesHeader({super.key});

  @override
  State<HomeCategoriesHeader> createState() => _HomeCategoriesHeaderState();
}

class _HomeCategoriesHeaderState extends State<HomeCategoriesHeader> {
  final controller = TextEditingController();
  final width = 550.0;
  @override
  void dispose() {
    if (mounted) controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: HomeUtils.headerHeight(context),
      child: Stack(
        alignment: Alignment.center,
        fit: StackFit.loose,
        children: [
          Positioned(
            bottom: 20,
            child: Transform.rotate(
              angle: -0.25,
              child: ClipOval(
                child: Container(
                  width: width * 1.2,
                  height: width,
                  decoration: BoxDecoration(
                    gradient: Grad().bglightLinear.copyWith(
                      begin: Alignment.centerRight,
                      colors: [Co.buttonGradient, Colors.black.withAlpha(0)],
                    ),
                  ),
                  // foregroundDecoration: BoxDecoration(gradient: Grad().linearGradient),
                ),
              ),
            ),
          ),
          Align(
            alignment: const Alignment(0, -1),
            child: Padding(
              padding: EdgeInsets.fromLTRB(
                16,
                MediaQuery.paddingOf(context).top,
                16,
                0,
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: 12,
                children: [
                  Expanded(
                    child: MainSearchWidget(
                      controller: controller,
                      height: 80,
                      hintText: L10n.tr().searchForStoresItemsAndCAtegories,
                      borderRadius: 64,
                      bgColor: Colors.transparent,
                      prefix: const Icon(
                        Icons.search,
                        color: Co.purple,
                        size: 24,
                      ),
                    ),
                  ),
                  const MainCartWidget(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
