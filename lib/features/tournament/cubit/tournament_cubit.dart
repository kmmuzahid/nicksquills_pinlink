import 'package:core_kit/core_kit.dart';
import 'package:core_kit/network/request_input.dart';
import 'package:pinlink/config/api/api_end_point.dart';
import 'package:pinlink/config/bloc/safe_cubit.dart';
import 'package:pinlink/features/tournament/cubit/tournament_state.dart';
import 'package:pinlink/features/tournament/model/tournament_info_model.dart';
import 'package:pinlink/features/tournament/model/tournament_model.dart';

class TournamentCubit extends SafeCubit<TournamentState> {
  TournamentCubit() : super(const TournamentState()) {
    getTournamentList();
  }

  String? query;
  final Debouncer _debouncer = Debouncer(milliseconds: 300);

  void search(String? value) {
    _debouncer.run(() {
      query = value;
      getTournamentList(isRefresh: true);
    });
  }

  Future<void> getTournamentList({int page = 1, bool isRefresh = false}) async {
    emit(
      state.copyWith(isLoading: true, tournamentList: isRefresh ? [] : null),
    );
    final result = await DioService.instance.request(
      input: RequestInput(
        method: .GET,
        endpoint: ApiEndPoint.instance.getTournament,
        queryParams: {"searchTerm": ?query, "page": page, "limit": 10},
      ),
      responseBuilder: (data) {
        final tournamentList = List<TournamentModel>.from(
          (data['data'] as List).map((e) => TournamentModel.fromJson(e)),
        );
        final info = TournamentInfoModel(
          allCreatedTournamentCount:
              data['allCreatedTournamentCount']?.toInt() ?? 0,
          allInvitedTournamentCount:
              data['allInvitedTournamentCount']?.toInt() ?? 0,
        );

        return MapEntry(info, tournamentList);
      },
    );
    emit(
      state.copyWith(
        tournamentList: [
          ...state.tournamentList,
          ...(result.data?.value ?? []),
        ],
        tournamentInfoModel: result.data?.key,
        isLoading: false,
      ),
    );
  }
}
