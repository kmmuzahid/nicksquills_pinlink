/*
 * @Author: Km Muzahid
 * @Date: 2026-01-08 12:44:55
 * @Email: km.muzahid@gmail.com
 */
import 'package:auto_route/auto_route.dart';
import 'package:core_kit/core_kit.dart';
import 'package:flutter/material.dart';
import 'package:pinlink/common_widgets/common_widget.dart';
import 'package:pinlink/common_widgets/simple_background.dart';
import 'package:pinlink/config/color/app_color.dart';
import 'package:pinlink/config/route/app_router.dart';
import 'package:pinlink/config/route/app_router.gr.dart';
import 'package:pinlink/constant/app_string.dart';
import 'package:pinlink/constant/constants.dart';

@RoutePage()
class ChangePasswordScreen extends StatelessWidget {
  const ChangePasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SimpleBackground( 
      appBar: CommonAppBar(
        title: AppString.change_password,
        
      ),
      body: Padding(
        padding: Constants.bodyPadding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            40.height, 
            CommonText(
              text: AppString.set_your_password,
              textColor: Colors.black,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ).center,
            CommonText(
              text:
                  AppString.in_order_to_keep_your_account_safe_you_need_to_create_a_strong_password,
              maxLines: 2,
              textAlign: TextAlign.center,
              textColor: context.colors.tEXT_white,
              fontSize: 16,
            ),
            20.height,

            // Password Field
            BuildLabel(AppString.current_password),
            CommonTextField(
              hintText: AppString.enter_current_password_here,
              validationType: ValidationType.validatePassword,
              prefixIcon: const Icon(Icons.lock_outline),
              onSaved: (value, controller) {},
            ),
            10.height,
            BuildLabel(AppString.new_password),
            CommonTextField(
              hintText: AppString.enter_new_password_here,
              validationType: ValidationType.validatePassword,
              prefixIcon: const Icon(Icons.lock_outline),
              onSaved: (value, controller) {},
            ),
            10.height,
            BuildLabel(AppString.confirm_new_password),
            CommonTextField(
              hintText: AppString.enter_confirm_new_password_here,
              validationType: ValidationType.validatePassword,
              prefixIcon: const Icon(Icons.lock_outline),
              onSaved: (value, controller) {},
            ),
            40.height,

            CommonButton(
              onTap: () {
                appRouter.replaceAll([const LoginRoute()]);
              },
              titleText: AppString.change_password_button,
              buttonWidth: double.infinity, 
            ),
          ],
        ),
      ),
    );
  }
}
