import 'package:go_router/go_router.dart';
import 'package:transport_sy/features/auth/presentation/page/presentation/auth_login_page.dart';
import 'package:transport_sy/features/core/presentation/page/home_page.dart';
import 'package:flutter/material.dart';
import 'package:transport_sy/features/core/presentation/page/splash_page.dart';

class AppRoutes {
  static final rootNavigatorKey = GlobalKey<NavigatorState>();

  static late GoRouter goRouterConfig;

  static void init(String initial) {
    goRouterConfig = GoRouter(
      routes: routes,
      initialLocation: initial,
      navigatorKey: rootNavigatorKey,
    );
  }

  static List<RouteBase> routes = [
    GoRoute(builder: (context, state) => HomePage(), path: HomePage.path),
    GoRoute(
      builder: (context, state) => AuthLoginPage(),
      path: AuthLoginPage.path,
    ),
    GoRoute(builder: (context, state) => SplashPage(), path: SplashPage.path),
  ];
}
