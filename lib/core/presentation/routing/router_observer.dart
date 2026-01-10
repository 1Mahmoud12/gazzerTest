import 'package:flutter/material.dart';

class MyRouteObserver extends RouteObserver<ModalRoute<void>> {
  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
    debugPrint(
      'Push Route from {{${previousRoute?.settings.name}}} to {{${route.settings.name}}}',
    );
  }

  @override
  void didPop(Route<dynamic> route, Route<dynamic>? previousRoute) {
    debugPrint(
      'Pop Route from {{${previousRoute?.settings.name}}} to {{${route.settings.name}}}',
    );
  }

  @override
  void didReplace({Route<dynamic>? newRoute, Route<dynamic>? oldRoute}) {
    debugPrint(
      'Replaced Route from {{${oldRoute?.settings.name}}} to {{${newRoute?.settings.name}}}',
    );
  }

  @override
  void didRemove(Route<dynamic> route, Route<dynamic>? previousRoute) {
    debugPrint(
      'Removed Route from {{${previousRoute?.settings.name}}} to {{${route.settings.name}}}',
    );
  }
}
