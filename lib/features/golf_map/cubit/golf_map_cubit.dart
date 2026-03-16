import 'package:pinlink/config/bloc/safe_cubit.dart';
import 'package:pinlink/constant/enums.dart';
import 'package:pinlink/features/golf_map/cubit/golf_map_cubit_state.dart';

class GolfMapCubit extends SafeCubit<GolfMapCubitState> {
  GolfMapCubit() : super(const GolfMapCubitState());

  void changeFilter(MapFilters filter) {
    emit(state.copyWith(selectedFilter: filter));
  }
}
