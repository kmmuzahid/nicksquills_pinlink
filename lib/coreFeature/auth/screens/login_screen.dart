/*
 * @Author: Km Muzahid
 * @Date: 2026-02-01 09:37:24
 * @Email: km.muzahid@gmail.com
 */
/*
 * @Author: Km Muzahid
 * @Date: 2026-01-08 12:44:55
 * @Email: km.muzahid@gmail.com
 */
import 'package:auto_route/auto_route.dart';
import 'package:core_kit/core_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pinlink/common_widgets/appbar/appbar_gradient_expanded.dart';
import 'package:pinlink/common_widgets/common_widget.dart';
import 'package:pinlink/config/bloc/cubit_scope.dart';
import 'package:pinlink/config/color/app_color.dart';
import 'package:pinlink/config/route/app_router.dart';
import 'package:pinlink/config/route/app_router.gr.dart';
import 'package:pinlink/constant/app_string.dart';
import 'package:pinlink/constant/constants.dart';
import 'package:pinlink/coreFeature/auth/cubit/auth_cubit.dart';
import 'package:pinlink/coreFeature/auth/cubit/auth_flow_cubit.dart';
import 'package:pinlink/coreFeature/auth/entity/login_entity.dart';
import 'package:pinlink/coreFeature/auth/widgets/action_spawn_widget.dart';
import 'package:pinlink/gen/assets.gen.dart';

@RoutePage()
class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarGradientExpanded(hideBack: true),
      body: FormBuilder(
        entity: LoginEntity(),
        builder: (context, formKey, entity) => Padding(
          padding: Constants.bodyPadding,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              20.height,
              CommonText(
                text: AppString.sign_in_now,
                fontSize: 18.sp,
                fontWeight: FontWeight.w500,
              ).center,
              CommonText(
                text: AppString.please_sign_in_to_continue_our_app,
                fontSize: 14,
                textColor: AppColor.textGray,
              ).center,
              40.height,

              // Email Field
              BuildLabel(AppString.email),
              CommonTextField(
                hintText: AppString.email,
                validationType: ValidationType.validateEmail,
                prefixIcon: const Icon(Icons.email_outlined),
                onSaved: (value, controller) => entity.email = value,
              ),
              20.height,

              // Password Field
              BuildLabel(AppString.password),
              CommonTextField(
                hintText: AppString.password,
                validationType: ValidationType.validatePassword,
                prefixIcon: const Icon(Icons.lock_outline),
                onSaved: (value, controller) => entity.password = value,
              ),
              10.height,
              GestureDetector(
                onTap: () {
                  final email = entity.email ?? '';
                  appRouter.push(
                    SendOtpRoute(
                      onSuccess: ({required email, required token}) {
                        appRouter.push(ResetPasswordRoute(verificationToken: token, email: email));
                      },
                      username: email,
                    ),
                  );
                },
                child: CommonText(
                  text: AppString.forget_password,
                  textColor: AppColor.errorColor,
                  fontSize: 12,
                  style: TextStyle(
                    decoration: TextDecoration.underline,
                    decorationThickness: 2,
                    decorationColor: AppColor.errorColor,
                  ),
                  fontWeight: FontWeight.bold,
                ).end,
              ),

              30.height,

              CubitScope(
                create: () => AuthFlowCubit(context.read<AuthCubit>()),
                builder: (context, cubit, state) {
                  return Column(
                    children: [
                      CommonButton(
                        isLoading: state,
                        onTap: () {
                          formKey.currentState?.save();
                          // if ((formKey.currentState?.validate() ?? false)) {
                          cubit.login(entity);
                          // }
                        },
                        titleText: AppString.sign_in_as_parking_owner,
                        buttonWidth: double.infinity,
                      ),
                      20.height,

                      CommonButton(
                        isLoading: state,
                        onTap: () {
                          formKey.currentState?.save();
                          // if ((formKey.currentState?.validate() ?? false)) {
                          cubit.login(entity);
                          // }
                        },
                        titleText: AppString.sign_in_as_ev_owner,
                        buttonColor: AppColor.background,
                        titleColor: AppColor.textGray,
                        borderColor: AppColor.textGray,
                        buttonWidth: double.infinity,
                      ),

                      25.height,
                      Center(
                        child: CommonText(
                          text: AppString.or_continue_with,
                          textColor: AppColor.textGray,
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      10.height,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          GestureDetector(
                            onTap: () {},
                            child: CommonImage(
                              size: 38,
                              fill: BoxFit.contain,
                              src: Assets.images.google,
                            ),
                          ),
                          20.width,
                          GestureDetector(
                            onTap: () {},
                            child: CommonImage(
                              size: 33,
                              fill: BoxFit.contain,
                              src: Assets.images.apple.path,
                            ),
                          ),
                        ],
                      ),
                    ],
                  );
                },
              ),

              60.height,
              ActionSpawnWidget(
                title: AppString.dont_have_an_account,
                actionTitle: AppString.sign_up,
                onTap: () {
                  appRouter.push(const SignUpRoute());
                },
              ).center,

              50.height,
            ],
          ),
        ),
      ),
    );
  }
}
