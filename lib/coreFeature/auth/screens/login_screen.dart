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
import 'package:pinlink/common_widgets/auth_background.dart';
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
import 'package:pinlink/coreFeature/auth/screens/sign_up_screen.dart';
import 'package:pinlink/coreFeature/auth/widgets/action_spawn_widget.dart';
import 'package:pinlink/coreFeature/auth/widgets/auth_sigmented_container.dart';
import 'package:pinlink/gen/assets.gen.dart';

@RoutePage()
class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AuthBackground(
      appBar: CommonAppBar(
        title: '',
        disableBack: true,
        hideBack: true,
        appbarConfig: AppbarConfig(backgroundColor: Colors.transparent),
      ),
      body: Padding(
        padding: Constants.bodyPadding,
        child: AuthSigmentedContainer(
          loginWidget: (changeToLogin) => _loginForm(changeToSingup: changeToLogin),
          signupWidget: (changeToSignup) => SignUpScreen(changeToLogin: changeToSignup),
        ),
      ),
    );
  }
}

class _loginForm extends StatelessWidget {
  const _loginForm({super.key, required this.changeToSingup});

  final Function() changeToSingup;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 16),
      decoration: BoxDecoration(
        color: AppColor.bACKGROUND_darkCard,
        borderRadius: const BorderRadius.all(Radius.circular(16)),
      ),
      child: FormBuilder(
        entity: LoginEntity(),
        scrollPhysics: const NeverScrollableScrollPhysics(),
        builder: (context, formKey, entity) => Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Email Field
            const BuildLabel('Email or Username'),
            CommonTextField(
              hintText: 'Email or Username',
              validationType: ValidationType.validateRequired,
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
                textColor: AppColor.sTATUS_error,
                fontSize: 12,
                style: TextStyle(
                  decoration: TextDecoration.underline,
                  decorationThickness: 2,
                  fontStyle: FontStyle.italic,
                  decorationColor: AppColor.sTATUS_error,
                ),
                fontWeight: FontWeight.bold,
              ).end,
            ),

            30.height,

            CubitScope(
              create: () => AuthFlowCubit(context.read<AuthCubit>()),
              builder: (context, cubit, state) {
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CommonButton(
                      isLoading: state,
                      onTap: () {
                        formKey.currentState?.save();
                        // if ((formKey.currentState?.validate() ?? false)) {
                        cubit.login(entity);
                        // }
                      },
                      titleText: 'Sign In',
                      buttonWidth: double.infinity,
                      // gradient: const LinearGradient(
                      //   colors: [Color(0xFF184F3A), Color(0xFF2F6F57)],
                      //   begin: Alignment.topCenter,
                      //   end: Alignment.bottomCenter,
                      // ),
                    ),

                    25.height,
                    Center(
                      child: CommonText(
                        text: AppString.or_continue_with,
                        textColor: AppColor.tEXT_sub,
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    15.height,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: CommonButton(
                            titleText: 'Google',
                            buttonColor: Colors.transparent,
                            borderColor: const Color(0xFF6FAE97),
                            prefix: CommonImage(
                              size: 25,
                              fill: BoxFit.contain,
                              src: Assets.images.google,
                            ),
                            onTap: () {},
                          ),
                        ),
                        20.width,
                        Expanded(
                          child: CommonButton(
                            titleText: 'Google',
                            buttonColor: Colors.transparent,
                            borderColor: const Color(0xFF6FAE97),
                            prefix: CommonImage(
                              size: 25,
                              fill: BoxFit.contain,
                              src: Assets.images.apple.path,
                              imageColor: Colors.white,
                            ),
                            onTap: () {},
                          ),
                        ),
                      ],
                    ),
                  ],
                );
              },
            ),

            30.height,

            ActionSpawnWidget(
              title: AppString.dont_have_an_account,
              actionTitle: AppString.sign_up,
              onTap: () {
                changeToSingup.call();
              },
            ).center,
          ],
        ),
      ),
    );
  }
}
