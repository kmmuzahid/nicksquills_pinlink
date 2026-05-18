import 'package:json_annotation/json_annotation.dart';

part 'friend_model.g.dart';

@JsonSerializable()
class FriendModel {
  @JsonKey(name: '_id')
  final String? id;
  @JsonKey(name: 'fullName')
  final String? fullName;
  @JsonKey(name: 'email')
  final String? email;
  @JsonKey(name: 'profile')
  final String? profile;
  @JsonKey(name: 'homeCourse')
  final String? homeCourse;
  @JsonKey(name: 'points')
  final int? points;
  @JsonKey(name: 'coursePlay')
  final int? coursePlay;
  @JsonKey(name: 'mostPinklink5Course')
  final int? mostPinklink5Course;
  @JsonKey(name: 'totalDistance')
  final double? totalDistance;

  FriendModel({
    this.id,
    this.fullName,
    this.email,
    this.profile,
    this.homeCourse,
    this.points,
    this.coursePlay,
    this.mostPinklink5Course,
    this.totalDistance,
  });

  factory FriendModel.fromJson(Map<String, dynamic> json) => _$FriendModelFromJson(json);
  Map<String, dynamic> toJson() => _$FriendModelToJson(this);
}