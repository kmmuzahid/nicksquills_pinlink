/*
 * @Author: Km Muzahid
 * @Date: 2026-02-08 11:43:05
 * @Email: km.muzahid@gmail.com
 */

import 'package:auto_route/auto_route.dart';
import 'package:core_kit/core_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pinlink/config/bloc/cubit_scope.dart';
import 'package:pinlink/constant/app_string.dart';
import 'package:pinlink/constant/constants.dart';
import 'package:pinlink/coreFeature/auth/cubit/auth_cubit.dart';
import 'package:pinlink/coreFeature/setting/screens/cubit/personal_info_cubit.dart';
import 'package:pinlink/coreFeature/setting/screens/cubit/personal_info_state.dart';

@RoutePage()
class PersonalInformationScreen extends StatelessWidget {
  const PersonalInformationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final authCubit = context.read<AuthCubit>();
    return Scaffold(
      appBar: CommonAppBar(title: AppString.personal_information),
      body: Padding(
        padding: Constants.bodyPadding,
        child: FormBuilder(
          entity: null,
          builder: (context, formKey, entity) {
            return CubitScope(
              create: () => PersonalInfoCubit(),
              builder: (context, cubit, state) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    20.height,
                    _imageBuilder(state, cubit).center,
                    20.height,
                    buildLabel(AppString.phone_number),

                    buildTextField("+0987654355", isReadonly: false),
                    SizedBox(height: 15.h),

                    buildLabel(AppString.email),
                    buildTextField("mrsalex@gmail.com", isReadonly: true),

                    40.height,
                    CommonButton(
                      titleText: AppString.save_all_changes,
                      buttonWidth: double.infinity,
                      onTap: () {},
                    ),
                  ],
                );
              },
            );
          },
        ),
      ),
    );
  }

  Stack _imageBuilder(PersonalInfoState state, PersonalInfoCubit cubit) {
    return Stack(
      children: [
        CommonImage(
          src: state.profileImage?.path ?? 'https://picsum.photos/id/28/200/300',
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
              decoration: const BoxDecoration(color: Colors.white, shape: BoxShape.circle),
              child: const Icon(Icons.camera_alt, color: Colors.green),
            ),
          ),
        ),
      ],
    );
  }

  Widget buildLabel(String text) {
    return Padding(
      padding: EdgeInsets.only(bottom: 8.h),
      child: Text(
        text,
        style: TextStyle(fontSize: 14.sp, color: Colors.black87, fontWeight: FontWeight.w500),
      ),
    );
  }

  Widget buildTextField(String hint, {bool isReadonly = false, Widget? prefixIcon}) {
    return Container(
      decoration: inputBoxDecoration(),
      child: CommonTextField(
        hintText: hint,
        validationType: ValidationType.notRequired,
        isReadOnly: isReadonly,
        prefixIcon: prefixIcon,
      ),
    );
  }

  BoxDecoration inputBoxDecoration() {
    return BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(8.r),
      border: Border.all(color: Colors.grey.shade100),
      boxShadow: [
        BoxShadow(color: Colors.black.withOpacity(0.02), blurRadius: 4, offset: const Offset(0, 2)),
      ],
    );
  }
}
