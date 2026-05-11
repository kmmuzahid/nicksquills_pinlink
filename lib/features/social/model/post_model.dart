import 'package:json_annotation/json_annotation.dart';

part 'post_model.g.dart';

@JsonSerializable()
class PostModel {
  @JsonKey(name: '_id')
  final String? id;
  @JsonKey(name: 'userId')
  final UserId? userId;
  @JsonKey(name: 'postDataId')
  final PostDataId? postDataId;
  @JsonKey(name: 'isScorecard')
  final bool? isScorecard;
  @JsonKey(name: 'likes')
  final List<dynamic>? likes;
  @JsonKey(name: 'commentsCount')
  final int? commentsCount;
  @JsonKey(name: 'likesCount')
  final int? likesCount;
  @JsonKey(name: 'shareCount')
  final int? shareCount;
  @JsonKey(name: 'reportCount')
  final int? reportCount;
  @JsonKey(name: 'isDeleted')
  final bool? isDeleted;
  @JsonKey(name: 'createdAt')
  final String? createdAt;
  @JsonKey(name: 'updatedAt')
  final String? updatedAt;

  PostModel({
    this.id,
    this.userId,
    this.postDataId,
    this.isScorecard,
    this.likes,
    this.commentsCount,
    this.likesCount,
    this.shareCount,
    this.reportCount,
    this.isDeleted,
    this.createdAt,
    this.updatedAt,
  });

  factory PostModel.fromJson(Map<String, dynamic> json) => _$PostModelFromJson(json);
  Map<String, dynamic> toJson() => _$PostModelToJson(this);
}

@JsonSerializable()
class PostDataId {
  @JsonKey(name: '_id')
  final String? id;
  @JsonKey(name: 'coursename')
  final String? coursename;
  @JsonKey(name: 'headline')
  final String? headline;
  @JsonKey(name: 'description')
  final String? description;
  @JsonKey(name: 'isScorecard')
  final bool? isScorecard;
  @JsonKey(name: 'scorecardDate')
  final String? scorecardDate;
  @JsonKey(name: 'scorecardHoles')
  final int? scorecardHoles;
  @JsonKey(name: 'scorecardTotalScore')
  final int? scorecardTotalScore;
  @JsonKey(name: 'links')
  final List<String?>? links;
  @JsonKey(name: 'mediaLinks')
  final List<String?>? mediaLinks;

  PostDataId({
    this.id,
    this.coursename,
    this.headline,
    this.description,
    this.isScorecard,
    this.scorecardDate,
    this.scorecardHoles,
    this.scorecardTotalScore,
    this.links,
    this.mediaLinks,
  });

  factory PostDataId.fromJson(Map<String, dynamic> json) => _$PostDataIdFromJson(json);
  Map<String, dynamic> toJson() => _$PostDataIdToJson(this);
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