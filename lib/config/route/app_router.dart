/*
 * @Author: Km Muzahid
 * @Date: 2026-01-07 12:29:06
 * @Email: km.muzahid@gmail.com
 */
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:pinlink/config/route/app_router.gr.dart';

final GlobalKey<NavigatorState> navigatorRouterKey = GlobalKey<NavigatorState>();

final appRouter = AppRouter();

class AuthGuard extends AutoRouteGuard {
  @override
  void onNavigation(NavigationResolver resolver, StackRouter router) {
    /**
     * if(language is not slected then onboard){
     *   appRouter.replace(OnboardingRoute());
     *   return;
     * }
     * 
     * if(is not login){
     *   appRouter.replace(SignInOptionRoute());
     *   return;
     * }
     * 
     * if(login){
     *   appRouter.replace(HomeRoute());
     *   resolver.next();
     * return;
     * }
     */

    resolver.next();
  }
}

@AutoRouterConfig(replaceInRouteName: 'Screen|Page,Route')
class AppRouter extends RootStackRouter {
  AppRouter() : super(navigatorKey: navigatorRouterKey);
  @override
  List<AutoRouteGuard> get guards => [AuthGuard()];

  @override
  RouteType get defaultRouteType => const RouteType.cupertino();

  @override
  List<AutoRoute> get routes => [
    AutoRoute(page: SplashRoute.page, initial: true),
    AutoRoute(page: OnboardingRoute.page),
    AutoRoute(page: LoginRoute.page),
    AutoRoute(page: PrivacyPolicyRoute.page),
    AutoRoute(page: TermsOfUseRoute.page), 
    AutoRoute(page: SendOtpRoute.page),
    AutoRoute(page: NavigationRoute.page), 
    AutoRoute(page: ChangePasswordRoute.page),
    AutoRoute(page: NotificationRoute.page),
    AutoRoute(page: ResetPasswordRoute.page),
    AutoRoute(page: FaqRoute.page),
    AutoRoute(page: AboutUsRoute.page),
    AutoRoute(page: PersonalInformationRoute.page), 
    AutoRoute(page: SubscriptionsRoute.page), 
    AutoRoute(page: AddCourseRoute.page),
    AutoRoute(page: ComparisonRoute.page), 
    AutoRoute(page: CreatePostRoute.page),
    AutoRoute(page: PostDetailsRoute.page), 
    AutoRoute(page: FriendsRoute.page), 
  ];
}
