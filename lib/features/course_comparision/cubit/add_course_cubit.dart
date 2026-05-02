/*
 * @Author: Km Muzahid
 * @Date: 2026-02-28 09:58:59
 * @Email: km.muzahid@gmail.com
 */
import 'package:pinlink/config/bloc/safe_cubit.dart';
import 'package:pinlink/constant/constants.dart';
import 'package:pinlink/constant/enums.dart';
import 'package:pinlink/features/course_comparision/cubit/add_course_state.dart';
import 'package:pinlink/features/course_comparision/model/comparison_model.dart';
import 'package:pinlink/features/course_comparision/model/course_model.dart';

class AddCourseCubit extends SafeCubit<AddCourseState> {
  AddCourseCubit() : super(const AddCourseState(tags: ['Alex', 'Bob']));

  Future<void> init() async {
    await Future.delayed(const Duration(milliseconds: 500));
    emit(
      state.copyWith(
        courses: List.generate(
          10,
          (index) => CourseModel(
            name: 'Augusta National $index',
            address: 'Scotland, United States $index',
            isAlreadyPlayed: index % 2 == 0,
          ),
        ),
        comparison: [
          ComparisonModel(
            question: 'Which course do you prefer?',
            options: [
              ComparisonOptionModel(
                title: 'Augusta National 1',
                isSelected: false,
                address: 'Scotland, United States',
                image: Constants.sampleImage,
              ),
              ComparisonOptionModel(
                title: 'Augusta National 3',
                isSelected: false,
                address: 'Scotland, United States',
                image: Constants.sampleImage,
              ),
            ],
          ),

          ComparisonModel(
            question: 'Which course was more challenging?',
            options: [
              ComparisonOptionModel(
                title: 'Augusta National',
                isSelected: false,
                address: 'Scotland, United States',
                image: Constants.sampleImage,
              ),
              ComparisonOptionModel(
                title: 'Augusta National 2',
                isSelected: false,
                address: 'Scotland, United States',
                image: Constants.sampleImage,
              ),
            ],
          ),
        ],
      ),
    );
  }

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
            .where((e) => e.name != course.name)
            .toList(),
      ),
    );
  }
}
