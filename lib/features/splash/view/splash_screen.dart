import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gazzer/core/data/services/local_storage.dart';
import 'package:gazzer/core/presentation/localization/l10n.dart';
import 'package:gazzer/core/presentation/resources/assets.dart';
import 'package:gazzer/core/presentation/theme/app_colors.dart';
import 'package:gazzer/core/presentation/theme/text_style.dart';
import 'package:gazzer/features/auth/login/presentation/login_screen.dart';
import 'package:gazzer/features/home/main_home/presentaion/view/home_screen.dart';
import 'package:gazzer/features/splash/cubit/splash_cubit.dart';
import 'package:gazzer/features/splash/cubit/splash_states.dart';
import 'package:go_router/go_router.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});
  static const route = '/splash';
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with TickerProviderStateMixin {
  late final AnimationController contoller;
  late final AnimationController textController;
  late final SplashCubit cubit;
  int trialCount = 0;
  Future<void> _startAnimate(VoidCallback action) async {
    await Future.delayed(Durations.extralong4);
    if (mounted) contoller.forward();
    await Future.delayed(const Duration(seconds: 1), () {
      if (mounted) contoller.animateBack(0.0);
    });
    await Future.delayed(const Duration(seconds: 1), () {
      if (mounted) textController.forward();
    });
    await Future.delayed(Durations.extralong4, action);
  }

  @override
  void initState() {
    cubit = context.read<SplashCubit>();
    contoller = AnimationController(vsync: this, duration: Durations.medium4);
    textController = AnimationController(vsync: this, duration: Durations.short4);
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await _startAnimate(cubit.checkAuth);
    });
    super.initState();
  }

  @override
  void dispose() {
    contoller.dispose();
    textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: Scaffold(
        backgroundColor: Co.dark,
        body: DecoratedBox(
          decoration: const BoxDecoration(
            gradient: LinearGradient(colors: [Colors.transparent, Co.purple], begin: Alignment.topCenter, end: Alignment.bottomCenter),
          ),
          child: Column(
            children: [
              const Spacer(flex: 3),
              ScaleTransition(
                scale: Tween<double>(begin: 0.4, end: 1.0).animate(contoller),
                child: RotationTransition(
                  turns: Tween<double>(begin: 0.0, end: 0.37).animate(contoller),
                  child: Row(
                    spacing: 12,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset(Assets.assetsSvgSplashIcon, height: 90, width: 90),
                      SizeTransition(
                        axis: Axis.horizontal,
                        axisAlignment: 1,
                        sizeFactor: textController,
                        child: FadeTransition(
                          opacity: textController,
                          child: Text('HELLO', style: TStyle.whiteBold(92).copyWith(color: Co.bg)),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              BlocConsumer<SplashCubit, SplashStates>(
                listener: (context, state) {
                  if (state is UnAuth) {
                    if (!state.haveSeenTour) {
                      context.go(LoginScreen.route);
                    } else {
                      context.go(HomeScreen.route);
                      //  const IntroVideoTutorialRoute(videoLink: '').go(context);
                    }
                  } else if (state is RefreshTokenSuccess) {
                    cubit.getClientData();
                  } else if (state is GetClientSuccess) {
                    context.go(HomeScreen.route);
                  } else if (state is RefreshTokenError || state is GetClientError) {
                    trialCount++;
                  }
                },
                builder: (context, state) {
                  return AnimatedOpacity(
                    duration: Durations.short3,
                    opacity: state is RefreshTokenError || state is GetClientError ? 1 : 0,
                    child: IgnorePointer(
                      ignoring: state is! RefreshTokenError && state is! GetClientError,
                      child: SizedBox(
                        height: 170,
                        child: Column(
                          spacing: 8,
                          children: [
                            Text(L10n.tr().errorFetchingUserData, style: TStyle.errorSemi(16)),
                            const SizedBox.shrink(),
                            if (trialCount < 3)
                              OutlinedButton(
                                onPressed: state is RefreshTokenError ? cubit.refreshToken : cubit.getClientData,
                                child: Row(
                                  spacing: 6,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(L10n.tr().retry, style: TStyle.whiteSemi(14)),
                                    const Icon(Icons.refresh, color: Co.white, size: 24),
                                  ],
                                ),
                              ),
                            ElevatedButton(
                              onPressed: () {
                                TokenService.deleteToken();
                                context.go(LoginScreen.route);
                              },
                              child: Text(L10n.tr().skip, style: TStyle.blackSemi(14)),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
              const Spacer(flex: 2),
            ],
          ),
        ),
      ),
    );
  }
}
