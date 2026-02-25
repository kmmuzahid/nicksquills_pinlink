/*
 * @Author: Km Muzahid
 * @Date: 2026-02-25 15:05:29
 * @Email: km.muzahid@gmail.com
 */
import 'package:flutter/material.dart';
import 'package:pinlink/config/bloc/safe_cubit.dart';
import 'package:pinlink/config/color/app_color.dart';
import 'package:pinlink/config/theme/cubit/theme_state.dart';

class ThemeCubit extends SafeCubit<ThemeState> {
  ThemeCubit() : super(ThemeState(appColor: DarkAppColor.instance, themeMode: ThemeMode.dark));

  void toggleTheme() {
    if (state.themeMode == ThemeMode.dark) {
      emit(ThemeState(appColor: LightAppColor.instance, themeMode: ThemeMode.light));
    } else {
      emit(ThemeState(appColor: DarkAppColor.instance, themeMode: ThemeMode.dark));
    }
  }
}
