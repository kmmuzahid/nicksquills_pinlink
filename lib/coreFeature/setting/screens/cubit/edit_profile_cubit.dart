/*
 * @Author: Km Muzahid
 * @Date: 2026-02-08 11:54:24
 * @Email: km.muzahid@gmail.com
 */

import 'package:core_kit/core_kit.dart';
import 'package:core_kit/network/request_input.dart';
import 'package:pinlink/config/api/api_end_point.dart';
import 'package:pinlink/config/bloc/safe_cubit.dart';
import 'package:pinlink/config/route/app_router.dart';
import 'package:pinlink/coreFeature/auth/cubit/auth_cubit.dart';
import 'package:pinlink/coreFeature/setting/entity/update_profile_entity.dart';
import 'package:pinlink/coreFeature/setting/screens/cubit/edit_profile_state.dart';

class PersonalInfoCubit extends SafeCubit<PersonalInfoState> {
  PersonalInfoCubit() : super(const PersonalInfoState());

  final ImagePicker _imagePicker = ImagePicker();

  Future<void> setProfileImage() async {
    final status = await PermissionHelper.request(Permission.photos);
    if (status) {
      final image = await _imagePicker.pickImage(source: ImageSource.gallery);
      emit(state.copyWith(profileImage: image));
    }
  }

  Future<void> updateProfile(
    UpdateProfileEntity updateProfileEntity,
    AuthCubit authCubit,
  ) async {
    final result = await DioService.instance.request(
      showMessage: true,
      input: RequestInput(
        endpoint: ApiEndPoint.instance.updateMyProfile,
        method: .PATCH,
        formFields: {
          "fullName": updateProfileEntity.name,
          "address": updateProfileEntity.address,
          "homeCourse": updateProfileEntity.homeCourse,
          "handicap": updateProfileEntity.handicap,
          "profile": state.profileImage,
        },
      ),
      responseBuilder: (data) => data,
    );
    if (result.isSuccess) {
      authCubit.getProfile();
      appRouter.pop();
    }
  }
}
