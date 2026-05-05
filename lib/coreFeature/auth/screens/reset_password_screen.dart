/*
 * @Author: Km Muzahid
 * @Date: 2026-01-08 12:44:55
 * @Email: km.muzahid@gmail.com
 */
import 'package:auto_route/auto_route.dart';
import 'package:core_kit/core_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pinlink/common_widgets/common_widget.dart';
import 'package:pinlink/common_widgets/simple_background.dart';
import 'package:pinlink/config/bloc/cubit_scope.dart';
import 'package:pinlink/config/color/app_color.dart';
import 'package:pinlink/constant/constants.dart';
import 'package:pinlink/coreFeature/auth/cubit/auth_cubit.dart';
import 'package:pinlink/coreFeature/auth/cubit/auth_flow_cubit.dart';
import 'package:pinlink/coreFeature/auth/entity/forget_pass_entity.dart';

@RoutePage()
class ResetPasswordScreen extends StatelessWidget {
  const ResetPasswordScreen({
    super.key,
    required this.verificationToken,
    required this.email,
  });
  final String verificationToken;
  final String email;

  @override
  Widget build(BuildContext context) {
    return SimpleBackground(
      appBar: const CommonAppBar(title: "Reset Password"),
      body: FormBuilder(
        entity: ForgetPassEntity()
          ..verificationToken = verificationToken
          ..email = email,
        builder: (context, formKey, entity) {
          return Padding(
            padding: Constants.bodyPadding,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                40.height,
                CommonText(
                  text: "Enter your new password below.",
                  textColor: context.colors.pRIMARY_priSoft,
                  fontSize: 16,
                ).center,

                20.height,

                // Password Field
                const BuildLabel("Password"),
                CommonTextField(
                  hintText: "Enter password here...",
                  validationType: ValidationType.validatePassword,
                  prefixIcon: const Icon(Icons.lock_outline),
                  onSaved: (value, controller) => entity.password = value,
                ),
                10.height,
                const BuildLabel("Confirm Password"),
                CommonTextField(
                  hintText: "Enter confirm password here...",
                  originalPassword: () => entity.password ?? '',
                  validationType: ValidationType.validateConfirmPassword,
                  prefixIcon: const Icon(Icons.lock_outline),
                  onSaved: (value, controller) =>
                      entity.confirmPassword = value,
                ),
                30.height,

                CubitScope(
                  create: () => AuthFlowCubit(context.read<AuthCubit>()),
                  builder: (context, cubit, state) {
                    return CommonButton(
                      onTap: () {
                        if (formKey.currentState?.validate() ?? false) {
                          cubit.resetPassword(entity);
                        }
                      },
                      isLoading: state,
                      titleText: "Reset Password",
                      buttonWidth: double.infinity,
                    );
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
