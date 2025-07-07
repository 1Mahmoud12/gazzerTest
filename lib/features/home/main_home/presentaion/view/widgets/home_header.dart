part of '../home_screen.dart';

class _HomeHeader extends StatelessWidget {
  const _HomeHeader();
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
                  ).withHotspot(
                    // hotspotSize: Size.zero,
                    hotspotOffset: Offset.zero,
                    order: 1,
                    title: "",
                    text: L10n.tr().gazzerVideoTourGuide,
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
                            // spacing: 12,
                            children: [
                              SvgPicture.asset(
                                Assets.assetsSvgLocation,
                                height: 32,
                                width: 32,
                              ).withHotspot(order: 4, title: "", text: L10n.tr().setYourLocation),
                              const HorizontalSpacing(8),
                              Expanded(
                                child: Text.rich(
                                  TextSpan(
                                    children: [
                                      TextSpan(
                                        text: L10n.tr().deliverTo,
                                        style: TStyle.mainwSemi(15).copyWith(color: Co.white.withAlpha(120)),
                                      ),
                                      const TextSpan(text: '\n'),
                                      const TextSpan(text: '4140 Parker Rd. Allentwon, St.Mark'),
                                    ],
                                  ),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: TStyle.whiteSemi(14),
                                ),
                              ),
                              InkWell(
                                onTap: () {},
                                child: Padding(
                                  padding: const EdgeInsets.all(6),
                                  child: SvgPicture.asset(Assets.assetsSvgNotification),
                                ),
                              ),
                              InkWell(
                                onTap: () {},
                                child: Padding(
                                  padding: const EdgeInsets.all(6),
                                  child: SvgPicture.asset(Assets.assetsSvgLanguage),
                                ),
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
