import 'package:equatable/equatable.dart';
import 'package:pinlink/features/tournament/model/tournament_info_model.dart';
import 'package:pinlink/features/tournament/model/tournament_model.dart';

class TournamentState extends Equatable {
  final List<TournamentModel> tournamentList;
  final bool isLoading;
  final TournamentInfoModel? tournamentInfoModel;

  const TournamentState({
    this.tournamentList = const [],
    this.isLoading = false,
    this.tournamentInfoModel,
  });

  @override
  List<Object?> get props => [tournamentList, isLoading, tournamentInfoModel];

  TournamentState copyWith({
    List<TournamentModel>? tournamentList,
    bool? isLoading,
    TournamentInfoModel? tournamentInfoModel,
  }) {
    return TournamentState(
      tournamentList: tournamentList ?? this.tournamentList,
      isLoading: isLoading ?? this.isLoading,
      tournamentInfoModel: tournamentInfoModel ?? this.tournamentInfoModel,
    );
  }
}
