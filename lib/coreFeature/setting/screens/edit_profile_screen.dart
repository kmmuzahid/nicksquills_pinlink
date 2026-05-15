/*
 * @Author: Km Muzahid
 * @Date: 2026-02-08 11:43:05
 * @Email: km.muzahid@gmail.com
 */

import 'package:auto_route/auto_route.dart';
import 'package:core_kit/core_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pinlink/common_widgets/common_widget.dart';
import 'package:pinlink/common_widgets/custom_divider.dart';
import 'package:pinlink/config/bloc/cubit_scope.dart';
import 'package:pinlink/config/color/app_color.dart';
import 'package:pinlink/constant/app_string.dart';
import 'package:pinlink/constant/constants.dart';
import 'package:pinlink/coreFeature/auth/cubit/auth_cubit.dart';
import 'package:pinlink/coreFeature/setting/entity/update_profile_entity.dart';
import 'package:pinlink/coreFeature/setting/screens/cubit/edit_profile_cubit.dart';
import 'package:pinlink/coreFeature/setting/screens/cubit/edit_profile_state.dart';

@RoutePage()
class EditProfileScreen extends StatelessWidget {
  const EditProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final authCubit = context.read<AuthCubit>();

    final user = authCubit.state.profile;
    return Scaffold(
      appBar: const CommonAppBar(title: 'Edit Profile'),
      body: Padding(
        padding: Constants.bodyPadding,
        child: SafeArea(
          child: FormBuilder(
            entity: UpdateProfileEntity(),
            builder: (context, formKey, entity) {
              return CubitScope(
                create: () => PersonalInfoCubit(),
                builder: (context, cubit, state) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      20.height,
                      _imageBuilder(
                        state,
                        cubit,
                        context,
                        user?.profile,
                      ).center,
                      20.height,
                      _sectionHeader('Personal Information', context),
                      buildLabel('Name'),
                      CommonTextField(
                        hintText: "Enter your name",
                        initialText: user?.fullName,
                        validationType: ValidationType.notRequired,
                        isReadOnly: false,
                        onSaved: (value, _) => entity.name = value,
                      ),
                      10.height,

                      buildLabel('Username'),
                      CommonTextField(
                        hintText: "Enter your username",
                        initialText: user?.username,
                        validationType: ValidationType.validateAlphaNumeric,
                        isReadOnly: true,
                      ),
                      10.height,
                      buildLabel(AppString.email),
                      CommonTextField(
                        hintText: "Enter your email",
                        initialText: user?.email,
                        validationType: ValidationType.validateEmail,
                        isReadOnly: true,
                      ),
                      _sectionHeader('Location Details', context),
                      buildLabel('Hometown'),
                      CommonTextField(
                        hintText: "Enter your hometown",
                        initialText: user?.address,
                        validationType: ValidationType.notRequired,
                        isReadOnly: false,
                        onSaved: (value, _) => entity.address = value,
                      ),
                      10.height,
                      buildLabel('Home course'),
                      CommonTextField(
                        hintText: "Enter your home course",
                        initialText: user?.homeCourse,
                        validationType: ValidationType.notRequired,
                        isReadOnly: false,
                        onSaved: (value, _) => entity.homeCourse = value,
                      ),
                      _sectionHeader('Golf Details', context),
                      buildLabel('Estimated Handicap'),
                      CommonTextField(
                        hintText: "Enter your estimated handicap",
                        initialText: user?.handicap,
                        validationType: ValidationType.validateNumber,
                        isReadOnly: false,
                        onSaved: (value, _) => entity.handicap = value,
                      ),
                      40.height,
                      CommonButton(
                        titleText: AppString.save_all_changes,
                        buttonWidth: double.infinity,
                        onTap: () {
                          if (formKey.validateAndSave()) {
                            cubit.updateProfile(entity, authCubit);
                          }
                        },
                      ),
                      40.height,
                    ],
                  );
                },
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _sectionHeader(String title, BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CommonText(
          text: title,
          left: 10,
          fontSize: 16,
          fontWeight: FontWeight.w600,
          textColor: context.colors.tEXT_subDark,
        ),
        const Padding(
          padding: EdgeInsets.only(left: 10, right: 10),
          child: CustomDivider(),
        ),
        5.height,
      ],
    );
  }

  Widget _imageBuilder(
    PersonalInfoState state,
    PersonalInfoCubit cubit,
    BuildContext context,
    String? profileImage,
  ) {
    return Container(
      padding: const EdgeInsets.all(1),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(100),
        border: Border.all(color: context.colors.border_divider, width: 1.5),
      ),
      child: Stack(
        children: [
          CommonImage(
            src:
                state.profileImage?.path ??
                profileImage ??
                'https://picsum.photos/id/28/200/300',
            borderRadius: 100,
            height: 100,
            width: 100,
          ),
          Positioned(
            bottom: 0,
            right: 0,
            child: GestureDetector(
              onTap: cubit.setProfileImage,
              child: Container(
                padding: const EdgeInsets.all(4),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.camera_alt, color: Colors.green),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildLabel(String text) {
    return BuildLabel(text);
  }

  Widget buildTextField(
    String hint, {
    bool isReadonly = false,
    Widget? prefixIcon,
  }) {
    return CommonTextField(
      hintText: hint,
      validationType: ValidationType.notRequired,
      isReadOnly: isReadonly,
      prefixIcon: prefixIcon,
    );
  }
}
