/*
 * @Author: Km Muzahid
 * @Date: 2026-02-01 09:37:24
 * @Email: km.muzahid@gmail.com
 */
import 'package:pinlink/config/bloc/safe_cubit.dart';
import 'package:pinlink/constant/enums.dart';
import 'package:pinlink/coreFeature/navigation/cubit/navigation_state.dart';

class NavigationCubit extends SafeCubit<NavigationState> {
  NavigationCubit() : super(NavigationState());


  void changeIndex(int index, {FilterProfile filter = FilterProfile.MyCourses}) {
    emit(state.copyWith(currentIndex: index, filter: filter));
  }
}
