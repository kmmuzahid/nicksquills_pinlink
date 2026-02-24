/*
 * @Author: Km Muzahid
 * @Date: 2026-01-08 17:09:20
 * @Email: km.muzahid@gmail.com
 */
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:pinlink/config/color/app_color.dart';
import 'package:pinlink/config/route/app_router.dart';
import 'package:pinlink/config/route/app_router.gr.dart';

class TermsAgreementWidget extends StatelessWidget {
  final void Function(bool)? onChanged;

  const TermsAgreementWidget({this.onChanged, super.key});

  @override
  Widget build(BuildContext context) {
    return FormField<bool>(
      initialValue: false,
      validator: (value) {
        if (value != true) {
          return 'You must agree to the terms';
        }
        return null;
      },
      builder: (field) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [ 
                Checkbox(
                  isError: field.hasError,
                  checkColor: AppColor.tEXT_white,

                  fillColor: WidgetStateProperty.resolveWith<Color>((states) {
                    if (states.contains(WidgetState.disabled)) {
                      return AppColor.tEXT_subDark;
                    }
                    if (states.contains(WidgetState.error) &&
                        !states.contains(WidgetState.selected)) {
                      return AppColor.tEXT_white;
                    }
                    if (states.contains(WidgetState.selected)) {
                      return AppColor.successVerifiedPositivestats_freshGrass;
                    }
                    return Colors.white;
                  }),
                  value: field.value,
                  onChanged: (value) {
                    field.didChange(value);
                    if (onChanged != null) onChanged!(value ?? false);
                  },
                ),

                Expanded(
                  child: RichText(
                    text: TextSpan(
                      style: const TextStyle(fontSize: 12),
                      children: [
                        // TextSpan(
                        //   text: "By creating an account, you agree to our ",
                        //   style: TextStyle(color: AppColor.onPrimary),
                        // ),
                        TextSpan(
                          text: "Privacy Policy",
                          style: TextStyle(
                            color: AppColor.sTATUS_info,
                            fontWeight: FontWeight.w600,
                            decoration: TextDecoration.underline,
                          ),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              appRouter.push(const PrivacyPolicyRoute());
                            },
                        ),

                        TextSpan(
                          text: " - ",
                          style: TextStyle(color: AppColor.tEXT_sub),
                        ),
                        TextSpan(
                          text: "Terms of Conditions",
                          style: TextStyle(
                            color: AppColor.sTATUS_info,
                            fontWeight: FontWeight.w600,
                            decoration: TextDecoration.underline,
                          ),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              appRouter.push(const TermsOfUseRoute());
                            },
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}
