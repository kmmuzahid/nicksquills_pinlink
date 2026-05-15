import 'package:equatable/equatable.dart';
import 'package:pinlink/constant/enums.dart';
import 'package:pinlink/features/leaderboard/model/leaderboard_model.dart';

class LeaderboardState extends Equatable {
  const LeaderboardState({
    this.leaderboardType = LeaderboardType.pinLinksWorldRankings,
    this.searchType = LeaderboardSearchType.Points,
    this.isLeaderBoardLoading = false,
    this.leaderboardList = const [],
  });
  final LeaderboardType leaderboardType;
  final LeaderboardSearchType searchType;
  final bool isLeaderBoardLoading;
  final List<LeaderboardModel> leaderboardList;

  LeaderboardState copyWith({
    LeaderboardType? leaderboardType,
    LeaderboardSearchType? searchType,
    List<LeaderboardModel>? leaderboardList,
    bool? isLeaderboardLoading,
  }) {
    return LeaderboardState(
      leaderboardType: leaderboardType ?? this.leaderboardType,
      searchType: searchType ?? this.searchType,
      isLeaderBoardLoading: isLeaderboardLoading ?? this.isLeaderBoardLoading,
      leaderboardList: leaderboardList ?? this.leaderboardList,
    );
  }

  @override
  List<Object?> get props => [
    leaderboardType,
    searchType,
    isLeaderBoardLoading,
    leaderboardList,
  ];
}
