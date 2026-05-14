/*
 * @Author: Km Muzahid
 * @Date: 2026-03-04 13:01:36
 * @Email: km.muzahid@gmail.com
 */
import 'dart:io';

import 'package:core_kit/core_kit.dart';
import 'package:core_kit/network/request_input.dart';
import 'package:pinlink/config/api/api_end_point.dart';
import 'package:pinlink/config/bloc/safe_cubit.dart';
import 'package:pinlink/config/dependency/dependency_injection.dart';
import 'package:pinlink/config/route/app_router.dart';
import 'package:pinlink/features/course_comparision/model/user_course_model.dart';
import 'package:pinlink/features/course_comparision/repository/course_repository.dart';
import 'package:pinlink/features/social/cubit/social_state.dart';
import 'package:pinlink/features/social/entity/post_entity.dart';
import 'package:pinlink/features/social/model/post_model.dart';
import 'package:pinlink/features/social/repository/social_repository.dart';
import 'package:video_player/video_player.dart';

class SocialCubit extends SafeCubit<SocialState> {
  SocialCubit() : super(const SocialState());

  final courseRepository = getIt<CourseRepository>();

  final socialRepository = getIt<SocialRepository>();

  final ImagePicker _imagePicker = ImagePicker();

  final debounce = Debouncer(milliseconds: 300);

  String searchTex = '';

  Future<void> getAllPost({
    bool isRefresh = false,
    int page = 1,
    String? searchText,
  }) async {
    if (state.isPostLoaing) return;

    searchText = searchText;

    emit(
      state.copyWith(isPostLoaing: true, posts: isRefresh ? [] : state.posts),
    );

    final result = await socialRepository.getAllPost(
      page,
      searchText,
      state.isPublicPostEnabled ? 'public' : null,
    );

    emit(state.copyWith(isPostLoaing: false));
    if (result.isSuccess) {
      emit(state.copyWith(posts: [...state.posts, ...(result.data ?? [])]));
    }
  }

  Future<void> searchPost(String query) async {
    if (searchTex == query) return;
    searchTex = query;
    debounce.run(() async {
      await getAllPost(searchText: query, isRefresh: true);
    });
  }

  bool isVideo(XFile file) {
    final extension = file.path.split('.').last.toLowerCase();
    final videoExtensions = ['mp4', 'mov', 'avi', 'mkv', 'webm'];
    return videoExtensions.contains(extension);
  }

  Future<void> pickImage() async {
    final permission = await PermissionHelper.request(Permission.photos);
    if (!permission) return;

    final file = await _imagePicker.pickMultipleMedia();
    const maxVideoDuration = Duration(seconds: 30);

    if (file.isEmpty) return;

    for (var element in file) {
      final pickedFile = element;

      if (isVideo(pickedFile)) {
        final isValid = await _validateVideoDuration(
          pickedFile,
          maxVideoDuration: maxVideoDuration,
        );

        if (!isValid) {
        } else {
          emit(state.copyWith(files: [...state.files, pickedFile]));
        }
      } else {
        emit(state.copyWith(files: [...state.files, pickedFile]));
      }
    }
  }

  Future<void> removeImage(int index) async {
    final updatedFiles = List<XFile>.from(state.files)..removeAt(index);
    emit(state.copyWith(files: updatedFiles));
  }

  static Future<bool> _validateVideoDuration(
    XFile file, {
    Duration maxVideoDuration = const Duration(seconds: 30),
  }) async {
    final controller = VideoPlayerController.file(File(file.path));

    await controller.initialize();

    final duration = controller.value.duration;

    controller.dispose();

    if (duration > maxVideoDuration) {
      return false;
    }

    return true;
  }

  Future<void> createPost(PostEntity entity) async {
    emit(state.copyWith(isPosting: true));

    final result = await DioService.instance.request(
      showMessage: true,
      input: RequestInput(
        endpoint: ApiEndPoint.instance.createPostData,
        method: .POST,
        formFields: {
          'coursename': state.courses.first.courseId?.name,
          'headline': entity.headline,
          'description': entity.description,
          'isScorecard': !state.isPublic,
          'scorecardDate': entity.date?.toIso8601String(),
          'scorecardHoles': int.tryParse(entity.holes ?? '0'),
          'scorecardTotalScore': int.tryParse(entity.totalScore ?? '0'),
          'links': state.links,
          'courseId': state.courses.first.courseId?.id,
        },
        files: {'mediaLinks': state.files},
      ),
      responseBuilder: (data) {
        return data;
      },
    );
    emit(state.copyWith(isPosting: false));
    if (result.isSuccess) {
      appRouter.pop();
    }
  }

  Future<void> searchCourses(String query) async {
    if (query.isEmpty) {
      emit(state.copyWith(searchResults: []));
      return;
    }
    final result = await courseRepository.getUserPlayedCourse(query: query);
    if (result.isSuccess) {
      emit(state.copyWith(searchResults: result.data ?? []));
    }
  }

  void addCourse(UserCourseModel course) {
    final updatedCourses = [course];
    emit(state.copyWith(courses: updatedCourses, searchResults: []));
  }

  void removeCourse(UserCourseModel course) {
    final updatedCourses = List<UserCourseModel>.from(state.courses)
      ..remove(course);
    emit(state.copyWith(courses: updatedCourses));
  }

  void addLink(String link) {
    final updatedLinks = List<String>.from(state.links)..add(link);
    emit(state.copyWith(links: updatedLinks));
  }

  void removeLink(String link) {
    final updatedLinks = List<String>.from(state.links)..remove(link);
    emit(state.copyWith(links: updatedLinks));
  }

  void changePrivacy() {
    emit(state.copyWith(isPublic: !state.isPublic));
  }

  void togglePostVisibility() {
    emit(state.copyWith(isPublicPostEnabled: !state.isPublicPostEnabled));
    getAllPost(isRefresh: true);
  }

  Future<void> sharePost(String postId) async {
    socialRepository.sharePost(postId);
  }

  Future<void> createPostReport(String postId, String reportReason) async {
    final result = await socialRepository.createPostReport(
      postId,
      reportReason,
    );
    if (result.isSuccess) {
      final index = state.posts.indexWhere((e) => e.id == postId);
      if (index != -1) {
        final updatedPosts = state.posts.where((e) => e.id != postId).toList();
        emit(state.copyWith(posts: updatedPosts));
      }
    }
  }

  void updatePost(PostModel updatedPost) {
    final updatedPosts = List<PostModel>.from(state.posts);
    final index = updatedPosts.indexWhere((e) => e.id == updatedPost.id);
    if (index != -1) {
      updatedPosts[index] = updatedPost;
      emit(state.copyWith(posts: updatedPosts));
    }
  }
}
