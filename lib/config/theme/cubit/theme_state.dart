/*
 * @Author: Km Muzahid
 * @Date: 2026-02-25 15:05:54
 * @Email: km.muzahid@gmail.com
 */
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:pinlink/config/color/app_color.dart';

class ThemeState extends Equatable {
  final AppColorBase appColor;
  final ThemeMode themeMode;

  const ThemeState({required this.appColor, required this.themeMode});

  @override
  List<Object?> get props => [appColor, themeMode];
}
