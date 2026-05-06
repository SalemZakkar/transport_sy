import 'package:core_package/core_package.dart';
import 'package:core_package/generated/core_translation/core_translations.dart';
import 'package:flutter/services.dart';
import 'package:transport_sy/features/auth/presentation/page/presentation/auth_login_page.dart';
import 'package:transport_sy/features/auth/presentation/page/presentation/auth_user_complete_page.dart';
import 'package:transport_sy/features/core/presentation/page/splash_page.dart';
import 'package:transport_sy/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:transport_sy/themes/app_colors_shema.dart';
import 'package:transport_sy/themes/app_theme.dart';
import 'features/auth/presentation/cubit/auth_cubit.dart';
import 'features/core/presentation/page/home_page.dart';
import 'generated/translation/translations.dart';
import 'injection.dart';

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  void initState() {
    super.initState();
    AppRoutes.init(SplashPage.path);
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    WidgetsBinding.instance.addPostFrameCallback((e) {});
  }

  var authCubit = getIt<AuthCubit>();

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      localizationsDelegates: [
        ...CoreTranslations.localizationsDelegates,
        ...Translations.localizationsDelegates,
      ],
      supportedLocales: [
        ...Translations.supportedLocales,
        ...Translations.supportedLocales,
      ],
      // theme: context.theme,
      locale: Locale('ar'),
      theme: AppTheme(LightAppColorSchema()).getThemeData(fontFamily: 'cairo'),
      debugShowCheckedModeBanner: false,
      routerConfig: AppRoutes.goRouterConfig,
      builder: (context, child) {
        return MultiBlocProvider(
          providers: [BlocProvider(create: (context) => authCubit)],
          child: MultiBlocListener(
            listeners: [
              BlocListener<AuthCubit, AuthState>(
                listener: (context, state) {
                  if (state.authenticated) {
                    if (!state.withPush) {
                      return;
                    }
                    if (state.userData?.active == true) {
                      AppRoutes.goRouterConfig.go(HomePage.path);
                    } else {
                      AppRoutes.goRouterConfig.go(AuthUserCompletePage.path);
                    }
                    return;
                  }
                  AppRoutes.goRouterConfig.go(AuthLoginPage.path);
                },
              ),
            ],
            child: Builder(
              builder: (context) {
                if (child == null) {
                  return const SizedBox();
                }
                return Listener(
                  behavior: HitTestBehavior.translucent,
                  onPointerDown: (_) {
                    FocusManager.instance.primaryFocus?.unfocus();
                  },
                  child: MediaQuery(
                    data: MediaQuery.of(
                      context,
                    ).copyWith(textScaler: TextScaler.linear(1)),
                    child: SafeArea(
                      top: false,
                      left: false,
                      right: false,
                      child: child,
                    ),
                  ),
                );
              },
            ),
          ),
        );
      },
    );
  }
}
