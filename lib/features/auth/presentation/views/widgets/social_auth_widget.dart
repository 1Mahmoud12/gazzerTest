import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gazzer/core/presentation/resources/assets.dart';
import 'package:gazzer/core/presentation/utils/comand.dart';
import 'package:gazzer/di.dart';
import 'package:gazzer/features/auth/domain/repos/sing_up_repo.dart';
import 'package:gazzer/features/auth/domain/usecases/google_sign_in.dart';

class SocialAuthWidget extends StatefulWidget {
  const SocialAuthWidget({super.key});

  @override
  State<SocialAuthWidget> createState() => _SocialAuthWidgetState();
}

class _SocialAuthWidgetState extends State<SocialAuthWidget> {
  final google = Command(GoogleSignInCase(di<SignUpRepo>()).excute);
  final facebook = Command(() async => Future.delayed(Duration(seconds: 3)));
  final apple = Command(() async => Future.delayed(Duration(seconds: 3)));

  late final List<(Command, String)> social;

  @override
  void initState() {
    social = [(facebook, Assets.assetsSvgFacebook), (google, Assets.assetsSvgGoogle), (apple, Assets.assetsSvgApple)];
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
                return Center(child: CircularProgressIndicator());
              }

              return child!;
            },
            child: InkWell(
              onTap: item.$1.running
                  ? null
                  : () {
                      item.$1.execute();
                    },
              child: Padding(padding: const EdgeInsets.symmetric(vertical: 12), child: SvgPicture.asset(item.$2, height: 24)),
            ),
          ),
        );
      }),
    );
  }
}
