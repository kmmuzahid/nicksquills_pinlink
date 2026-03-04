/*
 * @Author: Km Muzahid
 * @Date: 2026-03-04 13:01:36
 * @Email: km.muzahid@gmail.com
 */
import 'package:pinlink/config/bloc/safe_cubit.dart';
import 'package:pinlink/features/social/cubit/social_state.dart';

class CreateSocialPostCubit extends SafeCubit<CreateSocialPostState> {
  CreateSocialPostCubit() : super(const CreateSocialPostState());

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
}
