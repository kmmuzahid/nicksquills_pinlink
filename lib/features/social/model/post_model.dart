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

  PostModel copyWith({
    String? id,
    UserId? userId,
    PostDataId? postDataId,
    bool? isScorecard,
    List<dynamic>? likes,
    int? commentsCount,
    int? likesCount,
    int? shareCount,
    int? reportCount,
    bool? isDeleted,
    String? createdAt,
    String? updatedAt,
  }) {
    return PostModel(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      postDataId: postDataId ?? this.postDataId,
      isScorecard: isScorecard ?? this.isScorecard,
      likes: likes ?? this.likes,
      commentsCount: commentsCount ?? this.commentsCount,
      likesCount: likesCount ?? this.likesCount,
      shareCount: shareCount ?? this.shareCount,
      reportCount: reportCount ?? this.reportCount,
      isDeleted: isDeleted ?? this.isDeleted,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  factory PostModel.fromJson(Map<String, dynamic> json) =>
      _$PostModelFromJson(json);
  Map<String, dynamic> toJson() => _$PostModelToJson(this);
}

@JsonSerializable()
class PostDataId {
  @JsonKey(name: '_id')
  final String? id;
  @JsonKey(name: 'courseId')
  final CourseId? courseId;
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
    this.courseId,
    this.headline,
    this.description,
    this.isScorecard,
    this.scorecardDate,
    this.scorecardHoles,
    this.scorecardTotalScore,
    this.links,
    this.mediaLinks,
  });

  factory PostDataId.fromJson(Map<String, dynamic> json) =>
      _$PostDataIdFromJson(json);
  Map<String, dynamic> toJson() => _$PostDataIdToJson(this);
}

@JsonSerializable()
class CourseId {
  @JsonKey(name: '_id')
  final String? id;
  @JsonKey(name: 'name')
  final String? name;
  @JsonKey(name: 'locationName')
  final String? locationName;

  CourseId({this.id, this.name, this.locationName});

  factory CourseId.fromJson(Map<String, dynamic> json) =>
      _$CourseIdFromJson(json);
  Map<String, dynamic> toJson() => _$CourseIdToJson(this);
}

@JsonSerializable()
class UserId {
  @JsonKey(name: '_id')
  final String? id;
  @JsonKey(name: 'profile')
  final String? profile;
  @JsonKey(name: 'fullName')
  final String? fullName;

  UserId({this.id, this.profile, this.fullName});

  factory UserId.fromJson(Map<String, dynamic> json) => _$UserIdFromJson(json);
  Map<String, dynamic> toJson() => _$UserIdToJson(this);
}
