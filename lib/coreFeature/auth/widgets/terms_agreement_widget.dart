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
                  checkColor: Colors.white,

                  fillColor: WidgetStateProperty.resolveWith<Color>((states) {
                    if (states.contains(WidgetState.disabled)) {
                      return AppColor.outlineColor;
                    }
                    if (states.contains(WidgetState.error) &&
                        !states.contains(WidgetState.selected)) {
                      return AppColor.white;
                    }
                    if (states.contains(WidgetState.selected)) {
                      return Colors.blue;
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
                            color: AppColor.textGray,
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
                          style: TextStyle(color: AppColor.textGray),
                        ),
                        TextSpan(
                          text: "Terms of Conditions",
                          style: TextStyle(
                            color: AppColor.textGray,
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
