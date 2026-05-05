/*
 * @Author: Km Muzahid
 * @Date: 2026-01-07 14:10:08
 * @Email: km.muzahid@gmail.com
 */
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pinlink/config/bloc/safe_cubit.dart';
import 'package:pinlink/config/route/app_router.dart';
import 'package:pinlink/config/route/app_router.gr.dart'
    show LoginRoute, SubscriptionsRoute, OnboardingRoute;
import 'package:pinlink/config/storage/storage_key.dart';
import 'package:pinlink/constant/subscriptions.dart';
import 'package:pinlink/coreFeature/auth/cubit/auth_state.dart';
import 'package:pinlink/coreFeature/auth/repository/auth_repository.dart';
import 'package:pinlink/coreFeature/navigation/cubit/navigation_cubit.dart';

class AuthCubit extends SafeCubit<AuthState> {
  AuthCubit() : super(AuthState(subscriptionPlan: creatorPlan));
  final _delaySplash = const Duration(seconds: 3);
  final AuthRepository _authRepository = AuthRepository();

  Future<void> init() async {
    // await StorageService.instance.clearDb();
    await Future.delayed(_delaySplash);

    final token = await StorageService.instance.accessToken;
    if (token != null && token.isNotEmpty) {
      appRouter.replaceAll([SubscriptionsRoute(isBackDisabled: true)]);
      return;
    }

    final roleData = await StorageService.instance.role;

    appRouter.replace(const OnboardingRoute());

    // final accessToken = await StorageService.instance.accessToken;
    // final refreshToken = await StorageService.instance.refreshToken;
    // if ((accessToken?.isNotEmpty ?? false) && (refreshToken?.isNotEmpty ?? false)) {
    //   emit(AuthState(accessToken: accessToken!, refreshToken: refreshToken!, role: Role.));
    //   appRouter.replaceAll([const NavigationRoute()]);
    // } else {
    //   appRouter.replace(const OnboardingRoute());
    // }
  }

  Future<void> updateTokens(String accessToken, String refreshToken) async {
    emit(
      AuthState(
        accessToken: accessToken,
        refreshToken: refreshToken,
        subscriptionPlan: state.subscriptionPlan,
      ),
    );
    StorageService.instance.accessToken = accessToken;
    StorageService.instance.refreshToken = refreshToken;
  }

  Future<void> logout() async {
    // final result = await _authRepository.logout(
    //   refreshToken: state.refreshToken,
    //   accessToken: state.accessToken,
    // );
    // if (result.isSuccess) {
    //   clearTokens();
    // }

    clearTokens();
  }

  Future<void> updateSubscriptionPlan(Plan plan) async {
    emit(state.copyWith(subscriptionPlan: plan));
  }

  Future<void> clearTokens() async {
    await StorageService.instance.clearDb();
    emit(AuthState(subscriptionPlan: freePlan));
    appRouter.replaceAll([const LoginRoute()]);
    appRouter.navigatorKey.currentContext?.read<NavigationCubit>().changeIndex(
      0,
    );
  }
}
