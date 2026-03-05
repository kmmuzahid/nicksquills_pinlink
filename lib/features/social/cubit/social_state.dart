/*
 * @Author: Km Muzahid
 * @Date: 2026-03-04 13:01:49
 * @Email: km.muzahid@gmail.com
 */
import 'dart:io';

import 'package:equatable/equatable.dart';

class CreateSocialPostState extends Equatable {
  final List<String> courses;
  final List<String> links;
  final List<File> files;
  final bool isPublic;

  const CreateSocialPostState({
    this.courses = const [],
    this.links = const [],
    this.files = const [],
    this.isPublic = true,
  });
  CreateSocialPostState copyWith({
    List<String>? courses,
    List<String>? links,
    List<File>? files,
    bool? isPublic,
  }) {
    return CreateSocialPostState(
      courses: courses ?? this.courses,
      links: links ?? this.links,
      isPublic: isPublic ?? this.isPublic,
      files: files ?? this.files,
    );
  }

  @override
  List<Object?> get props => [courses, links, files, isPublic];
}
