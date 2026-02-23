/*
 * @Author: Km Muzahid
 * @Date: 2026-02-18 09:39:56
 * @Email: km.muzahid@gmail.com
 */
/*
 * @Author: Km Muzahid
 * @Date: 2026-01-08 12:44:55
 * @Email: km.muzahid@gmail.com
 */
import 'package:core_kit/core_kit.dart';
import 'package:flutter/material.dart';
import 'package:pinlink/config/bloc/cubit_scope.dart';
import 'package:pinlink/config/color/app_color.dart';
import 'package:pinlink/constant/app_string.dart';
import 'package:pinlink/coreFeature/auth/cubit/auth_cubit.dart';
import 'package:pinlink/coreFeature/auth/cubit/auth_flow_cubit.dart';
import 'package:pinlink/coreFeature/auth/entity/signup_entity.dart';
import 'package:pinlink/coreFeature/auth/widgets/action_spawn_widget.dart';
import 'package:pinlink/coreFeature/auth/widgets/signup_form_one.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key, required this.changeToLogin});

  final Function() changeToLogin;

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  int page = 0;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 16, bottom: 16, left: 16, right: 16),
      decoration: BoxDecoration(
        color: const Color(0xFF052217).withOpacity(0.9),
        borderRadius: const BorderRadius.all(Radius.circular(16)),
      ),
      child: FormBuilder(
        entity: SignUpEntity(),
        scrollPhysics: const NeverScrollableScrollPhysics(),
        builder: (context, formKey, entity) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: List.generate(
                  4,
                  (index) => Expanded(
                    child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 2),
                      height: 8,
                      decoration: BoxDecoration(
                        border: Border.all(color: AppColor.white),
                        borderRadius: BorderRadius.circular(5),
                        color: page == index ? AppColor.primary : AppColor.white,
                      ),
                    ),
                  ),
                ),
              ),
              CommonText(text: 'Page ${page + 1} of 4', textColor: AppColor.textSubDark).center,
              2.height,
              CommonText(text: getTitle(), fontSize: 16, fontWeight: FontWeight.w500),
              Divider(color: AppColor.outlineColor),

              Expanded(child: SingleChildScrollView(child: getPage(page, formKey, entity))),

              CubitScope(
                create: () => AuthFlowCubit(AuthCubit()),
                builder: (context, cubit, state) {
                  return Column(
                    children: [
                      CommonButton(
                        onTap: () {
                          formKey.currentState?.save();
                          // if ((formKey.currentState?.validate() ?? false) && entity.isAgree) {
                          cubit.signup(entity);
                          // }
                        },
                        isLoading: state,
                        titleText: page == 3 ? 'Create Account' : 'Continue',
                        buttonWidth: double.infinity,
                      ),
                    ],
                  );
                },
              ),

              30.height,

              ActionSpawnWidget(
                title: AppString.have_you_already_an_account,
                actionTitle: AppString.sign_in,
                onTap: () {
                  widget.changeToLogin.call();
                },
              ).center,
              15.height,
            ],
          );
        },
      ),
    );
  }

  Widget getPage(int page, GlobalKey<FormState> formKey, SignUpEntity entity) {
    switch (page) {
      case 0:
        return SignupFormOne(formKey: formKey, entity: entity);
      case 1:
        return Container();
      case 2:
        return Container();
      default:
        return Container();
    }
  }

  String getTitle() {
    switch (page) {
      case 0:
        return 'Personal Information';
      case 1:
        return 'Location Details';
      case 2:
        return 'Golf Details';
      default:
        return 'Review & Confirm';
    }
  }
}
