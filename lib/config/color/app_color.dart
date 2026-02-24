// ignore_for_file: overridden_fields, non_constant_identifier_names, library_private_types_in_public_api, unused_field, constant_identifier_names

/*
 * @Author: Km Muzahid
 * @Date: 2026-01-07 14:20:59
 * @Email: km.muzahid@gmail.com
 */
import 'package:flutter/material.dart';

AppColorBase get AppColor => LightAppColor();

class DarkAppColor extends AppColorBase {}

abstract class AppColorBase {
  Color bACKGROUND_card = const Color(0xFFFEFBE8);
  Color bACKGROUND_clickableBorder = const Color(0xFF789086);
  Color bACKGROUND_darkCard = const Color(0xFF052217);
  Color bACKGROUND_darkCardBoarder = const Color(0xFF1A3129);
  Color bACKGROUND_darkPage = const Color(0xFF061512);
  Color bACKGROUND_page = const Color(0xFFF8FAF9);
  Color border_divider = const Color(0xFFE5E7EB);
  Color iconBorder = const Color(0xFF0C2E1E);
  Color lightYellow = const Color(0xFFFFF4CC);
  Color pRIMARY_brandClr = const Color(0xFF184F3A);
  Color pRIMARY_priLight = const Color(0xFF2F6F57);
  Color pRIMARY_priMedium = const Color(0xFF184F3A);
  Color pRIMARY_priSoft = const Color(0xFF6FAE97);
  Color ratingPremiumTags_goldAccent = const Color(0xFFC8A951);
  Color sTATUS_error = const Color(0xFFD14343);
  Color sTATUS_info = const Color(0xFF2F80ED);
  Color sTATUS_success = const Color(0xFF2E7D32);
  Color sTATUS_warning = const Color(0xFFF4B400);
  Color socialLinksShareBTN_skyBlue = const Color(0xFF3A7CA5);
  Color successVerifiedPositivestats_freshGrass = const Color(0xFF4CAF50);
  Color tEXT_dark = const Color(0xFF1F2933);
  Color tEXT_sub = const Color(0xFF6B7280);
  Color tEXT_subDark = const Color(0xFFB2CBC1);
  Color tEXT_white = const Color(0xFFFFFFFF);
}

class LightAppColor extends AppColorBase {
  // Backgrounds
  @override
  Color bACKGROUND_card = const Color(0xFFFFFFFF); // pure white for cards
  @override
  Color bACKGROUND_clickableBorder = const Color(0xFFCBD5E0); // subtle gray for borders
  @override
  Color bACKGROUND_darkCard = const Color(0xFFF8FAF9); // slightly off-white
  @override
  Color bACKGROUND_darkCardBoarder = const Color(0xFFE2E8F0); // subtle card border
  @override
  Color bACKGROUND_darkPage = const Color(0xFFF7FAFC); // main page light gray
  @override
  Color bACKGROUND_page = const Color(0xFFFFFFFF); // white background

  // Borders & icons
  @override
  Color border_divider = const Color(0xFFE5E7EB); // soft gray divider
  @override
  Color iconBorder = const Color(0xFF4B5563); // gray icon border

  // Special backgrounds
  @override
  Color lightYellow = const Color(0xFFFFFBEA); // soft yellow highlight

  // Brand colors
  @override
  Color pRIMARY_brandClr = const Color(0xFF1F5D42); // dark green
  @override
  Color pRIMARY_priLight = const Color(0xFF4A8C6F); // lighter green
  @override
  Color pRIMARY_priMedium = const Color(0xFF256B4E); // medium green
  @override
  Color pRIMARY_priSoft = const Color(0xFF8FC9AA); // soft green

  // Status
  @override
  Color ratingPremiumTags_goldAccent = const Color(0xFFC8A951);
  @override
  Color sTATUS_error = const Color(0xFFE05A5A);
  @override
  Color sTATUS_info = const Color(0xFF2F80ED);
  @override
  Color sTATUS_success = const Color(0xFF2E7D32);
  @override
  Color sTATUS_warning = const Color(0xFFF6B93B);

  // Social
  @override
  Color socialLinksShareBTN_skyBlue = const Color(0xFF3A7CA5);
  @override
  Color successVerifiedPositivestats_freshGrass = const Color(0xFF4CAF50);

  // Text
  @override
  Color tEXT_dark = const Color(0xFF1F2937); // dark gray for readability
  @override
  Color tEXT_sub = const Color(0xFF4B5563); // medium gray
  @override
  Color tEXT_subDark = const Color(0xFF6B7280); // lighter gray
  @override
  Color tEXT_white = const Color(0xFF1F2937); // used only on colored backgrounds
}
