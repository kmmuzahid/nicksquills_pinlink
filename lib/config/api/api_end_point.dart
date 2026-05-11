/*
 * @Author: Km Muzahid
 * @Date: 2026-01-07 12:29:06
 * @Email: km.muzahid@gmail.com
 */

String _domain = 'http://10.10.7.65:6000';

class ApiEndPoint {
  ApiEndPoint._();
  static final ApiEndPoint instance = ApiEndPoint._();
  final String domain = _domain;
  final String baseUrl = '$_domain/api/v1';
  final String refreshTokenEndpoint = '/auth/refresh-token';
  final String createUser = '/users/create';
  final String verifyOtp = '/users/verify-otp';
  final String login = '/auth/login';
  final String resetPassword = '/auth/forgot-password-reset';
  final String getProfile = '/user/profile';
  final String setting = '/setting';

  final String resendOtp = '/auth/resend-otp';
  final String forgotPasswordOtp = '/auth/forgot-password-otp';

  final String changePassword = '/auth/change-password';

  final String updateProfile = '/user/profile'; //patch
  final String logout = '/auth/logout';

  final String deleteAccount = '/user/delete-account';

  //app based

  final String userPlayedCourse = '/compareCourse/user'; //get

  final String createPostData = '/postData/create-postData';

  final String userPost = '/post/user';
}
