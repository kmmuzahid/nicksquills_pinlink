/*
 * @Author: Km Muzahid
 * @Date: 2026-02-02 17:29:30
 * @Email: km.muzahid@gmail.com
 */
import 'package:flutter/material.dart';
import 'package:pinlink/config/color/app_color.dart';

String fontFamily = 'Inter';
final TextTheme baseTextTheme = ThemeData.light().textTheme.apply(
  fontFamily: fontFamily,
  displayColor: Colors.black,
  bodyColor: Colors.black,
);
final ThemeData commonThemeData = ThemeData(
  useMaterial3: true,
  scaffoldBackgroundColor: AppColor.background,
  textTheme: baseTextTheme,
  brightness: Brightness.light,
  colorScheme: ColorScheme.fromSeed(
    seedColor: AppColor.primary,
    primary: AppColor.primary, // button, Snackbar Info
    onPrimary: AppColor.onPrimary, // text on button
    secondary: AppColor.textSecondary, // unselected radio
    onSurface: AppColor.onPrimary, //text on card
    surface: AppColor.surfaceColor, //card color, SnackBar Background
    outline: AppColor.outlineColor, // border color
    tertiary: const Color(0xFFF59E0B), // SnackBar Warning
    error: const Color(0xFFEF4444), // SnackBar Error
  ),
  inputDecorationTheme: InputDecorationTheme(
    filled: true,
    fillColor: AppColor.white,
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: BorderSide(color: AppColor.outlineColor, width: 1.5),
    ),

    hintStyle: TextStyle(
      color: Colors.grey.shade500,
      fontSize: 12,
      fontWeight: FontWeight.w400,
      fontStyle: FontStyle.normal,
    ), //hint and prefix color
  ), 

  dropdownMenuTheme: DropdownMenuThemeData(
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: AppColor.white,
      hintStyle: TextStyle(
        color: Colors.grey.shade500,
        fontSize: 12,
        fontWeight: FontWeight.w400,
        fontStyle: FontStyle.normal,
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(color: AppColor.outlineColor, width: 1.5),
      ),
    ),
    textStyle: const TextStyle(
      color: Colors.black,
      fontSize: 12,
      fontWeight: FontWeight.w400,
      fontStyle: FontStyle.normal,
    ),
  ),

  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      minimumSize: const Size(80, 50),
    
      backgroundColor: AppColor.primary, //button background
      foregroundColor: Colors.orangeAccent, //loader color
      textStyle: const TextStyle(color: Colors.white), //title color
      shape: RoundedRectangleBorder(
        side: const BorderSide(width: 1.5, color: Colors.transparent),
        borderRadius: BorderRadius.circular(8),
      ),
    ),
  ),
);
