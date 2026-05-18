/*
 * @Author: Km Muzahid
 * @Date: 2026-02-28 09:58:59
 * @Email: km.muzahid@gmail.com
 */
import 'dart:ui';

import 'package:core_kit/core_kit_internal.dart';
import 'package:pinlink/config/bloc/safe_cubit.dart';
import 'package:pinlink/config/dependency/dependency_injection.dart';
import 'package:pinlink/constant/enums.dart';
import 'package:pinlink/coreFeature/auth/cubit/auth_cubit.dart';
import 'package:pinlink/features/course_comparision/cubit/add_course_state.dart';
import 'package:pinlink/features/course_comparision/model/course_model.dart';
import 'package:pinlink/features/course_comparision/repository/course_repository.dart';
import 'package:pinlink/features/profile/model/user_course_model.dart';

class AddCourseCubit extends SafeCubit<AddCourseState> {
  AddCourseCubit() : super(const AddCourseState(tags: ['Alex', 'Bob']));
  final courseRepository = getIt<CourseRepository>();

  final List<String> questions = [
    'Which course did you enjoy more?',
    'Which course had better scenery?',
    'Which course was more challenging?',
    'Which course had better tee box conditions?',
    'Which course had faster greens?',
    'Which course had better greens conditions?',
    'Which course had a nicer clubhouse?',
    'Which course offered better food and drink?',
  ];

  int _courseIndex = 0;
  int _bsLow = 0;
  int _bsHigh = 0;
  int _currentTotalExisting = 0;
  final Map<int, UserCourseModel> _rankCache = {};

  List<int> _matchupWinners = [];

  final Map<String, List<int>> _ratingWins = {};
  final Map<String, List<int>> _ratingTotals = {};
  final Map<String, int> _matchupCounts = {};

  VoidCallback? _onComplete;

  Future<void> init() async {
    emit(const AddCourseState());
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
            .where((e) => e.id != course.id)
            .toList(),
      ),
    );
  }

  final Debouncer _debouncer = Debouncer(milliseconds: 300);

  final String query = '';

  void searchCourse({String? query, int page = 1, bool isRefresh = false}) {
    _debouncer.run(() {
      query = '';
      getAllCourses(page: page, isRefresh: isRefresh);
    });
  }

  Future<void> getAllCourses({int page = 1, bool isRefresh = false}) async {
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

  void showCompareSet({
    required bool isSelectedCourseRank,
    required AuthCubit authCubit,
  }) {
    _courseIndex = 0;
    _matchupWinners.clear();
    _ratingWins.clear();
    _ratingTotals.clear();
    _matchupCounts.clear();
    _rankCache.clear();

    _currentTotalExisting = state.rankingType == RankingType.courseRanking
        ? (authCubit.state.profile?.allCompareCourseCount ?? 0)
        : (authCubit.state.profile?.allWishlishCount ?? 0);

    emit(state.copyWith(isRankingInProgress: true));

    _processNextCourse(authCubit);
  }

  void onSelectComparisonCourse(
    int pickedIndex,
    VoidCallback onSuccess,
    AuthCubit authCubit,
  ) {
    _onComplete = onSuccess;
    _matchupWinners.add(pickedIndex);

    if (state.currentQuestionIndex < 7) {
      emit(
        state.copyWith(currentQuestionIndex: state.currentQuestionIndex + 1),
      );
      return;
    }

    _onMatchupComplete(authCubit);
  }

  void onSkipComparisonQuestion(VoidCallback onSuccess, AuthCubit authCubit) {
    _onComplete = onSuccess;
    _matchupWinners.add(-1);

    if (state.currentQuestionIndex < 7) {
      emit(
        state.copyWith(currentQuestionIndex: state.currentQuestionIndex + 1),
      );
      return;
    }

    _onMatchupComplete(authCubit);
  }

  void _processNextCourse(AuthCubit authCubit) {
    if (_courseIndex >= state.selectedCourses.length) {
      _onAllCoursesRanked(authCubit);
      return;
    }

    final course = state.selectedCourses[_courseIndex];
    _rankCache.clear();

    if (_currentTotalExisting == 0) {
      _saveCourseDirect(course, 1000.0, 0, authCubit);
      return;
    }

    _bsLow = 0;
    _bsHigh = _currentTotalExisting - 1;
    _binarySearchStep(authCubit);
  }

  Future<void> _binarySearchStep(AuthCubit authCubit) async {
    if (_bsLow > _bsHigh) {
      await _finalizeCourseRank(_bsLow, authCubit);
      return;
    }

    final mid = (_bsLow + _bsHigh) ~/ 2;

    emit(state.copyWith(isComparisonLoading: true));

    final existingCourse = await _fetchCourseAtRank(mid);

    if (existingCourse == null) {
      emit(state.copyWith(isComparisonLoading: false));
      await _finalizeCourseRank(_bsLow, authCubit);
      return;
    }

    final newCourse = state.selectedCourses[_courseIndex];
    final existingAsModel = _userCourseToModel(existingCourse);

    emit(
      state.copyWith(
        comparison: [newCourse, existingAsModel],
        currentQuestionIndex: 0,
        isComparisonLoading: false,
      ),
    );
  }

  void _onMatchupComplete(AuthCubit authCubit) {
    final q1Winner = _matchupWinners[0];

    _recordRatings(state.comparison[0], state.comparison[1]);

    _matchupWinners = [];

    _handleBinarySearchAnswer(q1Winner, authCubit);
  }

  void _handleBinarySearchAnswer(int q1Winner, AuthCubit authCubit) {
    final mid = (_bsLow + _bsHigh) ~/ 2;

    if (q1Winner == 0) {
      _bsHigh = mid - 1;
    } else {
      _bsLow = mid + 1;
    }

    _binarySearchStep(authCubit);
  }

  Future<void> _finalizeCourseRank(
    int insertionIndex,
    AuthCubit authCubit,
  ) async {
    final course = state.selectedCourses[_courseIndex];
    double fractionalRank;

    if (_currentTotalExisting == 0) {
      fractionalRank = 1000.0;
    } else if (insertionIndex == 0) {
      final below = await _ensureCached(0);
      final belowRank = below?.customRank ?? 1000.0;
      fractionalRank = belowRank / 2;
    } else if (insertionIndex >= _currentTotalExisting) {
      final above = await _ensureCached(_currentTotalExisting - 1);
      final aboveRank = above?.customRank ?? (_currentTotalExisting * 1000.0);
      fractionalRank = aboveRank + 1000;
    } else {
      final above = await _ensureCached(insertionIndex - 1);
      final below = await _ensureCached(insertionIndex);
      final aboveRank = above?.customRank ?? (insertionIndex * 1000.0);
      final belowRank = below?.customRank ?? ((insertionIndex + 1) * 1000.0);
      fractionalRank = (aboveRank + belowRank) / 2;
    }

    _saveCourseDirect(course, fractionalRank, insertionIndex, authCubit);
  }

  Future<void> _saveCourseDirect(
    CourseModel course,
    double fractionalRank,
    int insertionIndex,
    AuthCubit authCubit,
  ) async {
    final courseId = course.id ?? '';
    final stars = _calculateStarRatings(courseId);

    final userCourse = UserCourseModel(
      courseId: Course(
        id: course.id,
        name: course.name,
        locationName: course.locationName,
        image: course.image,
      ),
      customRank: fractionalRank,
      favorite: stars[0],
      scenery: stars[1],
      difficulty: stars[2],
      teeBoxFairwayCondition: stars[3],
      greenSpeed: stars[4],
      greenCondition: stars[5],
      clubHouse: stars[6],
      foodDrink: stars[7],
    );

    await courseRepository.saveRank(
      courses: [userCourse],
      isWishListRank: state.rankingType == RankingType.wishlistRanking,
    );

    _currentTotalExisting++;
    _courseIndex++;
    _processNextCourse(authCubit);
  }

  void _onAllCoursesRanked(AuthCubit authCubit) {
    emit(state.copyWith(comparison: const [], isRankingInProgress: false));
    _onComplete?.call();
    authCubit.getProfile();
    showSnackBar(
      '${state.rankingType == RankingType.wishlistRanking ? 'Wishlist' : 'Course'} ranked successfully',
      type: .success,
    );
  }

  void _recordRatings(CourseModel course1, CourseModel course2) {
    final id1 = course1.id ?? '';
    final id2 = course2.id ?? '';

    _ratingWins.putIfAbsent(id1, () => List.filled(8, 0));
    _ratingWins.putIfAbsent(id2, () => List.filled(8, 0));
    _ratingTotals.putIfAbsent(id1, () => List.filled(8, 0));
    _ratingTotals.putIfAbsent(id2, () => List.filled(8, 0));
    _matchupCounts[id1] = (_matchupCounts[id1] ?? 0) + 1;
    _matchupCounts[id2] = (_matchupCounts[id2] ?? 0) + 1;

    for (var i = 0; i < 8; i++) {
      if (i < _matchupWinners.length) {
        if (_matchupWinners[i] == 0) {
          _ratingWins[id1]![i]++;
          _ratingTotals[id1]![i]++;
          _ratingTotals[id2]![i]++;
        } else if (_matchupWinners[i] == 1) {
          _ratingWins[id2]![i]++;
          _ratingTotals[id1]![i]++;
          _ratingTotals[id2]![i]++;
        }
      }
    }
  }

  List<double> _calculateStarRatings(String courseId) {
    final wins = _ratingWins[courseId] ?? List.filled(8, 0);
    final totals = _ratingTotals[courseId] ?? List.filled(8, 0);
    final totalMatchups = _matchupCounts[courseId] ?? 0;
    if (totalMatchups == 0) return List.filled(8, 3);

    return List.generate(8, (i) {
      final total = totals[i];
      if (total == 0) return 0;
      final winRate = wins[i] / total;
      return (winRate * 4).round() + 1;
    });
  }

  Future<UserCourseModel?> _fetchCourseAtRank(int rank) async {
    if (_rankCache.containsKey(rank)) return _rankCache[rank];

    final result = await courseRepository.rankData(
      rank: [rank + 1],
      isWishListRank: state.rankingType == RankingType.wishlistRanking,
    );

    if (result.isSuccess && result.data != null && result.data!.isNotEmpty) {
      _rankCache[rank] = result.data!.first;
      return result.data!.first;
    }
    return null;
  }

  Future<UserCourseModel?> _ensureCached(int rank) async {
    if (_rankCache.containsKey(rank)) return _rankCache[rank];
    return _fetchCourseAtRank(rank);
  }

  CourseModel _userCourseToModel(UserCourseModel uc) {
    return CourseModel(
      id: uc.courseId?.id,
      name: uc.courseId?.name,
      locationName: uc.courseId?.locationName,
      image: uc.courseId?.image,
      isPinkLink5: uc.courseId?.isPinkLink5,
      latitude: uc.courseId?.latitude,
      longitude: uc.courseId?.longitude,
    );
  }
}
