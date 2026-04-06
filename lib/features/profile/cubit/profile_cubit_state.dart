import 'package:equatable/equatable.dart';
import 'package:pinlink/constant/enums.dart';

class ProfileCubitState extends Equatable {
  final FilterProfile selectedFilter;

  const ProfileCubitState({this.selectedFilter = FilterProfile.MyCourses});

  @override
  List<Object?> get props => [selectedFilter];

  ProfileCubitState copyWith({FilterProfile? selectedFilter}) {
    return ProfileCubitState(
      selectedFilter: selectedFilter ?? this.selectedFilter,
    );
  }
}
