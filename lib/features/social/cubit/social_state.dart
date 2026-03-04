/*
 * @Author: Km Muzahid
 * @Date: 2026-03-04 13:01:49
 * @Email: km.muzahid@gmail.com
 */
import 'package:equatable/equatable.dart';

class CreateSocialPostState extends Equatable {
  final List<String> courses;
  final List<String> links;

  const CreateSocialPostState({this.courses = const [], this.links = const []});

  @override
  List<Object?> get props => [courses, links];
}
