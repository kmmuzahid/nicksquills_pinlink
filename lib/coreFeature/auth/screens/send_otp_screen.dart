/*
 * @Author: Km Muzahid
 * @Date: 2026-01-11 11:15:26
 * @Email: km.muzahid@gmail.com
 */
import 'package:auto_route/auto_route.dart';
import 'package:core_kit/core_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pinlink/common_widgets/appbar/appbar_gradient_expanded.dart';
import 'package:pinlink/config/bloc/cubit_scope.dart';
import 'package:pinlink/config/color/app_color.dart';
import 'package:pinlink/constant/app_string.dart';
import 'package:pinlink/coreFeature/auth/cubit/otp_cubit.dart';
import 'package:pinlink/coreFeature/auth/widgets/otp_input_widget.dart';
import 'package:pinlink/coreFeature/auth/widgets/otp_send_widget.dart';

@RoutePage()
class SendOtpScreen extends StatelessWidget {
  const SendOtpScreen({
    super.key,
    required this.onSuccess,
    required this.username,
    this.showSendToField = false,
  });
  final Function({required String token, required String email}) onSuccess;
  final String username;
  final bool showSendToField;

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBarGradientExpanded(),
    body: Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: CubitScope(
        create: () {
          final cubit = OtpCubit();
          if (showSendToField) {
            cubit.alreadyOtpSent(username);
          }
          return cubit;
        },
        builder: (context, cubit, state) {
          return Column(
            children: [
              50.height,
              if (!showSendToField && !state.isOtpSent && !state.isResend)
               ...[
                CommonText(
                  text: AppString.forget_password.toUpperCase(),
                  fontSize: 18,

                  alignment: MainAxisAlignment.center,
                ),
                CommonText(
                  text: AppString.enter_your_email_account_to_rest_your_password,
                  fontSize: 16,
                  textColor: AppColor.textGray,
                  isDescription: true,
                  alignment: MainAxisAlignment.center,
                ),
              ],

              if (state.isOtpSent || state.isResend) ...[
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CommonText(
                      text: AppString.otp_verification.toUpperCase(),
                      style: getTheme.textTheme.bodyLarge,
                      alignment: MainAxisAlignment.center,
                    ),
                    if (!showSendToField)
                      IconButton(
                        onPressed: () {
                          context.read<OtpCubit>().resetState();
                        },
                        icon: Icon(Icons.edit_note_outlined, color: AppColor.primary),
                      ),
                  ],
                ),
              ],
              if (state.isOtpSent)
                ...[
                CommonText(
                  text:
                      '${AppString.verification_code_has_been_sent_to} ${username.isNotEmpty ? username : state.username}',
                  fontSize: 14,
                  textColor: AppColor.textSecondary,
                  isDescription: true,
                  alignment: MainAxisAlignment.center,
                ),
              20.height,
                CommonText(
                  text: AppString.enter_verification_code,
                  textColor: AppColor.textGray,
                  fontSize: 12,
                ).start,
              ],
              4.height,
              AnimatedCrossFade(
                firstChild: OtpSend(
                  username: showSendToField ? username : null,
                  isSignUp: showSendToField,
                  cubit: cubit,
                ),
                secondChild: OtpInputWidget(
                  onSuccess: onSuccess,
                  state: state,
                  username: showSendToField ? username : null,
                  cubit: cubit,
                ),
                crossFadeState: showSendToField || state.isOtpSent || state.isResend
                    ? CrossFadeState.showSecond
                    : CrossFadeState.showFirst,
                duration: const Duration(milliseconds: 300), // Increase the duration
              ),

              const Spacer(),
              85.height,
            ],
          );
        },
      ),
    ),
  );
}
