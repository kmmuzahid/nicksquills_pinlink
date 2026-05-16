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
import 'package:pinlink/features/profile/model/user_course_model.dart';

class AddCourseCubit extends SafeCubit<AddCourseState> {
  AddCourseCubit() : super(const AddCourseState(tags: ['Alex', 'Bob']));
  final courseRepository = getIt<CourseRepository>();

  /// The 8 rating dimensions. Q1 (index 0) drives RANKING.
  /// Q1–Q8 all contribute to per-dimension STAR RATINGS.
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

  /// Human-readable labels for the 8 dimensions (used in logging).
  static const _dimLabels = [
    'Enjoyment (Q1)',
    'Scenery (Q2)',
    'Difficulty (Q3)',
    'Tee Box (Q4)',
    'Green Speed (Q5)',
    'Green Cond. (Q6)',
    'Clubhouse (Q7)',
    'Food & Drink (Q8)',
  ];

  // ─── Binary Search state ───
  int _courseIndex = 0; // which selected course we're currently inserting
  int _bsLow = 0;
  int _bsHigh = 0;
  int _currentTotalExisting = 0;
  final Map<int, UserCourseModel> _rankCache = {};

  // ─── Per-matchup: winners for each of the 8 questions ───
  List<int> _matchupWinners = [];

  // ─── Rating accumulation: courseId → [8 win counts] ───
  final Map<String, List<int>> _ratingWins = {};
  final Map<String, int> _matchupCounts = {};

  // ─── Stored reference to authCubit (set on each entry) ───
  AuthCubit? _authCubit;
  VoidCallback? _onComplete;

  Future<void> init() async {
    emit(const AddCourseState());
  }

  // ═══════════════════════════════════════════════════════════
  //  COURSE SELECTION (unchanged)
  // ═══════════════════════════════════════════════════════════

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

  // ═══════════════════════════════════════════════════════════
  //  RANKING ENGINE — Binary Search against existing DB courses
  // ═══════════════════════════════════════════════════════════

  /// Entry point: starts the ranking flow for all selected courses.
  void showCompareSet({
    required bool isSelectedCourseRank,
    required AuthCubit authCubit,
  }) {
    _authCubit = authCubit;
    _courseIndex = 0;
    _matchupWinners.clear();
    _ratingWins.clear();
    _matchupCounts.clear();
    _rankCache.clear();

    // Read the existing course count from the user's profile.
    _currentTotalExisting = state.rankingType == RankingType.courseRanking
        ? (authCubit.state.profile?.allCompareCourseCount ?? 0)
        : (authCubit.state.profile?.allWishlishCount ?? 0);

    print('🚀 RANKING ENGINE START');
    print('   Selected courses: ${state.selectedCourses.length}');
    print('   Existing DB courses: $_currentTotalExisting');
    print('   Ranking type: ${state.rankingType}');

    emit(state.copyWith(isRankingInProgress: true));

    // Begin processing the first selected course.
    _processNextCourse();
  }

  /// Called by the UI when the user taps a course card (index 0 or 1).
  void onSelectComparisonCourse(
    int pickedIndex,
    VoidCallback onSuccess,
    AuthCubit authCubit,
  ) {
    _onComplete = onSuccess;
    _authCubit = authCubit;
    _matchupWinners.add(pickedIndex);

    // If we haven't asked all 8 questions yet, advance to next question.
    if (state.currentQuestionIndex < 7) {
      emit(
        state.copyWith(currentQuestionIndex: state.currentQuestionIndex + 1),
      );
      return;
    }

    // All 8 questions answered for this matchup — process it.
    _onMatchupComplete();
  }

  // ─── Core Loop: Process each selected course one at a time ───

  void _processNextCourse() {
    if (_courseIndex >= state.selectedCourses.length) {
      // All selected courses have been ranked and saved.
      _onAllCoursesRanked();
      return;
    }

    final course = state.selectedCourses[_courseIndex];
    _rankCache.clear();

    print(
      '🔍 BINARY SEARCH for: "${course.name}" '
      '(course ${_courseIndex + 1}/${state.selectedCourses.length}, '
      'against $_currentTotalExisting existing)',
    );

    if (_currentTotalExisting == 0) {
      // BASE CASE 1: No existing courses in DB — save directly at rank 1000.
      print('   → No existing courses. Saving directly at rank 1000.');
      _saveCourseDirect(course, 1000.0, 0);
      return;
    }

    // BASE CASE 2: Existing courses present — binary search.
    _bsLow = 0;
    _bsHigh = _currentTotalExisting - 1;
    _binarySearchStep();
  }

  // ═══════════════════════════════════════════════════════════
  //  BINARY SEARCH LOOP
  // ═══════════════════════════════════════════════════════════

  Future<void> _binarySearchStep() async {
    if (_bsLow > _bsHigh) {
      // ── Search terminated. Insertion index = _bsLow ──
      print('   → Search complete. Insertion index: $_bsLow');
      await _finalizeCourseRank(_bsLow);
      return;
    }

    final mid = (_bsLow + _bsHigh) ~/ 2;
    print('   → low=$_bsLow, high=$_bsHigh, mid=$mid — fetching rank $mid...');

    // Emit loading state before fetch
    emit(state.copyWith(isComparisonLoading: true));

    // Fetch the EXISTING course at rank index `mid` from the database.
    final existingCourse = await _fetchCourseAtRank(mid);

    if (existingCourse == null) {
      // API error — fallback: insert at current low.
      print('   ⚠️ API error fetching rank $mid. Falling back to low=$_bsLow');
      emit(state.copyWith(isComparisonLoading: false));
      await _finalizeCourseRank(_bsLow);
      return;
    }

    // Show the head-to-head: [New Course (index 0), Existing Course (index 1)]
    final newCourse = state.selectedCourses[_courseIndex];
    final existingAsModel = _userCourseToModel(existingCourse);

    emit(
      state.copyWith(
        comparison: [newCourse, existingAsModel],
        currentQuestionIndex: 0,
        isComparisonLoading: false,
      ),
    );
    // UI now renders → user answers 8 questions → onSelectComparisonCourse
    // → _onMatchupComplete → _handleBinarySearchAnswer
  }

  // ─── Matchup Processing ───

  void _onMatchupComplete() {
    final q1Winner = _matchupWinners[0]; // Q1 determines RANKING

    // Record per-dimension rating wins for BOTH courses.
    _recordRatings(state.comparison[0], state.comparison[1]);

    // Reset per-matchup tracking.
    _matchupWinners = [];

    // Use Q1 to drive the binary search direction.
    _handleBinarySearchAnswer(q1Winner);
  }

  void _handleBinarySearchAnswer(int q1Winner) {
    final mid = (_bsLow + _bsHigh) ~/ 2;

    if (q1Winner == 0) {
      // User picked the NEW course as better → it ranks ABOVE mid.
      print('   ✅ New course wins Q1 → high = ${mid - 1}');
      _bsHigh = mid - 1;
    } else {
      // User picked the EXISTING course as better → new course ranks BELOW mid.
      print('   ❌ Existing course wins Q1 → low = ${mid + 1}');
      _bsLow = mid + 1;
    }

    // Continue the binary search loop.
    _binarySearchStep();
  }

  // ═══════════════════════════════════════════════════════════
  //  FRACTIONAL RANK CALCULATION & SAVE
  // ═══════════════════════════════════════════════════════════

  /// Called when binary search terminates for a single course.
  /// [insertionIndex] is the 0-based rank where it should land.
  Future<void> _finalizeCourseRank(int insertionIndex) async {
    final course = state.selectedCourses[_courseIndex];
    double fractionalRank;

    if (_currentTotalExisting == 0) {
      // Should not happen here (handled in _processNextCourse), but safety.
      fractionalRank = 1000.0;
    } else if (insertionIndex == 0) {
      // ── TOP: above rank #0 (the current best) ──
      final below = await _ensureCached(0);
      final belowRank = below?.customRank ?? 1000.0;
      fractionalRank = belowRank / 2;
    } else if (insertionIndex >= _currentTotalExisting) {
      // ── BOTTOM: below the last existing course ──
      final above = await _ensureCached(_currentTotalExisting - 1);
      final aboveRank = above?.customRank ?? (_currentTotalExisting * 1000.0);
      fractionalRank = aboveRank + 1000;
    } else {
      // ── BETWEEN two existing courses ──
      final above = await _ensureCached(insertionIndex - 1);
      final below = await _ensureCached(insertionIndex);
      final aboveRank = above?.customRank ?? (insertionIndex * 1000.0);
      final belowRank = below?.customRank ?? ((insertionIndex + 1) * 1000.0);
      fractionalRank = (aboveRank + belowRank) / 2;
    }

    _saveCourseDirect(course, fractionalRank, insertionIndex);
  }

  /// Builds UserCourseModel, logs everything, saves, and advances to next.
  Future<void> _saveCourseDirect(
    CourseModel course,
    double fractionalRank,
    int insertionIndex,
  ) async {
    final courseId = course.id ?? '';
    final stars = _calculateStarRatings(courseId);

    // Build the model for saving.
    final userCourse = UserCourseModel(
      courseId: CourseId(
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

    // ═══ PRINT ALL RESULTS ═══
    _printCourseResult(
      course: course,
      insertionIndex: insertionIndex,
      fractionalRank: fractionalRank,
      stars: stars,
    );

    // Save to server.
    await courseRepository.saveRank(courses: [userCourse]);

    // The DB list grew by 1 — advance to the next course.
    _currentTotalExisting++;
    _courseIndex++;
    _processNextCourse();
  }

  // ═══════════════════════════════════════════════════════════
  //  COMPLETION
  // ═══════════════════════════════════════════════════════════

  void _onAllCoursesRanked() {
    print('');
    print('┌──────────────────────────────────────────────┐');
    print('│  ✅ ALL COURSES RANKED & SAVED SUCCESSFULLY  │');
    print('└──────────────────────────────────────────────┘');

    emit(state.copyWith(comparison: const [], isRankingInProgress: false));
    _onComplete?.call();
  }

  // ═══════════════════════════════════════════════════════════
  //  RATING TRACKING
  // ═══════════════════════════════════════════════════════════

  void _recordRatings(CourseModel course1, CourseModel course2) {
    final id1 = course1.id ?? '';
    final id2 = course2.id ?? '';

    _ratingWins.putIfAbsent(id1, () => List.filled(8, 0));
    _ratingWins.putIfAbsent(id2, () => List.filled(8, 0));
    _matchupCounts[id1] = (_matchupCounts[id1] ?? 0) + 1;
    _matchupCounts[id2] = (_matchupCounts[id2] ?? 0) + 1;

    for (var i = 0; i < 8; i++) {
      if (_matchupWinners[i] == 0) {
        _ratingWins[id1]![i]++;
      } else {
        _ratingWins[id2]![i]++;
      }
    }
  }

  /// Calculate 1-5 star ratings for all 8 dimensions for a course.
  List<int> _calculateStarRatings(String courseId) {
    final wins = _ratingWins[courseId] ?? List.filled(8, 0);
    final total = _matchupCounts[courseId] ?? 0;
    if (total == 0) return List.filled(8, 3); // default 3 stars

    return List.generate(8, (i) {
      final winRate = wins[i] / total;
      return (winRate * 4).round() + 1; // 0% → 1⭐, 100% → 5⭐
    });
  }

  // ═══════════════════════════════════════════════════════════
  //  API HELPERS
  // ═══════════════════════════════════════════════════════════

  Future<UserCourseModel?> _fetchCourseAtRank(int rank) async {
    if (_rankCache.containsKey(rank)) return _rankCache[rank];

    final result = await courseRepository.rankData(
      courseId: state.selectedCourses[_courseIndex].id!,
      rank: rank + 1,
      isWishListRank: state.rankingType == RankingType.wishlistRanking,
    );

    if (result.isSuccess && result.data != null && result.data!.isNotEmpty) {
      _rankCache[rank] = result.data!.first;
      return result.data!.first;
    }
    return null;
  }

  /// Fetch and cache a course at a given rank if not already cached.
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

  // ═══════════════════════════════════════════════════════════
  //  LOGGING
  // ═══════════════════════════════════════════════════════════

  void _printCourseResult({
    required CourseModel course,
    required int insertionIndex,
    required double fractionalRank,
    required List<int> stars,
  }) {
    print('');
    print('══════════════════════════════════════════════════');
    print('📍 COURSE: ${course.name ?? "Unknown"}');
    print('🏷️  ID: ${course.id ?? "N/A"}');
    print('──────────────────────────────────────────────────');
    print('📊 Insertion Index: $insertionIndex');
    print('🔢 Fractional Rank Value: $fractionalRank');
    print('──────────────────────────────────────────────────');
    print('⭐ Star Ratings (1-5):');
    for (var i = 0; i < 8; i++) {
      final bar = '★' * stars[i] + '☆' * (5 - stars[i]);
      print('   ${_dimLabels[i].padRight(20)} $bar  (${stars[i]})');
    }
    print('══════════════════════════════════════════════════');
  }
}
