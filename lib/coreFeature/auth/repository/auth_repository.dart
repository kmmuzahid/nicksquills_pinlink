/*
 * @Author: Km Muzahid
 * @Date: 2026-01-18 14:40:49
 * @Email: km.muzahid@gmail.com
 */
import 'package:core_kit/core_kit.dart';
import 'package:core_kit/network/request_input.dart';
import 'package:pinlink/config/api/api_end_point.dart';
import 'package:pinlink/coreFeature/auth/entity/forget_pass_entity.dart';
import 'package:pinlink/coreFeature/auth/entity/login_entity.dart';
import 'package:pinlink/coreFeature/auth/entity/signup_entity.dart';

class AuthRepository {
  Future<ResponseState<dynamic>> signup(SignUpEntity entity) async {
    return DioService.instance.request(
      input: RequestInput(
        endpoint: ApiEndPoint.instance.createUser,
        method: .POST,
        jsonBody: {
          "name": entity.fullName,
          "email": entity.email,
          "password": entity.password,
          "role": "USER", //USER, ADMIN
        },
      ),
      responseBuilder: (data) {
        return data;
      },
    );
  }

  Future<ResponseState<dynamic>> login(LoginEntity entity) {
    return DioService.instance.request(
      input: RequestInput(
        endpoint: ApiEndPoint.instance.login,
        method: .POST,
        jsonBody: {"email": entity.email, "password": entity.password},
      ),
      responseBuilder: (data) {
        return data;
      },
    );
  }

  Future<ResponseState<dynamic>> logout({
    required String refreshToken,
    required String accessToken,
  }) {
    return DioService.instance.request(
      input: RequestInput(
        headers: {'refreshtoken': refreshToken, 'authorization': 'Bearer $accessToken'},
        endpoint: ApiEndPoint.instance.logout,
        method: .POST,
      ),
      responseBuilder: (data) {
        return data;
      },
    );
  }

  Future<ResponseState<dynamic>> sendOtp(String email) {
    return DioService.instance.request(
      showMessage: true,
      input: RequestInput(
        endpoint: ApiEndPoint.instance.resendOtp,
        method: .POST,
        jsonBody: {"email": email},
      ),
      responseBuilder: (data) {
        return data;
      },
    );
  }

  Future<ResponseState<dynamic>> verifyOtp({required String email, required String otp}) {
    return DioService.instance.request(
      showMessage: true,
      input: RequestInput(
        endpoint: ApiEndPoint.instance.verifyOtp,
        method: .POST,
        jsonBody: {"email": email, "otp": int.parse(otp)},
      ),
      responseBuilder: (data) {
        return data;
      },
    );
  }

  Future<ResponseState<dynamic>> resetPassword(ForgetPassEntity entity) {
    return DioService.instance.request(
      input: RequestInput(
        endpoint: ApiEndPoint.instance.resetPassword,
        method: .POST,
        jsonBody: {
          "email": entity.email ?? '',
          "newPassword": entity.password,
          "confirmPassword": entity.confirmPassword,
          "token": entity.verificationToken,
        },
      ),
      responseBuilder: (data) {
        return data;
      },
    );
  }
}
