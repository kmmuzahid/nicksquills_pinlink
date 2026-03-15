import 'package:equatable/equatable.dart';
import 'package:pinlink/constant/enums.dart';

class LeaderboardState extends Equatable {
  const LeaderboardState({
    this.leaderboardType = LeaderboardType.pinLinksWorldRankings,
    this.searchType = LeaderboardSearchType.Points,
  });
  final LeaderboardType leaderboardType;
  final LeaderboardSearchType searchType;

  LeaderboardState copyWith({LeaderboardType? leaderboardType, LeaderboardSearchType? searchType}) {
    return LeaderboardState(
      leaderboardType: leaderboardType ?? this.leaderboardType,
      searchType: searchType ?? this.searchType,
    );
  }

  @override
  List<Object?> get props => [leaderboardType, searchType];
}
