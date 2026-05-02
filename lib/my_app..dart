/*
 * @Author: Km Muzahid
 * @Date: 2026-01-07 15:37:37
 * @Email: km.muzahid@gmail.com
 */
import 'package:core_kit/core_kit_internal.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pinlink/config/color/app_color.dart';
import 'package:pinlink/config/route/app_router.dart';
import 'package:pinlink/config/route/app_router_observer.dart';
import 'package:pinlink/config/theme/cubit/theme_cubit.dart';
import 'package:pinlink/config/theme/custom_theme.dart';
import 'package:pinlink/coreFeature/auth/cubit/auth_cubit.dart';
import 'package:pinlink/coreFeature/navigation/cubit/navigation_cubit.dart';
import 'package:pinlink/coreFeature/notification/cubit/notification_cubit.dart';
import 'package:pinlink/features/course_comparision/cubit/add_course_cubit.dart';
import 'package:pinlink/corekit_config_impl.dart';

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
        BlocProvider(create: (_) => AddCourseCubit()..init()),
      ],
      child: BlocBuilder<ThemeCubit, ThemeMode>(
        builder: (context, themeState) { 
          return CoreKit.router(
            config: CoreKitConfigImpl(),
            navigatorKey: appRouter.navigatorKey,
            scrollBehavior: CustomScrollBehavior(),
            debugShowCheckedModeBanner: false,
            routerConfig: appRouter.config(navigatorObservers: () => [AppRouterObserver()]),
            theme: commonThemeData(ThemeColor.light),
            darkTheme: commonThemeData(ThemeColor.dark), 
            themeMode: themeState,
          );
        },
      ),
    );
  }
}

