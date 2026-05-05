/*
 * @Author: Km Muzahid
 * @Date: 2026-02-01 09:37:24
 * @Email: km.muzahid@gmail.com
 */
import 'package:pinlink/constant/enums.dart';

class NavigationState {
  int currentIndex = 0;
  bool isPublicPostEnabled;
  FilterProfile filter = FilterProfile.MyCourses;

  NavigationState({
    this.currentIndex = 0,
    this.filter = FilterProfile.MyCourses,
    this.isPublicPostEnabled = true,
  });

  NavigationState copyWith({
    int? currentIndex,
    FilterProfile? filter,
    bool? isPublicPostEnabled,
  }) {
    return NavigationState(
      currentIndex: currentIndex ?? this.currentIndex,
      filter: filter ?? this.filter,
      isPublicPostEnabled: isPublicPostEnabled ?? this.isPublicPostEnabled,
    );
  }

  @override
  int get hashCode =>
      currentIndex.hashCode ^ filter.hashCode ^ isPublicPostEnabled.hashCode;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is NavigationState &&
        other.currentIndex == currentIndex &&
        other.filter == filter &&
        other.isPublicPostEnabled == isPublicPostEnabled;
  }
}
