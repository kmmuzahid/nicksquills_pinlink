/*
 * @Author: Km Muzahid
 * @Date: 2026-03-04 13:01:36
 * @Email: km.muzahid@gmail.com
 */
import 'dart:io';

import 'package:core_kit/core_kit.dart';
import 'package:pinlink/config/bloc/safe_cubit.dart';
import 'package:pinlink/features/social/cubit/social_state.dart';
import 'package:video_player/video_player.dart';

class CreateSocialPostCubit extends SafeCubit<CreateSocialPostState> {
  CreateSocialPostCubit() : super(const CreateSocialPostState());

  final ImagePicker _imagePicker = ImagePicker();

  bool isVideo(File file) {
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
      final pickedFile = File(element.path);

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
    final updatedFiles = List<File>.from(state.files)..removeAt(index);
    emit(state.copyWith(files: updatedFiles));
  }

  static Future<bool> _validateVideoDuration(
    File file, {
    Duration maxVideoDuration = const Duration(seconds: 30),
  }) async {
    final controller = VideoPlayerController.file(file);

    await controller.initialize();

    final duration = controller.value.duration;

    controller.dispose();

    if (duration > maxVideoDuration) {
      return false;
    }

    return true;
  }

  void addCourse(String course) {
    final updatedCourses = List<String>.from(state.courses)..add(course);
    emit(CreateSocialPostState(courses: updatedCourses, links: state.links));
  }

  void removeCourse(String course) {
    final updatedCourses = List<String>.from(state.courses)..remove(course);
    emit(CreateSocialPostState(courses: updatedCourses, links: state.links));
  }

  void addLink(String link) {
    final updatedLinks = List<String>.from(state.links)..add(link);
    emit(CreateSocialPostState(courses: state.courses, links: updatedLinks));
  }

  void removeLink(String link) {
    final updatedLinks = List<String>.from(state.links)..remove(link);
    emit(CreateSocialPostState(courses: state.courses, links: updatedLinks));
  }

  void changePrivacy() {
    emit(state.copyWith(isPublic: !state.isPublic));
  }
}
