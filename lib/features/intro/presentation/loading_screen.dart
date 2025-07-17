import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gazzer/core/presentation/localization/l10n.dart';
import 'package:gazzer/core/presentation/pkgs/staggered_dots_wave.dart';
import 'package:gazzer/core/presentation/resources/assets.dart';
import 'package:gazzer/core/presentation/theme/app_colors.dart';
import 'package:gazzer/core/presentation/theme/app_gradient.dart';
import 'package:gazzer/core/presentation/theme/text_style.dart';
import 'package:gazzer/core/presentation/views/widgets/decoration_widgets/image_background_widget.dart';
import 'package:gazzer/core/presentation/views/widgets/helper_widgets/helper_widgets.dart' show GradientText, HorizontalSpacing;
import 'package:go_router/go_router.dart';

part 'loading_screen.g.dart';

@TypedGoRoute<LoadingScreenRoute>(path: LoadingScreen.routeUriRoute)
@immutable
class LoadingScreenRoute extends GoRouteData with _$LoadingScreenRoute {
  const LoadingScreenRoute({required this.navigateToRoute});
  final String navigateToRoute;
  @override
  Widget build(BuildContext context, GoRouterState state) {
    return LoadingScreen(navigateToRoute: navigateToRoute);
  }
}

class LoadingScreen extends StatelessWidget {
  static const routeUriRoute = '/loading';
  const LoadingScreen({super.key, required this.navigateToRoute, this.toLoad});
  final String navigateToRoute;
  final Future Function()? toLoad;

  @override
  Widget build(BuildContext context) {
    Future _loadAndNav() async {
      if (toLoad != null) {
        await toLoad!();
        if (context.mounted) {
          context.go(navigateToRoute);
        }
      } else {
        Future.delayed(const Duration(seconds: 3), () {
          if (context.mounted) {
            context.go(navigateToRoute);
          }
        });
      }
    }

    _loadAndNav();
    return ImageBackgroundWidget(
      image: Assets.assetsPngLoadingShape,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          spacing: 8,
          children: [
            SvgPicture.asset(Assets.assetsSvgCharacter, height: 130),
            const HorizontalSpacing(double.infinity),
            GradientText(text: L10n.tr().loading, style: TStyle.blackBold(24), gradient: Grad().radialGradient),
            StaggeredDotsWave(
              colors: [Co.tertiary, Co.purple, Co.greyText, Co.secondary, Co.secondary],
              size: 100,
              dotsNumber: 5,
            ),
          ],
        ),
      ),
    );
  }
}
