/*
 * @Author: Km Muzahid
 * @Date: 2026-01-07 15:37:37
 * @Email: km.muzahid@gmail.com
 */
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pinlink/config/color/app_color.dart';
import 'package:pinlink/config/route/app_router.dart';
import 'package:pinlink/config/route/app_router_observer.dart';
import 'package:pinlink/config/theme/cubit/theme_cubit.dart';
import 'package:pinlink/config/theme/custom_theme.dart';
import 'package:pinlink/coreFeature/auth/cubit/auth_cubit.dart';
import 'package:pinlink/coreFeature/auth/cubit/auth_state.dart';
import 'package:pinlink/coreFeature/navigation/cubit/navigation_cubit.dart';
import 'package:pinlink/coreFeature/notification/cubit/notification_cubit.dart';
import 'package:pinlink/corekit_init.dart';

final scaffoldMessengerKey = GlobalKey<ScaffoldMessengerState>();

class CustomScrollBehavior extends MaterialScrollBehavior {
  @override
  ScrollPhysics getScrollPhysics(BuildContext context) {
    return const BouncingScrollPhysics(); // or ClampingScrollPhysics, etc.
  }

  @override
  ScrollViewKeyboardDismissBehavior getKeyboardDismissBehavior(BuildContext context) {
    return ScrollViewKeyboardDismissBehavior.onDrag;
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => ThemeCubit(), lazy: false),
        // BlocProvider(create: (_) => LanguageCubit()..init(), lazy: false),
        BlocProvider(create: (_) => AuthCubit()),
        BlocProvider(create: (_) => NotificationCubit()),
        BlocProvider(create: (_) => NavigationCubit()),
      ],
      child: BlocBuilder<ThemeCubit, ThemeMode>(
        builder: (context, themeState) {
          return MaterialApp.router(
            scrollBehavior: CustomScrollBehavior(),
            debugShowCheckedModeBanner: false,
            routerConfig: appRouter.config(navigatorObservers: () => [AppRouterObserver()]),
            theme: commonThemeData(ThemeColor.light),
            darkTheme: commonThemeData(ThemeColor.dark),
            themeAnimationCurve: Curves.easeInOut,
            themeAnimationDuration: const Duration(milliseconds: 300),
            themeMode: themeState,
            builder: (context, child) {
              return BlocBuilder<AuthCubit, AuthState>(
                builder: (context, state) {
                  return CorekitInit().corekitInit(context, child);
                },
              );
            },
          );
        },
      ),
    );
  }
}
