import 'package:json_annotation/json_annotation.dart';

part 'profile_model.g.dart';

@JsonSerializable()
class ProfileModel {
  @JsonKey(name: 'friendCount')
  final int? friendCount;
  @JsonKey(name: '_id')
  final String? id;
  @JsonKey(name: 'profile')
  final String? profile;
  @JsonKey(name: 'fullName')
  final String? fullName;
  @JsonKey(name: 'email')
  final String? email;
  @JsonKey(name: 'username')
  final String? username;
  @JsonKey(name: 'role')
  final String? role;
  @JsonKey(name: 'isActive')
  final bool? isActive;
  @JsonKey(name: 'isDeleted')
  final bool? isDeleted;
  @JsonKey(name: 'handicap')
  final String? handicap;
  @JsonKey(name: 'homeCourse')
  final String? homeCourse;
  @JsonKey(name: 'isVerified')
  final bool? isVerified;
  @JsonKey(name: 'isStripeConnectedAccount')
  final bool? isStripeConnectedAccount;
  @JsonKey(name: 'createdAt')
  final String? createdAt;
  @JsonKey(name: 'updatedAt')
  final String? updatedAt;
  @JsonKey(name: '__v')
  final int? v;
  @JsonKey(name: 'followingCount')
  final int? followingCount;
  @JsonKey(name: 'followerCount')
  final int? followerCount;
  @JsonKey(name: 'pointCount')
  final int? pointCount;

  ProfileModel({
    this.friendCount,
    this.id,
    this.profile,
    this.fullName,
    this.email,
    this.username,
    this.role,
    this.isActive,
    this.isDeleted,
    this.handicap,
    this.homeCourse,
    this.isVerified,
    this.isStripeConnectedAccount,
    this.createdAt,
    this.updatedAt,
    this.v,
    this.followingCount,
    this.followerCount,
    this.pointCount,
  });

  factory ProfileModel.fromJson(Map<String, dynamic> json) => _$ProfileModelFromJson(json);
  Map<String, dynamic> toJson() => _$ProfileModelToJson(this);
}