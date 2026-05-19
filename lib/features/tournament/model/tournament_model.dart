import 'package:json_annotation/json_annotation.dart';

part 'tournament_model.g.dart';

@JsonSerializable()
class TournamentModel {
  @JsonKey(name: '_id')
  final String? id;
  @JsonKey(name: 'userId')
  final UserId? userId;
  @JsonKey(name: 'name')
  final String? name;
  @JsonKey(name: 'friendList')
  final List<FriendList?>? friendList;
  @JsonKey(name: 'startDate')
  final String? startDate;
  @JsonKey(name: 'endDate')
  final String? endDate;
  @JsonKey(name: 'isDeleted')
  final bool? isDeleted;
  @JsonKey(name: 'createdAt')
  final String? createdAt;
  @JsonKey(name: 'updatedAt')
  final String? updatedAt;

  TournamentModel({
    this.id,
    this.userId,
    this.name,
    this.friendList,
    this.startDate,
    this.endDate,
    this.isDeleted,
    this.createdAt,
    this.updatedAt,
  });

  factory TournamentModel.fromJson(Map<String, dynamic> json) => _$TournamentModelFromJson(json);
  Map<String, dynamic> toJson() => _$TournamentModelToJson(this);
}

@JsonSerializable()
class FriendList {
  @JsonKey(name: '_id')
  final String? id;
  @JsonKey(name: 'profile')
  final String? profile;
  @JsonKey(name: 'fullName')
  final String? fullName;

  FriendList({
    this.id,
    this.profile,
    this.fullName,
  });

  factory FriendList.fromJson(Map<String, dynamic> json) => _$FriendListFromJson(json);
  Map<String, dynamic> toJson() => _$FriendListToJson(this);
}

@JsonSerializable()
class UserId {
  @JsonKey(name: '_id')
  final String? id;
  @JsonKey(name: 'profile')
  final String? profile;
  @JsonKey(name: 'fullName')
  final String? fullName;

  UserId({
    this.id,
    this.profile,
    this.fullName,
  });

  factory UserId.fromJson(Map<String, dynamic> json) => _$UserIdFromJson(json);
  Map<String, dynamic> toJson() => _$UserIdToJson(this);
}