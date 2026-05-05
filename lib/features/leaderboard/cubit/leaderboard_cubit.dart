import 'package:pinlink/config/bloc/safe_cubit.dart';
import 'package:pinlink/constant/enums.dart';
import 'package:pinlink/features/leaderboard/cubit/leaderboard_state.dart';

class LeaderboardCubit extends SafeCubit<LeaderboardState> {
  LeaderboardCubit() : super(const LeaderboardState());

  void changeLeaderboardType(LeaderboardType type) {
    emit(state.copyWith(leaderboardType: type));
  }

  void changeSearchType(LeaderboardSearchType type) {
    emit(state.copyWith(searchType: type));
  }
}
