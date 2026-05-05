/*
 * @Author: Km Muzahid
 * @Date: 2026-01-18 19:52:54
 * @Email: km.muzahid@gmail.com
 */
import 'package:core_kit/snackbar/snackbar.dart';
import 'package:pinlink/config/bloc/safe_cubit.dart';
import 'package:pinlink/config/route/app_router.dart';
import 'package:pinlink/config/route/app_router.gr.dart';
import 'package:pinlink/coreFeature/auth/cubit/auth_cubit.dart';
import 'package:pinlink/coreFeature/auth/entity/forget_pass_entity.dart';
import 'package:pinlink/coreFeature/auth/entity/login_entity.dart';
import 'package:pinlink/coreFeature/auth/entity/signup_entity.dart';
import 'package:pinlink/coreFeature/auth/repository/auth_repository.dart';

class AuthFlowCubit extends SafeCubit<bool> {
  AuthFlowCubit(this.authCubit) : super(false);
  final AuthCubit authCubit;
  final AuthRepository _authRepository = AuthRepository();

  Future<void> login(LoginEntity entity) async {
    //remove it on integration

    //uncomment it on integration
    emit(true);
    final result = await _authRepository.login(entity);
    emit(false);
    if (result.isSuccess) {
      await authCubit.updateTokens(
        result.data?['accessToken'] ?? '',
        result.data?['refreshToken'] ?? '',
      );
      appRouter.replaceAll([const NavigationRoute()]);
    } else {
      showSnackBar(result.message ?? '', type: SnackBarType.error);
      if (result.statusCode == 424) {
        appRouter.push(
          SendOtpRoute(
            onSuccess: ({required email, required token}) async {
              final loginEntity = LoginEntity();
              loginEntity.email = email;
              loginEntity.password = entity.password;
              login(loginEntity);
            },
            token: result.data?['token']?.toString() ?? '',
            username: entity.email!,
            showSendToField: true,
          ),
        );
      }
    }
  }

  Future<void> signup(SignUpEntity entity) async {
    //remove it on integration

    // appRouter.push(
    //   SendOtpRoute(
    //     onSuccess: ({required email, required token}) async {
    //       print('OTP Verified Successfully. Token: $token, Email: $email ');
    //       final loginEntity = LoginEntity();
    //       loginEntity.email = email;
    //       loginEntity.password = entity.password;
    //       login(loginEntity);
    //     },
    //     username: entity.email!,
    //     showSendToField: true,
    //   ),
    // );
    //uncomment it on integration
    emit(true);
    final result = await _authRepository.signup(entity);
    emit(false);
    if (result.isSuccess) {
      appRouter.push(
        SendOtpRoute(
          onSuccess: ({required email, required token}) async {
            final loginEntity = LoginEntity();
            loginEntity.email = email;
            loginEntity.password = entity.password;
            login(loginEntity);
          },
          username: entity.email!,
          showSendToField: true,
        ),
      );
    } else {
      showSnackBar(result.message ?? '', type: SnackBarType.error);
    }
  }

  Future<void> resetPassword(ForgetPassEntity entity) async {
    //remove it on integration
    // appRouter.replaceAll([const LoginRoute()]);
    //uncomment it on integration
    emit(true);
    final result = await _authRepository.resetPassword(entity);
    emit(false);
    if (result.isSuccess) {
      appRouter.replaceAll([const LoginRoute()]);
    } else {
      showSnackBar(result.message ?? '', type: SnackBarType.error);
    }
  }
}
