import 'package:flutter/material.dart';
import 'package:linked_scroll_controller/linked_scroll_controller.dart';
import 'package:pinlink/config/bloc/safe_cubit.dart';
import 'package:pinlink/constant/enums.dart';
import 'package:pinlink/features/profile/cubit/profile_cubit_state.dart';

class ProfileCubit extends SafeCubit<ProfileCubitState> {
  ProfileCubit() : super(const ProfileCubitState());

  final LinkedScrollControllerGroup _linkedControllers =
      LinkedScrollControllerGroup();
  final Map<String, ScrollController> _controllers = {};

  ScrollController controller = ScrollController();

  ScrollController controllerFor(String index) {
    final controlelr = _controllers.putIfAbsent(
      index,
      () => _linkedControllers.addAndGet(),
    );
    if (_controllers.isEmpty) {
      controlelr.addListener(() {
        controller.animateTo(
          controlelr.offset,
          duration: const Duration(milliseconds: 50),
          curve: Curves.easeInOut,
        );
      });
    }
    return controlelr;
  }

  @override
  Future<void> close() {
    for (final controller in _controllers.values) {
      controller.dispose();
    }
    _controllers.clear();
    return super.close();
  }

  void changeFilter(FilterProfile filter) {
    emit(state.copyWith(selectedFilter: filter));
  }
}
