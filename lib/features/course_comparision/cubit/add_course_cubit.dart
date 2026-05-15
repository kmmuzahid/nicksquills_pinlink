/*
 * @Author: Km Muzahid
 * @Date: 2026-02-28 09:58:59
 * @Email: km.muzahid@gmail.com
 */
import 'package:pinlink/config/bloc/safe_cubit.dart';
import 'package:pinlink/config/dependency/dependency_injection.dart';
import 'package:pinlink/constant/enums.dart';
import 'package:pinlink/features/course_comparision/cubit/add_course_state.dart';
import 'package:pinlink/features/course_comparision/model/user_course_model.dart';
import 'package:pinlink/features/course_comparision/repository/course_repository.dart';

class AddCourseCubit extends SafeCubit<AddCourseState> {
  AddCourseCubit() : super(const AddCourseState(tags: ['Alex', 'Bob']));
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

  void selectCourse(UserCourseModel course) {
    emit(state.copyWith(selectedCourses: [...state.selectedCourses, course]));
  }

  void unselectCourse(UserCourseModel course) {
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
}
