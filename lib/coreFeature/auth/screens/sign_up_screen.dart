/*
 * @Author: Km Muzahid
 * @Date: 2026-01-08 12:44:55
 * @Email: km.muzahid@gmail.com
 */
import 'package:auto_route/auto_route.dart';
import 'package:core_kit/core_kit.dart';
import 'package:flutter/material.dart';
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
import 'package:pinlink/coreFeature/auth/entity/signup_entity.dart';
import 'package:pinlink/coreFeature/auth/widgets/action_spawn_widget.dart';
import 'package:pinlink/coreFeature/auth/widgets/terms_agreement_widget.dart';

@RoutePage()
class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});
 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarGradientExpanded(),
      body: Padding(
        padding: Constants.bodyPadding,
        child: FormBuilder(
          entity: SignUpEntity(),
          builder: (context, formKey, entity) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                20.height,
                CommonText(
                  text: AppString.sign_up,
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w500,
                ).center,
                CommonText(
                  text: AppString.please_fill_the_details_and_create_account,
                  fontSize: 14,
                  textColor: AppColor.textGray,
                ).center,
                20.height,
        
                // Email Field
                BuildLabel(AppString.name),
                CommonTextField(
                  hintText: AppString.name,
                  validationType: ValidationType.validateRequired,
                  prefixIcon: const Icon(Icons.email_outlined),
                  onSaved: (value, controller) => entity.fullName = value,
                ),
                10.height,
                // Email Field
                BuildLabel(AppString.email),
                CommonTextField(
                  hintText: AppString.email,
                  validationType: ValidationType.validateEmail,
                  prefixIcon: const Icon(Icons.email_outlined),
                  onSaved: (value, controller) => entity.email = value,
                ),
                10.height,
        
                // Password Field
                BuildLabel(AppString.password),
                CommonTextField(
                  hintText: AppString.password,
                  validationType: ValidationType.validatePassword,
                  prefixIcon: const Icon(Icons.lock_outline),
                  onSaved: (value, controller) => entity.password = value,
                ),
                10.height,
        
                // Password Field
                BuildLabel(AppString.confirm_password),
                CommonTextField(
                  hintText: AppString.confirm_password,
                  originalPassword: () => entity.password ?? '',
                  validationType: ValidationType.validateConfirmPassword,
                  prefixIcon: const Icon(Icons.lock_outline),
                  onSaved: (value, controller) => entity.confirmPassword = value,
                ),
                20.height,
                TermsAgreementWidget(
                  onChanged: (value) {
                    entity.isAgree = value;
                  },
                ),
                20.height,

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
                          titleText: AppString.sign_up_as_parking_owner,
                          buttonWidth: double.infinity,
                        ),
                        20.height,
                        CommonButton(
                          borderColor: AppColor.textGray,
                          borderWidth: 1.5,
                          buttonColor: AppColor.background,
                          titleColor: AppColor.textGray,
                          onTap: () {
                            formKey.currentState?.save();
                            // if ((formKey.currentState?.validate() ?? false) && entity.isAgree) {
                            cubit.signup(entity);
                            // }
                          },
                          isLoading: state,
                          titleText: AppString.sign_in_as_ev_owner,
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
                    appRouter.replace(const LoginRoute());
                  },
                ).center,
                50.height,
              ],
            );
          },
        ),
      ),
    );
  }
}
