import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gazzer/core/domain/comand.dart';
import 'package:gazzer/core/presentation/resources/assets.dart';
import 'package:gazzer/core/presentation/views/widgets/helper_widgets/helper_widgets.dart';
import 'package:gazzer/di.dart';
import 'package:gazzer/features/auth/common/domain/usecases/google_sign_in.dart';
import 'package:gazzer/features/auth/social/domain/social_repo.dart';

class SocialAuthWidget extends StatefulWidget {
  const SocialAuthWidget({super.key});

  @override
  State<SocialAuthWidget> createState() => _SocialAuthWidgetState();
}

class _SocialAuthWidgetState extends State<SocialAuthWidget> {
  final google = Command(() async => SocialLogin(di<SocialRepo>()).excute(Social.google));
  final facebook = Command(() async => SocialLogin(di<SocialRepo>()).excute(Social.facebook));
  final apple = Command(() async => SocialLogin(di<SocialRepo>()).excute(Social.apple));

  late final List<(Command, String)> social;

  @override
  void initState() {
    social = [(google, Assets.assetsSvgLogoGoogle), (facebook, Assets.assetsSvgLogoFacebook), (apple, Assets.assetsSvgLogoApple)];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: 16,
      children: List.generate(social.length, (index) {
        final item = social[index];
        return Expanded(
          child: ListenableBuilder(
            listenable: item.$1,
            builder: (context, child) {
              if (item.$1.error != null) {
                print(item.$1.error);
              }
              if (item.$1.running) {
                return const Center(child: AdaptiveProgressIndicator());
              }

              return child!;
            },
            child: ElevatedButton(
              onPressed: item.$1.running
                  ? null
                  : () {
                      item.$1.execute();
                    },
              style: ElevatedButton.styleFrom(
                shape: const CircleBorder(),
                elevation: 8,
                padding: const EdgeInsetsDirectional.all(8),
                minimumSize: Size.zero,
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              ),
              child: SvgPicture.asset(item.$2, height: 24),
            ),
          ),
        );
      }),
    );
  }
}
