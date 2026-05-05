import 'package:flutter/material.dart';
import 'package:pinlink/constant/enums.dart';

Color getGolfPrimaryColor(MapFilters? selectedFilter) {
  Color? color;
  if (selectedFilter == MapFilters.Played) {
    color = const Color(0xff00B578);
  } else if (selectedFilter == MapFilters.Wishlist) {
    color = const Color(0xffF51F2C);
  } else if (selectedFilter == MapFilters.Friends) {
    color = const Color(0xff1C69FF);
  } else if (selectedFilter == MapFilters.PinLinks5) {
    color = const Color(0xffFEB000);
  } else {
    color = const Color(0xff00B578);
  }
  return color;
}
