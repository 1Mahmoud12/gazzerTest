// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'intro_video_tutorial_screen.dart';

// **************************************************************************
// GoRouterGenerator
// **************************************************************************

List<RouteBase> get $appRoutes => [$introVideoTutorialRoute];

RouteBase get $introVideoTutorialRoute => GoRouteData.$route(
  path: '/video-player',

  factory: _$IntroVideoTutorialRoute._fromState,
);

mixin _$IntroVideoTutorialRoute on GoRouteData {
  static IntroVideoTutorialRoute _fromState(GoRouterState state) =>
      IntroVideoTutorialRoute(
        videoLink: state.uri.queryParameters['video-link']!,
      );

  IntroVideoTutorialRoute get _self => this as IntroVideoTutorialRoute;

  @override
  String get location => GoRouteData.$location(
    '/video-player',
    queryParams: {'video-link': _self.videoLink},
  );

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}
