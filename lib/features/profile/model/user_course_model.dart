import 'package:json_annotation/json_annotation.dart';

part 'user_course_model.g.dart';

@JsonSerializable()
class UserCourseModel {
  @JsonKey(name: '_id')
  final String? id;
  @JsonKey(name: 'userId')
  final String? userId;
  @JsonKey(name: 'courseId')
  final Course? courseId;
  @JsonKey(name: 'favorite')
  final double? favorite;
  @JsonKey(name: 'scenery')
  final double? scenery;
  @JsonKey(name: 'difficulty')
  final double? difficulty;
  @JsonKey(name: 'teeBoxFairwayCondition')
  final double? teeBoxFairwayCondition;
  @JsonKey(name: 'greenSpeed')
  final double? greenSpeed;
  @JsonKey(name: 'greenCondition')
  final double? greenCondition;
  @JsonKey(name: 'clubHouse')
  final double? clubHouse;
  @JsonKey(name: 'foodDrink')
  final double? foodDrink;
  @JsonKey(name: 'rank')
  final double? rank;
  @JsonKey(name: 'customRank')
  final double? customRank;
  @JsonKey(name: 'isPinkLink5')
  final bool? isPinkLink5;
  @JsonKey(name: 'createdAt')
  final String? createdAt;
  @JsonKey(name: 'updatedAt')
  final String? updatedAt;

  UserCourseModel({
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
    this.createdAt,
    this.updatedAt,
  });

  UserCourseModel copyWith({
    String? id,
    String? userId,
    Course? courseId,
    double? favorite,
    double? scenery,
    double? difficulty,
    double? teeBoxFairwayCondition,
    double? greenSpeed,
    double? greenCondition,
    double? clubHouse,
    double? foodDrink,
    double? rank,
    double? customRank,
    bool? isPinkLink5,
    String? createdAt,
    String? updatedAt,
  }) => UserCourseModel(
    id: id ?? this.id,
    userId: userId ?? this.userId,
    courseId: courseId ?? this.courseId,
    favorite: favorite ?? this.favorite,
    scenery: scenery ?? this.scenery,
    difficulty: difficulty ?? this.difficulty,
    teeBoxFairwayCondition:
        teeBoxFairwayCondition ?? this.teeBoxFairwayCondition,
    greenSpeed: greenSpeed ?? this.greenSpeed,
    greenCondition: greenCondition ?? this.greenCondition,
    clubHouse: clubHouse ?? this.clubHouse,
    foodDrink: foodDrink ?? this.foodDrink,
    rank: rank ?? this.rank,
    customRank: customRank ?? this.customRank,
    isPinkLink5: isPinkLink5 ?? this.isPinkLink5,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );

  factory UserCourseModel.fromJson(Map<String, dynamic> json) =>
      _$UserCourseModelFromJson(json);
  Map<String, dynamic> toJson() => _$UserCourseModelToJson(this);
}

@JsonSerializable()
class Course {
  @JsonKey(name: '_id')
  final String? id;
  @JsonKey(name: 'name')
  final String? name;
  @JsonKey(name: 'locationName')
  final String? locationName;
  @JsonKey(name: 'image')
  final String? image;
  @JsonKey(name: 'isPinkLink5')
  final bool? isPinkLink5;
  @JsonKey(name: 'latitude')
  final double? latitude;
  @JsonKey(name: 'longitude')
  final double? longitude;

  Course({
    this.id,
    this.name,
    this.locationName,
    this.image,
    this.isPinkLink5,
    this.latitude,
    this.longitude,
  });

  factory Course.fromJson(Map<String, dynamic> json) => _$CourseFromJson(json);
  Map<String, dynamic> toJson() => _$CourseToJson(this);
}
