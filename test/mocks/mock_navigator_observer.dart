import 'package:flutter/material.dart';
import 'package:mockito/mockito.dart';

class MockNavigatorObserver extends Mock implements NavigatorObserver {
  String? navigatedTo = "";
  String? replacedBy = "";
  @override
  void didPush(Route route, Route? previousRoute) {
    navigatedTo = route.settings.name;
  }

  @override
  void didReplace({Route<dynamic>? newRoute, Route<dynamic>? oldRoute}) {
    replacedBy = newRoute?.settings.name;
  }
}
