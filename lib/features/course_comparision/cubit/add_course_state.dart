/*
 * @Author: Km Muzahid
 * @Date: 2026-02-28 09:54:42
 * @Email: km.muzahid@gmail.com
 */
import 'package:equatable/equatable.dart';
import 'package:pinlink/constant/enums.dart';
import 'package:pinlink/features/course_comparision/model/course_model.dart';

class AddCourseState extends Equatable {
  final List<CourseModel> courses;
  final List<CourseModel> selectedCourses;
  final List<String> tags;
  final List<CourseModel> comparison;
  final RankingType rankingType;
  final bool isCourseLoading;

  const AddCourseState({
    this.courses = const [],
    this.selectedCourses = const [],
    this.tags = const [],
    this.comparison = const [],
    this.rankingType = RankingType.courseRanking,
    this.isCourseLoading = false,
  });

  @override
  List<Object?> get props => [
    courses,
    selectedCourses,
    tags,
    comparison,
    rankingType,
    isCourseLoading,
  ];

  AddCourseState copyWith({
    List<CourseModel>? courses,
    List<CourseModel>? selectedCourses,
    List<String>? tags,
    List<CourseModel>? comparison,
    RankingType? rankingType,
    bool? isCourseLoading,
  }) {
    return AddCourseState(
      courses: courses ?? this.courses,
      selectedCourses: selectedCourses ?? this.selectedCourses,
      tags: tags ?? this.tags,
      comparison: comparison ?? this.comparison,
      rankingType: rankingType ?? this.rankingType,
      isCourseLoading: isCourseLoading ?? this.isCourseLoading,
    );
  }
}
