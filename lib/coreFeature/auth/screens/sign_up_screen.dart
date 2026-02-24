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
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pinlink/config/bloc/cubit_scope.dart';
import 'package:pinlink/config/color/app_color.dart';
import 'package:pinlink/config/route/app_router.dart';
import 'package:pinlink/config/route/app_router.gr.dart';
import 'package:pinlink/constant/app_string.dart';
import 'package:pinlink/coreFeature/auth/cubit/auth_cubit.dart';
import 'package:pinlink/coreFeature/auth/cubit/auth_flow_cubit.dart';
import 'package:pinlink/coreFeature/auth/entity/signup_entity.dart';
import 'package:pinlink/coreFeature/auth/widgets/action_spawn_widget.dart';
import 'package:pinlink/coreFeature/auth/widgets/signup_form_one.dart';
import 'package:pinlink/coreFeature/auth/widgets/signup_form_two.dart';
import 'package:pinlink/coreFeature/auth/widgets/signup_overview.dart';
import 'package:pinlink/coreFeature/auth/widgets/singup_form_three.dart';

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
        color: AppColor.cardColor,
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
                        color: page >= index ? AppColor.primary : AppColor.white,
                      ),
                    ),
                  ),
                ),
              ),
              6.height,
              CommonText(
                text: 'Step ${page + 1} of 4',
                textColor: AppColor.textSubDark,
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ).center,
              8.height,
              CommonText(
                text: getTitle(),
                fontSize: 18,
                fontWeight: FontWeight.w600,
                textColor: AppColor.textSubDark,
              ),
              Divider(color: AppColor.outlineColor),

              Column(
                children: [
                  getPage(page, formKey, entity),

                  CubitScope(
                    create: () => AuthFlowCubit(context.read<AuthCubit>()),
                    builder: (context, cubit, state) {
                      return Column(
                        children: [
                          CommonButton(
                            onTap: () {
                              formKey.currentState?.save();
                              if (page < 3) {
                                setState(() {
                                  page++;
                                });
                              }
                              if (page == 3) {
                                appRouter.push(
                                  SendOtpRoute(
                                    onSuccess: ({required String email, required String token}) {},
                                    username: entity.username ?? '',
                                    showSendToField: true,
                                  ),
                                );
                              }
                              // if ((formKey.currentState?.validate() ?? false) && entity.isAgree &&  page == 3) {
                              // cubit.signup(entity);
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

                  if (page > 0)
                    Padding(
                      padding: const EdgeInsets.only(top: 16),
                      child: CommonButton(
                        onTap: () {
                          setState(() {
                            page--;
                          });
                        },
                        titleText: 'Back',
                        buttonColor: const Color(0xFF052217).withOpacity(0.9),
                        borderColor: AppColor.primary,
                        buttonWidth: double.infinity,
                      ),
                    ),

                  30.height,
                ],
              ),

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
        return SignupFormTwo(formKey: formKey, entity: entity);
      case 2:
        return SignupFormThree(formKey: formKey, entity: entity);
      default:
        return SignUpOverview(entity: entity);
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
