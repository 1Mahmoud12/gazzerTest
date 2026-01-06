import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gazzer/core/data/services/local_storage.dart';
import 'package:gazzer/core/presentation/localization/l10n.dart';
import 'package:gazzer/core/presentation/resources/assets.dart';
import 'package:gazzer/core/presentation/theme/app_colors.dart';
import 'package:gazzer/core/presentation/theme/text_style.dart';
import 'package:gazzer/core/presentation/utils/location_utils.dart';
import 'package:gazzer/core/presentation/views/widgets/vector_graphics_widget.dart';
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
    await LocationUtils.getLocationToCache();
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
        appBar: AppBar(toolbarHeight: 0),
        backgroundColor: Co.purple,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                children: [
                  Stack(
                    alignment: AlignmentDirectional.topCenter,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 39.0, left: 10),
                        child: const VectorGraphicsWidget(Assets.bodyGazzerIc).animate().slide(
                          begin: const Offset(1, 0),
                          end: Offset.zero,
                          duration: const Duration(milliseconds: 1500),
                          curve: Curves.easeOutBack,
                        ),
                      ),

                      const VectorGraphicsWidget(Assets.capGazzerIc).animate().slide(
                        begin: const Offset(-1, 0),
                        end: Offset.zero,
                        duration: const Duration(milliseconds: 1500),
                        curve: Curves.easeOutBack,
                      ),
                    ],
                  ),

                  const VectorGraphicsWidget(Assets.gazzerTextIc).animate().slide(
                    delay: Durations.extralong4,
                    begin: const Offset(0, 10),
                    end: Offset.zero,
                    duration: Durations.long4,
                    curve: Curves.easeOut,
                  ),
                ],
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
                            Text(L10n.tr().errorFetchingUserData, style: TStyle.robotBlackRegular().copyWith(color: Co.red)),
                            const SizedBox.shrink(),
                            if (trialCount < 3)
                              OutlinedButton(
                                onPressed: state is RefreshTokenError ? cubit.refreshToken : cubit.getClientData,
                                child: Row(
                                  spacing: 6,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      L10n.tr().retry,
                                      style: TStyle.robotBlackRegular14().copyWith(color: Co.white, fontWeight: TStyle.medium),
                                    ),
                                    const Icon(Icons.refresh, color: Co.white, size: 24),
                                  ],
                                ),
                              ),
                            ElevatedButton(
                              onPressed: () {
                                TokenService.deleteToken();
                                context.go(LoginScreen.route);
                              },
                              child: Text(L10n.tr().skip, style: TStyle.robotBlackRegular14()),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
