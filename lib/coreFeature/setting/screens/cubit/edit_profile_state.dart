/*
 * @Author: Km Muzahid
 * @Date: 2026-02-08 11:49:21
 * @Email: km.muzahid@gmail.com
 */
import 'package:equatable/equatable.dart';
import 'package:image_picker/image_picker.dart';

class PersonalInfoState extends Equatable {
  final XFile? profileImage;

  const PersonalInfoState({this.profileImage});

  @override
  List<Object?> get props => [profileImage];

  PersonalInfoState copyWith({XFile? profileImage}) {
    return PersonalInfoState(profileImage: profileImage ?? this.profileImage);
  }
}
