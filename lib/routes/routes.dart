import 'package:core_package/core_package.dart';
import 'package:transport_sy/features/auth/presentation/page/presentation/auth_login_page.dart';
import 'package:transport_sy/features/auth/presentation/page/presentation/auth_user_complete_page.dart';
import 'package:transport_sy/features/auth/presentation/page/presentation/auth_verify_otp_page.dart';
import 'package:transport_sy/features/core/presentation/page/home_page.dart';
import 'package:flutter/material.dart';
import 'package:transport_sy/features/core/presentation/page/nav_page.dart';
import 'package:transport_sy/features/core/presentation/page/splash_page.dart';
import 'package:transport_sy/features/map_page.dart';
import 'package:transport_sy/features/settings_page.dart';

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

  static List<String> tabs = [HomePage.path, SettingsPage.path, MapPage.path];
  static List<RouteBase> routes = [
    ShellRoute(
      builder: (context, state, child) => NavPage(child: child),
      routes: [
        GoRoute(builder: (context, state) => HomePage(), path: HomePage.path),
        GoRoute(
          builder: (context, state) => SettingsPage(),
          path: SettingsPage.path,
        ),
        GoRoute(builder: (context, state) => MapPage(), path: MapPage.path),
      ],
    ),
    GoRoute(builder: (context, state) => HomePage(), path: HomePage.path),
    GoRoute(
      builder: (context, state) => AuthLoginPage(),
      path: AuthLoginPage.path,
    ),
    GoRoute(builder: (context, state) => SplashPage(), path: SplashPage.path),
    GoRoute(
      builder: (context, state) => AuthUserCompletePage(),
      path: AuthUserCompletePage.path,
    ),
    GoRoute(
      builder: (context, state) =>
          AuthVerifyOtpPage(phone: state.extra!.toString()),
      path: AuthVerifyOtpPage.path,
    ),
  ];
}
