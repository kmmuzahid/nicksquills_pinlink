/*
 * @Author: Km Muzahid
 * @Date: 2026-02-08 11:54:24
 * @Email: km.muzahid@gmail.com
 */

import 'package:core_kit/core_kit.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pinlink/config/bloc/safe_cubit.dart';
import 'package:pinlink/coreFeature/profile/screens/cubit/personal_info_state.dart';

class PersonalInfoCubit extends SafeCubit<PersonalInfoState> {
  PersonalInfoCubit() : super(const PersonalInfoState());

  final ImagePicker _imagePicker = ImagePicker();

  Future<void> setProfileImage() async {
    print('setProfileImage');
    final status = await PermissionHelper.request(Permission.photos);
    if (status) {
      final image = await _imagePicker.pickImage(source: ImageSource.gallery);
      emit(state.copyWith(profileImage: image));
    }
  }
}
