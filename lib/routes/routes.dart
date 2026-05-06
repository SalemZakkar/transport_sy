import 'package:core_package/core_package.dart';
import 'package:transport_sy/features/auth/presentation/page/presentation/auth_login_page.dart';
import 'package:transport_sy/features/auth/presentation/page/presentation/auth_user_complete_page.dart';
import 'package:transport_sy/features/auth/presentation/page/presentation/auth_verify_otp_page.dart';
import 'package:transport_sy/features/auth/presentation/page/presentation/auth_wallet_page.dart';
import 'package:transport_sy/features/core/presentation/page/home_page.dart';
import 'package:flutter/material.dart';
import 'package:transport_sy/features/core/presentation/page/nav_page.dart';
import 'package:transport_sy/features/core/presentation/page/splash_page.dart';
import 'package:transport_sy/features/map/presentation/map_page.dart';
import 'package:transport_sy/features/settings/presentation/settings_page.dart';
import 'package:transport_sy/features/trips/presentation/page/trip_logs_page.dart';

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

  static List<String> tabs = [HomePage.path, MapPage.path, SettingsPage.path];
  static List<RouteBase> routes = [
    ShellRoute(
      builder: (context, state, child) => NavPage(child: child),
      routes: [
        GoRoute(
          // builder: (context, state) => HomePage(),
          path: HomePage.path,
          pageBuilder: (_, state) => NoTransitionPage(child: HomePage()),
        ),
        GoRoute(
          // builder: (context, state) => MapPage(),
          path: MapPage.path,
          pageBuilder: (_, state) => NoTransitionPage(child: MapPage()),
        ),
        GoRoute(
          pageBuilder: (_, state) => NoTransitionPage(child: SettingsPage()),
          path: SettingsPage.path,
        ),
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
    GoRoute(
      builder: (context, state) => AuthWalletPage(),
      path: AuthWalletPage.path,
    ),
    GoRoute(
      builder: (context, state) => TripLogsPage(),
      path: TripLogsPage.path,
    ),
  ];
}
