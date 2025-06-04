import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gazzer/core/presentation/resources/assets.dart';
import 'package:gazzer/core/presentation/theme/app_theme.dart';
import 'package:gazzer/features/home/presentaion/utils/home_utils.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader({super.key});
  @override
  Widget build(BuildContext context) {
    final width = HomeUtils.headerWidth(context);
    return SizedBox(
      width: width,
      height: HomeUtils.headerHeight(context),
      child: Stack(
        alignment: Alignment.center,
        fit: StackFit.loose,
        children: [
          Positioned(
            bottom: 0,
            child: Container(
              width: width,
              height: width,
              decoration: BoxDecoration(gradient: Grad.radialGradient, shape: BoxShape.circle),
              foregroundDecoration: BoxDecoration(gradient: Grad.linearGradient, shape: BoxShape.circle),
            ),
          ),
          Positioned(
            bottom: width * 0.19,
            child: Transform.rotate(
              angle: -0.25,
              child: DecoratedBox(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(250),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xff933EFF).withAlpha(150),
                      spreadRadius: 0,
                      blurRadius: 15,
                      offset: const Offset(-10, -20),
                    ),
                  ],
                ),
                child: ClipOval(
                  child: Container(
                    height: width,
                    width: width * 0.8,
                    decoration: const BoxDecoration(color: Co.bg),
                    foregroundDecoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Co.purple.withAlpha(50), Colors.transparent],
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          SizedBox.expand(
            child: SafeArea(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SvgPicture.asset(
                    Assets.assetsSvgCharacter,
                    width: width * 0.18,
                    fit: BoxFit.contain,
                    height: width * 0.18,
                  ),
                  SizedBox(
                    height: width * 0.195,
                    width: width,
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: width * 0.1),
                      child: Column(
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            spacing: 12,
                            children: [
                              SvgPicture.asset(Assets.assetsSvgLocation, height: 40, width: 40),
                              Expanded(
                                child: Text.rich(
                                  TextSpan(
                                    children: [
                                      TextSpan(
                                        text: "Deliver To",
                                        style: TStyle.mainwSemi(18).copyWith(color: Co.white.withAlpha(120)),
                                      ),
                                      const TextSpan(text: '\n'),
                                      const TextSpan(text: '4140 Parker Rd. Allentwon, St.Mark'),
                                    ],
                                  ),
                                  maxLines: 3,
                                  overflow: TextOverflow.ellipsis,
                                  style: TStyle.whiteSemi(15),
                                ),
                              ),
                              IconButton(
                                onPressed: () {},
                                icon: const Icon(Icons.notifications_none, color: Co.secondary, size: 32),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
