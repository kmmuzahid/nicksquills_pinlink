/*
 * @Author: Km Muzahid
 * @Date: 2026-03-04 13:01:49
 * @Email: km.muzahid@gmail.com
 */
import 'package:core_kit/core_kit.dart';
import 'package:equatable/equatable.dart';
import 'package:pinlink/features/course_comparision/model/user_course_model.dart';
import 'package:pinlink/features/social/model/post_model.dart';

class CreateSocialPostState extends Equatable {
  final List<UserCourseModel> courses;
  final List<String> links;
  final List<XFile> files;
  final bool isPublic;
  final List<UserCourseModel> searchResults;
  final bool isPosting;
  final List<PostModel> posts;
  final bool isPostLoaing;

  const CreateSocialPostState({
    this.courses = const [],
    this.links = const [],
    this.files = const [],
    this.isPublic = true,
    this.isPosting = false,
    this.searchResults = const [],
    this.posts = const [],
    this.isPostLoaing = false,
  });
  CreateSocialPostState copyWith({
    List<UserCourseModel>? courses,
    List<String>? links,
    List<XFile>? files,
    bool? isPublic,
    bool? isPosting,
    List<UserCourseModel>? searchResults,
    List<PostModel>? posts,
    bool? isPostLoaing,
  }) {
    return CreateSocialPostState(
      courses: courses ?? this.courses,
      links: links ?? this.links,
      isPublic: isPublic ?? this.isPublic,
      isPosting: isPosting ?? this.isPosting,
      files: files ?? this.files,
      searchResults: searchResults ?? this.searchResults,
      posts: posts ?? this.posts,
      isPostLoaing: isPostLoaing ?? this.isPostLoaing,
    );
  }

  @override
  List<Object?> get props => [
    courses,
    links,
    files,
    isPublic,
    searchResults,
    isPosting,
    posts,
    isPostLoaing,
  ];
}
