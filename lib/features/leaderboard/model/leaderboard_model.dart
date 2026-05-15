import 'package:json_annotation/json_annotation.dart';

part 'leaderboard_model.g.dart';

@JsonSerializable()
class LeaderboardModel {
  @JsonKey(name: 'playCount')
  final int? playCount;
  @JsonKey(name: 'totalCourses')
  final int? totalCourses;
  @JsonKey(name: 'name')
  final String? name;
  @JsonKey(name: 'email')
  final String? email;
  @JsonKey(name: 'pointCount')
  final int? pointCount;

  @JsonKey(name: 'miles')
  final double? miles;

  LeaderboardModel({
    this.playCount,
    this.totalCourses,
    this.name,
    this.email,
    this.pointCount,
    this.miles,
  });

  factory LeaderboardModel.fromJson(Map<String, dynamic> json) =>
      _$LeaderboardModelFromJson(json);
  Map<String, dynamic> toJson() => _$LeaderboardModelToJson(this);
}
