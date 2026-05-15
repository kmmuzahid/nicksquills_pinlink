import 'package:equatable/equatable.dart';
import 'package:pinlink/constant/enums.dart';
import 'package:pinlink/features/course_comparision/model/user_course_model.dart';
import 'package:pinlink/features/social/model/post_model.dart';

class ProfileCubitState extends Equatable {
  final FilterProfile selectedFilter;
  final List<PostModel> posts;
  final List<UserCourseModel> userCourses;
  final List<UserCourseModel> wishListCourses;
  final bool isPostLoading;
  final bool isUserPlayedCourseLoading;
  final bool isWishListLoading;

  const ProfileCubitState({
    this.selectedFilter = FilterProfile.MyCourses,
    this.posts = const [],
    this.userCourses = const [],
    this.wishListCourses = const [],
    this.isPostLoading = false,
    this.isUserPlayedCourseLoading = false,
    this.isWishListLoading = false,
  });

  @override
  List<Object?> get props => [
    selectedFilter,
    posts,
    userCourses,
    wishListCourses,
    isPostLoading,
    isUserPlayedCourseLoading,
    isWishListLoading,
  ];

  ProfileCubitState copyWith({
    FilterProfile? selectedFilter,
    List<PostModel>? posts,
    List<UserCourseModel>? userCourses,
    List<UserCourseModel>? wishListCourses,
    bool? isPostLoading,
    bool? isUserPlayedCourseLoading,
    bool? isWishListLoading,
  }) {
    return ProfileCubitState(
      selectedFilter: selectedFilter ?? this.selectedFilter,
      posts: posts ?? this.posts,
      userCourses: userCourses ?? this.userCourses,
      wishListCourses: wishListCourses ?? this.wishListCourses,
      isPostLoading: isPostLoading ?? this.isPostLoading,
      isUserPlayedCourseLoading:
          isUserPlayedCourseLoading ?? this.isUserPlayedCourseLoading,
      isWishListLoading: isWishListLoading ?? this.isWishListLoading,
    );
  }
}
