import 'package:core_kit/network/dio_service.dart';
import 'package:core_kit/network/request_input.dart';
import 'package:pinlink/config/api/api_end_point.dart';
import 'package:pinlink/config/bloc/safe_cubit.dart';
import 'package:pinlink/constant/enums.dart';
import 'package:pinlink/features/leaderboard/cubit/leaderboard_state.dart';
import 'package:pinlink/features/leaderboard/model/leaderboard_model.dart';

class LeaderboardCubit extends SafeCubit<LeaderboardState> {
  LeaderboardCubit() : super(const LeaderboardState());

  void changeLeaderboardType(LeaderboardType type) {
    emit(LeaderboardState(leaderboardType: type, searchType: state.searchType));
    fetchLeaderboard();
  }

  void changeSearchType(LeaderboardSearchType type) {
    emit(
      LeaderboardState(
        searchType: type,
        leaderboardType: state.leaderboardType,
      ),
    );
    fetchLeaderboard();
  }

  Future<void> fetchLeaderboard({int page = 1, bool isRefresh = false}) async {
    if (state.isLeaderBoardLoading) return;
    emit(
      state.copyWith(
        isLeaderboardLoading: true,
        leaderboardList: isRefresh ? [] : null,
      ),
    );

    final result = await DioService.instance.request(
      input: RequestInput(
        endpoint: ApiEndPoint.instance.leaderboard,
        method: .GET,
        queryParams: {
          'page': page,
          'limit': 10,
          if (state.leaderboardType != .friends) 'rank': 'pinlink',
          'type': state.searchType.value,
        },
      ),
      responseBuilder: (data) {
        return List.from(
          data,
        ).map((e) => LeaderboardModel.fromJson(e)).toList();
      },
    );

    if (result.isSuccess) {
      emit(
        state.copyWith(
          isLeaderboardLoading: false,
          leaderboardList: [...state.leaderboardList, ...(result.data ?? [])],
        ),
      );
    }
  }
}
