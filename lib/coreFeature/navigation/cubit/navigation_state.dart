/*
 * @Author: Km Muzahid
 * @Date: 2026-02-01 09:37:24
 * @Email: km.muzahid@gmail.com
 */
import 'package:flutter/material.dart';

class NavigationState {
  int currentIndex = 0;

  NavigationState({this.currentIndex = 0});

  NavigationState copyWith({int? currentIndex, List<Widget>? pages}) {
    return NavigationState(
      currentIndex: currentIndex ?? this.currentIndex,
    );
  }

  @override
  int get hashCode => currentIndex.hashCode;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is NavigationState && other.currentIndex == currentIndex;
  }
}
