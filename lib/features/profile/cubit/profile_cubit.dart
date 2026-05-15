import 'package:flutter/material.dart';
import 'package:pinlink/config/bloc/safe_cubit.dart';
import 'package:pinlink/config/dependency/dependency_injection.dart';
import 'package:pinlink/constant/enums.dart';
import 'package:pinlink/features/course_comparision/model/user_course_model.dart';
import 'package:pinlink/features/course_comparision/repository/course_repository.dart';
import 'package:pinlink/features/profile/cubit/profile_cubit_state.dart';
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

  void reorderCourses(int oldIndex, int newIndex) {
    if (oldIndex < newIndex) {
      newIndex -= 1;
    }
    final courses = List<UserCourseModel>.from(state.userCourses);
    final item = courses.removeAt(oldIndex);
    courses.insert(newIndex, item);
    emit(state.copyWith(userCourses: courses));
  }
}
