import 'package:json_annotation/json_annotation.dart';

part 'map_point_details_model.g.dart';

@JsonSerializable()
class MapPointDetailsModel {
  @JsonKey(name: 'allPost')
  final List<AllPost?>? allPost;
  @JsonKey(name: 'compareCourse')
  final CompareCourse? compareCourse;

  MapPointDetailsModel({
    this.allPost,
    this.compareCourse,
  });

  factory MapPointDetailsModel.fromJson(Map<String, dynamic> json) => _$MapPointDetailsModelFromJson(json);
  Map<String, dynamic> toJson() => _$MapPointDetailsModelToJson(this);
}

@JsonSerializable()
class CompareCourse {
  @JsonKey(name: '_id')
  final String? id;
  @JsonKey(name: 'userId')
  final String? userId;
  @JsonKey(name: 'courseId')
  final CourseId? courseId;
  @JsonKey(name: 'favorite')
  final int? favorite;
  @JsonKey(name: 'scenery')
  final int? scenery;
  @JsonKey(name: 'difficulty')
  final int? difficulty;
  @JsonKey(name: 'teeBoxFairwayCondition')
  final int? teeBoxFairwayCondition;
  @JsonKey(name: 'greenSpeed')
  final int? greenSpeed;
  @JsonKey(name: 'greenCondition')
  final int? greenCondition;
  @JsonKey(name: 'clubHouse')
  final int? clubHouse;
  @JsonKey(name: 'foodDrink')
  final int? foodDrink;
  @JsonKey(name: 'rank')
  final int? rank;
  @JsonKey(name: 'customRank')
  final double? customRank;
  @JsonKey(name: 'isPinkLink5')
  final bool? isPinkLink5;
  @JsonKey(name: 'customRankStatus')
  final String? customRankStatus;
  @JsonKey(name: 'createdAt')
  final String? createdAt;
  @JsonKey(name: 'updatedAt')
  final String? updatedAt;
  @JsonKey(name: '__v')
  final int? v;

  CompareCourse({
    this.id,
    this.userId,
    this.courseId,
    this.favorite,
    this.scenery,
    this.difficulty,
    this.teeBoxFairwayCondition,
    this.greenSpeed,
    this.greenCondition,
    this.clubHouse,
    this.foodDrink,
    this.rank,
    this.customRank,
    this.isPinkLink5,
    this.customRankStatus,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  factory CompareCourse.fromJson(Map<String, dynamic> json) => _$CompareCourseFromJson(json);
  Map<String, dynamic> toJson() => _$CompareCourseToJson(this);
}

@JsonSerializable()
class CourseId {
  @JsonKey(name: '_id')
  final String? id;
  @JsonKey(name: 'name')
  final String? name;

  CourseId({
    this.id,
    this.name,
  });

  factory CourseId.fromJson(Map<String, dynamic> json) => _$CourseIdFromJson(json);
  Map<String, dynamic> toJson() => _$CourseIdToJson(this);
}

@JsonSerializable()
class AllPost {
  @JsonKey(name: '_id')
  final String? id;
  @JsonKey(name: 'postDataId')
  final PostDataId? postDataId;

  AllPost({
    this.id,
    this.postDataId,
  });

  factory AllPost.fromJson(Map<String, dynamic> json) => _$AllPostFromJson(json);
  Map<String, dynamic> toJson() => _$AllPostToJson(this);
}

@JsonSerializable()
class PostDataId {
  @JsonKey(name: '_id')
  final String? id;
  @JsonKey(name: 'headline')
  final String? headline;
  @JsonKey(name: 'scorecardTotalScore')
  final int? scorecardTotalScore;
  @JsonKey(name: 'links')
  final List<String?>? links;
  @JsonKey(name: 'mediaLinks')
  final List<String?>? mediaLinks;
  @JsonKey(name: 'createdAt')
  final String? createdAt;

  PostDataId({
    this.id,
    this.headline,
    this.scorecardTotalScore,
    this.links,
    this.mediaLinks,
    this.createdAt,
  });

  factory PostDataId.fromJson(Map<String, dynamic> json) => _$PostDataIdFromJson(json);
  Map<String, dynamic> toJson() => _$PostDataIdToJson(this);
}