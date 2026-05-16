/*
 * @Author: Km Muzahid
 * @Date: 2026-02-28 09:58:59
 * @Email: km.muzahid@gmail.com
 */
import 'dart:ui';

import 'package:pinlink/config/bloc/safe_cubit.dart';
import 'package:pinlink/config/dependency/dependency_injection.dart';
import 'package:pinlink/constant/enums.dart';
import 'package:pinlink/coreFeature/auth/cubit/auth_cubit.dart';
import 'package:pinlink/features/course_comparision/cubit/add_course_state.dart';
import 'package:pinlink/features/course_comparision/model/course_model.dart';
import 'package:pinlink/features/course_comparision/repository/course_repository.dart';

class AddCourseCubit extends SafeCubit<AddCourseState> {
  AddCourseCubit({required this.authCubit})
    : super(const AddCourseState(tags: ['Alex', 'Bob']));
  final AuthCubit authCubit;
  final courseRepository = getIt<CourseRepository>();

  Future<void> init() async {}

  void setRankingType(RankingType rankingType) {
    emit(state.copyWith(rankingType: rankingType));
  }

  void addTag(String tag) {
    emit(state.copyWith(tags: [...state.tags, tag]));
  }

  void removeTag(String tag) {
    emit(state.copyWith(tags: state.tags.where((e) => e != tag).toList()));
  }

  void selectCourse(CourseModel course) {
    emit(state.copyWith(selectedCourses: [...state.selectedCourses, course]));
  }

  void unselectCourse(CourseModel course) {
    emit(
      state.copyWith(
        selectedCourses: state.selectedCourses
            .where((e) => e.id != course.id)
            .toList(),
      ),
    );
  }

  Future<void> getAllCourses({
    String? query,
    int page = 1,
    bool isRefresh = false,
  }) async {
    if (state.isCourseLoading) return;
    emit(
      state.copyWith(
        isCourseLoading: true,
        courses: isRefresh ? [] : state.courses,
      ),
    );
    final result = await courseRepository.getUserAvailableCourse(
      query: query,
      page: page,
    );
    if (result.isSuccess) {
      emit(state.copyWith(courses: result.data ?? [], isCourseLoading: false));
    } else {
      emit(state.copyWith(isCourseLoading: false));
    }
  }

  //ranking from here

  int initalRanked = 0;
  bool isInitalRankingDone = false;

  void showCompareSet({required bool isSelectedCourseRank}) {
    initalRanked = 0;
    isInitalRankingDone = false;
    inialRankedList.clear(); // Ensure we start fresh
    if (state.selectedCourses.length >= 2) {
      if (initalRanked == 0) {
        initalRanked = 2;
        emit(
          state.copyWith(
            comparison: state.selectedCourses.getRange(0, 2).toList(),
          ),
        );
      }
    } else {
      isInitalRankingDone = true;
    }
  }

  List<CourseModel> inialRankedList = [];

  void onSelectComparisonCourse(int pickedCourseIndex, VoidCallback onSuccess) {
    final loserIndex = pickedCourseIndex == 0 ? 1 : 0;
    final winnerIndex = pickedCourseIndex;

    inialRankedList.insert(0, state.comparison[loserIndex]);

    if (initalRanked < state.selectedCourses.length) {
      final nextCourse = state.selectedCourses[initalRanked];
      initalRanked++;

      final newComparison = List<CourseModel>.from(state.comparison);
      newComparison[loserIndex] = nextCourse;

      emit(state.copyWith(comparison: newComparison));
    } else {
      inialRankedList.insert(0, state.comparison[winnerIndex]);
      isInitalRankingDone = true;

      emit(
        state.copyWith(
          selectedCourses: List<CourseModel>.from(inialRankedList),
          comparison: const [],
        ),
      );
    }
    if (isInitalRankingDone) {
      //save directly if there is no privious course
      final isSaveDirectly = state.rankingType == RankingType.courseRanking
          ? (authCubit.state.profile?.allCompareCourseCount ?? 0) > 0
          : (authCubit.state.profile?.allWishlishCount ?? 0) > 0;

      _saveRankedList(isSaveDirectly, onSuccess);
    }
  }

  Future<void> _saveRankedList(bool isSaveDirectly, VoidCallback onDone) async {
    if (isSaveDirectly) {
    } else {
      print(state.selectedCourses.map((e) => e.name).toList());
    }
  }
}
