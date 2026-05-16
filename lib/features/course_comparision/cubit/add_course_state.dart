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
  final int selectedComparisonCourseIndex; // compare set generated for
  final List<String> tags;
  final List<CourseModel> comparison; //compare set for the slectedCourseIndex
  final RankingType rankingType;
  final bool isCourseLoading;
  final bool showSkip;

  const AddCourseState({
    this.courses = const [],
    this.selectedCourses = const [],
    this.selectedComparisonCourseIndex = 0,
    this.tags = const [],
    this.comparison = const [],
    this.rankingType = RankingType.courseRanking,
    this.isCourseLoading = false,
    this.showSkip = false,
  });

  @override
  List<Object?> get props => [
    courses,
    selectedCourses,
    selectedComparisonCourseIndex,
    tags,
    comparison,
    rankingType,
    isCourseLoading,
    showSkip,
  ];

  AddCourseState copyWith({
    List<CourseModel>? courses,
    List<CourseModel>? selectedCourses,
    List<String>? tags,
    List<CourseModel>? comparison,
    int? selectedComparisonCourseIndex,
    RankingType? rankingType,
    bool? isCourseLoading,
    bool? showSkip,
  }) {
    return AddCourseState(
      courses: courses ?? this.courses,
      selectedCourses: selectedCourses ?? this.selectedCourses,
      selectedComparisonCourseIndex:
          selectedComparisonCourseIndex ?? this.selectedComparisonCourseIndex,
      tags: tags ?? this.tags,
      comparison: comparison ?? this.comparison,
      rankingType: rankingType ?? this.rankingType,
      isCourseLoading: isCourseLoading ?? this.isCourseLoading,
      showSkip: showSkip ?? this.showSkip,
    );
  }
}
