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
import 'package:pinlink/coreFeature/auth/model/profile_model.dart';

class AuthRepository {
  Future<ResponseState<dynamic>> signup(SignUpEntity entity) async {
    return DioService.instance.request(
      input: RequestInput(
        endpoint: ApiEndPoint.instance.createUser,
        method: .POST,
        jsonBody: {
          "fullName": entity.fullName,
          "email": entity.email,
          "username": entity.username,
          "password": entity.password,
          "role": "user", //ev_owner/ev_parking_owner
          "homeCourse": entity.homeCourse,
          "handicap": entity.handicap,
          "latitude": entity.latitude,
          "longitude": entity.longitude,
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
        headers: {
          'refreshtoken': refreshToken,
          'authorization': 'Bearer $accessToken',
        },
        endpoint: ApiEndPoint.instance.logout,
        method: .POST,
      ),
      responseBuilder: (data) {
        return data;
      },
    );
  }

  Future<ResponseState<dynamic>> sendOtp(
    String email, {
    required bool isResend,
    required String? resendToken,
  }) {
    return DioService.instance.request(
      showMessage: true,
      input: RequestInput(
        endpoint: isResend
            ? ApiEndPoint.instance.resendOtp
            : ApiEndPoint.instance.forgotPasswordOtp,
        method: .POST,
        jsonBody: {"email": email},
        headers: {if (isResend) "token": "$resendToken"},
      ),
      responseBuilder: (data) {
        return data;
      },
    );
  }

  Future<ResponseState<dynamic>> verifyOtp({
    required String email,
    required String otp,
    required String? token,
  }) {
    print(otp);
    print(email);
    return DioService.instance.request(
      showMessage: true,
      input: RequestInput(
        endpoint: ApiEndPoint.instance.verifyOtp,
        headers: {"token": "$token"},
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
        method: .PATCH,
        jsonBody: {
          "newPassword": entity.password,
          "confirmPassword": entity.confirmPassword,
        },
        headers: {"token": "${entity.verificationToken}"},
      ),
      responseBuilder: (data) {
        return data;
      },
    );
  }

  Future<ResponseState<ProfileModel?>> getProfile() {
    return DioService.instance.request(
      input: RequestInput(
        endpoint: ApiEndPoint.instance.getProfile,
        method: .GET,
      ),
      responseBuilder: (data) {
        return ProfileModel.fromJson(data);
      },
    );
  }
}
