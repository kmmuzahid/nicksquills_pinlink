/*
 * @Author: Km Muzahid
 * @Date: 2026-01-15 16:07:07
 * @Email: km.muzahid@gmail.com
 */
import 'package:core_kit/core_kit.dart';
import 'package:flutter/material.dart';
import 'package:pinlink/config/color/app_color.dart';
import 'package:pinlink/config/route/app_router.dart';
import 'package:pinlink/config/route/app_router.gr.dart';
import 'package:pinlink/constant/app_string.dart';

class AccountDeleteWidget extends StatelessWidget {
  const AccountDeleteWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColor.bACKGROUND_darkCard,
        borderRadius: BorderRadius.circular(8),
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisSize: .min,
        children: [
          CommonText(
            text: AppString.are_you_sure_you_want_to_delete_your_account.capitalize,
            maxLines: 2,
            textColor: Colors.red,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
          10.height,

          CommonText(
            text: AppString
                .please_be_aware_that_deleted_account_cannot_be_undone_all_your_data_will_be_lost,
            maxLines: 2,
            textColor: AppColor.tEXT_white,
            fontSize: 16,
          ),

          10.height,
          CommonText(
            text: AppString.enter_your_password_to_confirm,
            textColor: Colors.white,
            fontSize: 14,
          ).start,
          8.height,
          CommonTextField(
            borderColor: AppColor.bACKGROUND_clickableBorder,
            hintText: AppString.enter_your_password,
            validationType: ValidationType.validatePassword,
            prefixIcon: const Icon(Icons.lock_outline),
            suffixIcon: const Icon(Icons.visibility_off_outlined), 
          ),

          20.height,

          Row(
            children: [
              CommonButton(
                titleText: AppString.no,
                titleColor: AppColor.tEXT_subDark,
                buttonWidth: 100,
                onTap: () {
                  navigatorRouterKey.currentState?.pop();
                },
                buttonColor: AppColor.pRIMARY_brandClr,
                borderColor: AppColor.pRIMARY_brandClr,
              ),

              const Spacer(),
              CommonButton(
                titleText: AppString.yes,
                buttonWidth: 100,
                onTap: () {
                  appRouter.replace(const LoginRoute());
                },
                titleColor: Colors.white,
                buttonColor: Colors.red,
                borderColor: Colors.red,
              ),
            ],
          ),
          20.height,
        ],
      ),
    );
  }
}
