import 'package:flutter/material.dart';
import 'package:pinlink/config/bloc/safe_cubit.dart';
import 'package:pinlink/constant/enums.dart';
import 'package:pinlink/features/profile/cubit/profile_cubit_state.dart';

class ProfileCubit extends SafeCubit<ProfileCubitState> {
  ProfileCubit() : super(const ProfileCubitState());
  Map<String, ScrollController> controllers = {};

  void changeFilter(FilterProfile filter) {
    emit(state.copyWith(selectedFilter: filter));
  }
}
