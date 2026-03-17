/*
 * @Author: Km Muzahid
 * @Date: 2026-01-15 16:07:07
 * @Email: km.muzahid@gmail.com
 */
import 'package:core_kit/core_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pinlink/config/color/app_color.dart';
import 'package:pinlink/config/route/app_router.dart';
import 'package:pinlink/constant/app_string.dart';
import 'package:pinlink/coreFeature/auth/cubit/auth_cubit.dart';

class LogoutAlertWidget extends StatelessWidget {
  const LogoutAlertWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return _content(context);
  }

  Container _content(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: context.colors.bACKGROUND_darkCard,
        borderRadius: BorderRadius.circular(8),
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisSize: .min,
        children: [
          CommonText(
            text: '${AppString.logout.capitalize}?',
            maxLines: 2,
            textColor: Colors.red,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
          10.height,

          CommonText(
            text: AppString.are_you_sure_you_want_to_logout_of_your_account,
            maxLines: 2,
            textColor: context.colors.tEXT_white,
            fontSize: 16,
          ),

          20.height,

          Row(
            children: [
              CommonButton(
                titleText: AppString.no,
                titleColor: Colors.white,
                buttonWidth: 100,
                onTap: () {
                  navigatorRouterKey.currentState?.pop();
                }, 
              ),

              const Spacer(),
              CommonButton(
                titleText: AppString.yes,
                buttonWidth: 100,
                onTap: () {
                  context.read<AuthCubit>().logout();
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
