import 'package:flutter/material.dart';
import 'package:pinlink/config/bloc/safe_cubit.dart';
import 'package:pinlink/constant/enums.dart';
import 'package:pinlink/features/profile/cubit/profile_cubit_state.dart';
import 'package:pinlink/features/course_comparision/model/course_model.dart';

class ProfileCubit extends SafeCubit<ProfileCubitState> {
  ProfileCubit() : super(const ProfileCubitState()) {
    init();
  }
  Map<String, ScrollController> controllers = {};

  void init() {
    emit(
      state.copyWith(
        courses: List.generate(
          20,
          (index) => CourseModel(
            name: 'Royal Melbourne $index',
            address: 'Australia',
            isAlreadyPlayed: false,
          ),
        ),
      ),
    );
  }

  void changeFilter(FilterProfile filter) {
    emit(state.copyWith(selectedFilter: filter));
  }

  void reorderCourses(int oldIndex, int newIndex) {
    if (oldIndex < newIndex) {
      newIndex -= 1;
    }
    final List<CourseModel> courses = List.from(state.courses);
    final CourseModel item = courses.removeAt(oldIndex);
    courses.insert(newIndex, item);
    emit(state.copyWith(courses: courses));
  }
}
