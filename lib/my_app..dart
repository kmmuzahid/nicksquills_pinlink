/*
 * @Author: Km Muzahid
 * @Date: 2026-01-07 15:37:37
 * @Email: km.muzahid@gmail.com
 */
import 'package:core_kit/core_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pinlink/config/api/api_end_point.dart';
import 'package:pinlink/config/color/app_color.dart';
import 'package:pinlink/config/route/app_router.dart';
import 'package:pinlink/config/route/app_router_observer.dart';
import 'package:pinlink/config/storage/storage_key.dart';
import 'package:pinlink/config/theme/cubit/theme_cubit.dart';
import 'package:pinlink/config/theme/custom_theme.dart';
import 'package:pinlink/coreFeature/auth/cubit/auth_cubit.dart';
import 'package:pinlink/coreFeature/auth/cubit/auth_state.dart';
import 'package:pinlink/coreFeature/navigation/cubit/navigation_cubit.dart';
import 'package:pinlink/coreFeature/notification/cubit/notification_cubit.dart';
import 'package:pinlink/gen/assets.gen.dart';

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
                  return CoreKit.init(
                    
                    appbarConfig: AppbarConfig(
                      // height: 120, 

                      titleColor: () => context.colors.tEXT_white,
                        
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            color: context.colors.bACKGROUND_darkCardBoarder,
                            width: 1.5,
                          ),
                        ),
                        borderRadius: const BorderRadius.only(
                          bottomLeft: Radius.circular(20),
                          bottomRight: Radius.circular(20),
                        ),
                        color: Colors.transparent,
                      ), 
                      onBack: () {
                        appRouter.pop();
                      },

                      actions: [
                        Builder(
                          builder: (context) {
                            return IconButton(
                              onPressed: () {
                                context.read<ThemeCubit>().toggleTheme();
                              },
                              icon: Icon(Icons.track_changes, color: context.colors.tEXT_white),
                            );
                          },
                        ),
                      ],

                      backButton: LayoutBuilder(
                        builder: (context, constraints) {
                          return Container(
                            padding: const EdgeInsets.all(10),
                            color: Colors.transparent,
                            child: CommonImage(
                              src: Assets.images.back,
                              imageColor: context.colors.tEXT_white,
                              fill: BoxFit.contain,
                            ),
                          );
                        }
                      ),
                    ),
                    designSize: const Size(393, 690),
                    imageBaseUrl: ApiEndPoint.instance.baseUrl,
                    navigatorKey: appRouter.navigatorKey,
                    dioServiceConfig: DioServiceConfig(
                      baseUrl: ApiEndPoint.instance.baseUrl,
                      refreshTokenEndpoint: ApiEndPoint.instance.refreshTokenEndpoint,
                      onLogout: () {
                        context.read<AuthCubit>().clearTokens();
                      },
                      enableDebugLogs: true,
                    ),
                    tokenProvider: TokenProvider(
                      accessToken: () async => (await StorageService.instance.accessToken) ?? '',
                      refreshToken: () async {
                        AppLogger.debug(
                          (await StorageService.instance.refreshToken).toString(),
                          tag: 'refreshToken',
                        );
                        return (await StorageService.instance.refreshToken) ?? '';
                      },
                      updateTokens: (data) async {
                        AppLogger.debug('Update Tokens', tag: 'updateTokens');
                        await context.read<AuthCubit>().updateTokens(
                          data['accessToken'],
                          data['refreshToken'],
                        );
                      },
                    ),
                    child: child,
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
