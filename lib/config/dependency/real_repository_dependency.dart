/*
 * @Author: Km Muzahid
 * @Date: 2026-01-07 12:29:06
 * @Email: km.muzahid@gmail.com
 */

import 'package:core_kit/core_kit.dart';
import 'package:pinlink/config/dependency/dependency_injection.dart';
import 'package:pinlink/features/course_comparision/repository/course_repository.dart';
import 'package:pinlink/features/social/repository/social_repository.dart';

class RealRepositoryDependency {
  static void dependencies() {
    getIt.registerLazySingleton(() => CourseRepository());

    getIt.registerLazySingleton<SocialRepository>(() => SocialRepository());

    AppLogger.debug('Real repository dependency initalized', tag: 'dependency');
  }
}
