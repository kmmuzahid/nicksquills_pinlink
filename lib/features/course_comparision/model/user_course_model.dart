import 'package:json_annotation/json_annotation.dart';

part 'user_course_model.g.dart';

@JsonSerializable()
class UserCourseModel {
  @JsonKey(name: 'location')
  final Location? location;
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
  @JsonKey(name: 'isActive')
  final bool? isActive;
  @JsonKey(name: 'latitude')
  final double? latitude;
  @JsonKey(name: 'longitude')
  final double? longitude;
  @JsonKey(name: 'isDeleted')
  final bool? isDeleted;
  @JsonKey(name: 'createdAt')
  final String? createdAt;
  @JsonKey(name: 'updatedAt')
  final String? updatedAt;
  @JsonKey(name: 'isPlay')
  final bool? isPlay;

  UserCourseModel({
    this.location,
    this.id,
    this.name,
    this.locationName,
    this.image,
    this.isPinkLink5,
    this.isActive,
    this.latitude,
    this.longitude,
    this.isDeleted,
    this.createdAt,
    this.updatedAt,
    this.isPlay,
  });

  factory UserCourseModel.fromJson(Map<String, dynamic> json) => _$UserCourseModelFromJson(json);
  Map<String, dynamic> toJson() => _$UserCourseModelToJson(this);
}

@JsonSerializable()
class Location {
  @JsonKey(name: 'type')
  final String? type;
  @JsonKey(name: 'coordinates')
  final List<double?>? coordinates;

  Location({
    this.type,
    this.coordinates,
  });

  factory Location.fromJson(Map<String, dynamic> json) => _$LocationFromJson(json);
  Map<String, dynamic> toJson() => _$LocationToJson(this);
}