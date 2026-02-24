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
  displayColor: AppColor.tEXT_white,
  bodyColor: AppColor.tEXT_white,
);
final ThemeData commonThemeData = ThemeData(
  useMaterial3: true,
  scaffoldBackgroundColor: AppColor.bACKGROUND_darkCard, 
  textTheme: baseTextTheme,
  brightness: Brightness.light,
  colorScheme: ColorScheme.fromSeed(     
    seedColor: AppColor.pRIMARY_brandClr,
    primary: AppColor.pRIMARY_brandClr, // button, Snackbar Info
    onPrimary: AppColor.tEXT_white, // text on button
    secondary: AppColor.tEXT_sub, // unselected radio
    surface: AppColor.bACKGROUND_darkCard, //card color, SnackBar Background
    onSurface: AppColor.tEXT_white, //text on card
    outline: AppColor.bACKGROUND_darkCardBoarder, // border color
    tertiary: const Color(0xFFF59E0B), // SnackBar Warning
    error: const Color(0xFFEF4444), // SnackBar Error
  ),
  inputDecorationTheme: InputDecorationTheme(
    filled: true,
    fillColor: AppColor.bACKGROUND_darkPage, 
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(40),
      borderSide: BorderSide(color: AppColor.bACKGROUND_darkCardBoarder, width: 1.5),
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
      fillColor: const Color(0xFF061512),
      hintStyle: const TextStyle(
        color: Color(0xFF6B7280),
        fontSize: 12,
        fontWeight: FontWeight.w400,
        fontStyle: FontStyle.normal,
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(color: AppColor.bACKGROUND_darkCardBoarder, width: 1.5),
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
      
      backgroundBuilder: (context, states, child) {
        return Container(
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [Color(0xFF184F3A), Color(0xFF2F6F57)],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter, 
            ),

            borderRadius: BorderRadius.circular(8),
          ),
          // The 'child' here is the internal label/icon of the button
          child: Center(child: child),
        );
      },
      foregroundColor: Colors.orangeAccent, //loader color
      textStyle: const TextStyle(color: Colors.white), //title color
      shape: RoundedRectangleBorder(
        side: const BorderSide(width: 1.5, color: Colors.transparent),
        borderRadius: BorderRadius.circular(8),
      ),
    ),
  ),
);
