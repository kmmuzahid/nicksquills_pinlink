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
  final bool isComparisonLoading; // Loading flag for head-to-head fetch
  final bool showSkip;
  final int currentQuestionIndex; // 0-7 for the 8 rating dimensions
  final bool isRankingInProgress;

  const AddCourseState({
    this.courses = const [],
    this.selectedCourses = const [],
    this.selectedComparisonCourseIndex = 0,
    this.tags = const [],
    this.comparison = const [],
    this.rankingType = RankingType.courseRanking,
    this.isCourseLoading = false,
    this.isComparisonLoading = false,
    this.showSkip = false,
    this.currentQuestionIndex = 0,
    this.isRankingInProgress = false,
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
        isComparisonLoading,
        showSkip,
        currentQuestionIndex,
        isRankingInProgress,
      ];

  AddCourseState copyWith({
    List<CourseModel>? courses,
    List<CourseModel>? selectedCourses,
    List<String>? tags,
    List<CourseModel>? comparison,
    int? selectedComparisonCourseIndex,
    RankingType? rankingType,
    bool? isCourseLoading,
    bool? isComparisonLoading,
    bool? showSkip,
    int? currentQuestionIndex,
    bool? isRankingInProgress,
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
      isComparisonLoading: isComparisonLoading ?? this.isComparisonLoading,
      showSkip: showSkip ?? this.showSkip,
      currentQuestionIndex: currentQuestionIndex ?? this.currentQuestionIndex,
      isRankingInProgress: isRankingInProgress ?? this.isRankingInProgress,
    );
  }
}
