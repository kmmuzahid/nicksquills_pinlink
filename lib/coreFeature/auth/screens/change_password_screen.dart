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
import 'package:pinlink/config/color/app_color.dart';
import 'package:pinlink/constant/app_string.dart';
import 'package:pinlink/constant/constants.dart';
import 'package:pinlink/coreFeature/auth/cubit/auth_cubit.dart';
import 'package:pinlink/coreFeature/auth/cubit/auth_flow_cubit.dart';
import 'package:pinlink/coreFeature/auth/entity/change_password_entity.dart';

@RoutePage()
class ChangePasswordScreen extends StatelessWidget {
  const ChangePasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SimpleBackground(
      appBar: CommonAppBar(title: AppString.change_password),
      body: BlocProvider(
        create: (context) => AuthFlowCubit(context.read<AuthCubit>()),
        child: FormBuilder(
          entity: ChangePasswordEntity(),
          builder: (context, formKey, entity) {
            return Padding(
              padding: Constants.bodyPadding,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  40.height,
                  CommonText(
                    text: AppString.set_your_password,
                    textColor: context.colors.tEXT_white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ).center,
                  CommonText(
                    text: AppString
                        .in_order_to_keep_your_account_safe_you_need_to_create_a_strong_password,
                    maxLines: 2,
                    textAlign: TextAlign.center,
                    textColor: context.colors.tEXT_subDark,
                    fontSize: 16,
                  ),
                  20.height,

                  // Password Field
                  BuildLabel(AppString.current_password),
                  CommonTextField(
                    hintText: 'Current password',
                    validationType: ValidationType.validatePassword,
                    onSaved: (value, controller) {
                      entity.oldPassword = value;
                    },
                  ),
                  10.height,
                  BuildLabel(AppString.new_password),
                  CommonTextField(
                    hintText: 'New password',
                    validationType: ValidationType.validatePassword,
                    onSaved: (value, controller) => entity.newPassword = value,
                  ),
                  10.height,
                  BuildLabel(AppString.confirm_new_password),
                  CommonTextField(
                    hintText: 'Confirm new password',
                    originalPassword: () => entity.newPassword ?? '',
                    validationType: ValidationType.validateConfirmPassword,
                  ),
                  40.height,

                  CommonButton(
                    onTap: () {
                      if (formKey.validateAndSave()) {
                        context.read<AuthFlowCubit>().changePassword(entity);
                      }
                    },
                    titleText: AppString.change_password_button,
                    buttonWidth: double.infinity,
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
