import 'package:flutter/material.dart';
import 'package:pinlink/config/bloc/safe_cubit.dart';
import 'package:pinlink/config/dependency/dependency_injection.dart';
import 'package:pinlink/constant/enums.dart';
import 'package:pinlink/features/course_comparision/repository/course_repository.dart';
import 'package:pinlink/features/profile/cubit/profile_cubit_state.dart';
import 'package:pinlink/features/profile/model/user_course_model.dart';
import 'package:pinlink/features/social/model/post_model.dart';
import 'package:pinlink/features/social/repository/social_repository.dart';

class ProfileCubit extends SafeCubit<ProfileCubitState> {
  ProfileCubit() : super(const ProfileCubitState()) {
    init();
  }

  final SocialRepository _repository = getIt();
  final CourseRepository _courseRepository = getIt();

  Map<String, ScrollController> controllers = {};

  void init() {
    getUserPlayedCourse(1);
  }

  Future<void> getUserPosts(int page, {bool isRefresh = false}) async {
    if (state.isPostLoading) return;
    emit(state.copyWith(isPostLoading: true, posts: isRefresh ? [] : null));
    final result = await _repository.getAllPost(page: page, userPostOnly: true);
    if (result.isSuccess) {
      emit(
        state.copyWith(
          posts: [...state.posts, ...(result.data ?? [])],
          isPostLoading: false,
        ),
      );
    } else {
      emit(state.copyWith(isPostLoading: false));
    }
  }

  Future<void> getUserPlayedCourse(int page, {bool isRefresh = false}) async {
    if (state.isUserPlayedCourseLoading) return;
    emit(
      state.copyWith(
        isUserPlayedCourseLoading: true,
        userCourses: isRefresh ? [] : null,
      ),
    );
    final result = await _courseRepository.getUserPlayedCourse(page: page);
    if (result.isSuccess) {
      emit(
        state.copyWith(
          userCourses: isRefresh
              ? result.data
              : [...state.userCourses, ...(result.data ?? [])],
          isUserPlayedCourseLoading: false,
        ),
      );
    } else {
      emit(state.copyWith(isUserPlayedCourseLoading: false));
    }
  }

  Future<void> getUserWishlistCourse(int page, {bool isRefresh = false}) async {
    if (state.isWishListLoading) return;
    emit(
      state.copyWith(
        isWishListLoading: true,
        wishListCourses: isRefresh ? [] : null,
      ),
    );
    final result = await _courseRepository.getUserWishlistCourse(page: page);
    if (result.isSuccess) {
      emit(
        state.copyWith(
          wishListCourses: isRefresh
              ? result.data
              : [...state.wishListCourses, ...(result.data ?? [])],
          isWishListLoading: false,
        ),
      );
    } else {
      emit(state.copyWith(isWishListLoading: false));
    }
  }

  void onChangePost(PostModel postModel) {
    final posts = List<PostModel>.from(state.posts);
    final index = posts.indexWhere((e) => e.id == postModel.id);
    if (index != -1) {
      posts[index] = postModel;
      emit(state.copyWith(posts: posts));
    }
  }

  void changeFilter(FilterProfile filter) {
    emit(state.copyWith(selectedFilter: filter));
    if (filter == FilterProfile.MyPosts && state.posts.isEmpty) {
      getUserPosts(1);
    } else if (filter == FilterProfile.MyCourses && state.userCourses.isEmpty) {
      getUserPlayedCourse(1);
    } else if (filter == FilterProfile.MyWishlist &&
        state.wishListCourses.isEmpty) {
      getUserWishlistCourse(1);
    }
  }

  Future<void> reorderCourses(int oldIndex, int newIndex) async {
    if (oldIndex == newIndex) return;

    var adjustedIndex = newIndex;
    if (oldIndex < newIndex) {
      adjustedIndex -= 1;
    }
    if (oldIndex == adjustedIndex) return;

    final updatedRank = await reorderWishlistCourses(
      oldIndex: oldIndex,
      newIndex: newIndex,
    );
    if (updatedRank == null) return;

    final oldSet = List<UserCourseModel>.from(state.userCourses);

    final courses = List<UserCourseModel>.from(state.userCourses);
    final item = courses.removeAt(oldIndex);
    courses.insert(adjustedIndex, item.copyWith(customRank: updatedRank));
    emit(state.copyWith(userCourses: courses));

    final result = await _courseRepository.reorderCompareCourses(
      compareCourseId: item.id ?? '',
      rank: updatedRank,
      isRevert: false,
    );
    if (!result.isSuccess) {
      emit(state.copyWith(userCourses: oldSet));
    }
  }

  Future<double?> reorderWishlistCourses({
    required int oldIndex,
    required int newIndex,
  }) async {
    var adjustedIndex = newIndex;
    if (oldIndex < newIndex) {
      adjustedIndex -= 1;
    }

    int orig(int i) {
      if (i >= oldIndex) return i + 1;
      return i;
    }

    int? rankBefore;
    if (adjustedIndex > 0) {
      rankBefore = orig(adjustedIndex - 1) + 1;
    }
    final rankAfter = orig(adjustedIndex) + 1;

    final indexesToFetch = <int>[];
    if (rankBefore != null) indexesToFetch.add(rankBefore);
    indexesToFetch.add(rankAfter);

    final result = await _courseRepository.rankData(
      rank: indexesToFetch,
      isWishListRank: false,
      shortByRank: false,
    );
    final fetchedCourses = result.data ?? [];
    if (fetchedCourses.isEmpty) {
      return null;
    }

    double top = 0;
    double bottom = 0;

    if (fetchedCourses.length == 2) {
      top = fetchedCourses.first.customRank ?? 0;
      bottom = fetchedCourses.last.customRank ?? 0;
      return (top + bottom) / 2;
    } else {
      if (rankBefore == null) {
        bottom = fetchedCourses.first.customRank ?? 0;
        return bottom / 2;
      } else {
        top = fetchedCourses.first.customRank ?? 0;
        return top + 1000.0;
      }
    }
  }
}
