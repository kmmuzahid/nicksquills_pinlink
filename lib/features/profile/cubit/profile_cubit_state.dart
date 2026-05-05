import 'package:equatable/equatable.dart';
import 'package:pinlink/constant/enums.dart';
import 'package:pinlink/features/course_comparision/model/course_model.dart';

class ProfileCubitState extends Equatable {
  final FilterProfile selectedFilter;
  final List<CourseModel> courses;

  const ProfileCubitState({
    this.selectedFilter = FilterProfile.MyCourses,
    this.courses = const [],
  });

  @override
  List<Object?> get props => [selectedFilter, courses];

  ProfileCubitState copyWith({
    FilterProfile? selectedFilter,
    List<CourseModel>? courses,
  }) {
    return ProfileCubitState(
      selectedFilter: selectedFilter ?? this.selectedFilter,
      courses: courses ?? this.courses,
    );
  }
}
