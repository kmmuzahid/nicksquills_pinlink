import 'package:json_annotation/json_annotation.dart';

part 'profile_model.g.dart';

@JsonSerializable()
class ProfileModel {
  @JsonKey(name: 'isHandicap')
  final bool? isHandicap;
  @JsonKey(name: 'isFriendRequest')
  final bool? isFriendRequest;
  @JsonKey(name: 'isLeaderBoardUpdate')
  final bool? isLeaderBoardUpdate;
  @JsonKey(name: 'isTournamentInvite')
  final bool? isTournamentInvite;
  @JsonKey(name: 'isScoreUpdate')
  final bool? isScoreUpdate;
  @JsonKey(name: 'isPlayCourse')
  final bool? isPlayCourse;
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
  @JsonKey(name: 'friendCount')
  final int? friendCount;
  @JsonKey(name: 'pointCount')
  final int? pointCount;
  @JsonKey(name: 'followerCount')
  final int? followerCount;
  @JsonKey(name: 'followingCount')
  final int? followingCount;
  @JsonKey(name: 'referralCode')
  final String? referralCode;
  @JsonKey(name: 'permissions')
  final List<dynamic>? permissions;
  @JsonKey(name: 'latitude')
  final double? latitude;
  @JsonKey(name: 'longitude')
  final double? longitude;
  @JsonKey(name: 'createdAt')
  final String? createdAt;
  @JsonKey(name: 'updatedAt')
  final String? updatedAt;
  @JsonKey(name: '__v')
  final int? v;
  @JsonKey(name: 'address')
  final String? address;
  @JsonKey(name: 'allWishlishCount')
  final int? allWishlishCount;
  @JsonKey(name: 'allPostCount')
  final int? allPostCount;
  @JsonKey(name: 'allCompareCourseCount')
  final int? allCompareCourseCount;
  @JsonKey(name: 'subscription')
  final List<Subscription?>? subscription;

  ProfileModel({
    this.isHandicap,
    this.isFriendRequest,
    this.isLeaderBoardUpdate,
    this.isTournamentInvite,
    this.isScoreUpdate,
    this.isPlayCourse,
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
    this.friendCount,
    this.pointCount,
    this.followerCount,
    this.followingCount,
    this.referralCode,
    this.permissions,
    this.latitude,
    this.longitude,
    this.createdAt,
    this.updatedAt,
    this.v,
    this.address,
    this.allWishlishCount,
    this.allPostCount,
    this.allCompareCourseCount,
    this.subscription,
  });

  ProfileModel copyWith({
    bool? isHandicap,
    bool? isFriendRequest,
    bool? isLeaderBoardUpdate,
    bool? isTournamentInvite,
    bool? isScoreUpdate,
    bool? isPlayCourse,
    String? id,
    String? profile,
    String? fullName,
    String? email,
    String? username,
    String? role,
    bool? isActive,
    bool? isDeleted,
    String? handicap,
    String? homeCourse,
    bool? isVerified,
    bool? isStripeConnectedAccount,
    int? friendCount,
    int? pointCount,
    int? followerCount,
    int? followingCount,
    String? referralCode,
    List<dynamic>? permissions,
    double? latitude,
    double? longitude,
    String? createdAt,
    String? updatedAt,
    int? v,
    String? address,
    int? allWishlishCount,
    int? allPostCount,
    int? allCompareCourseCount,
    List<Subscription?>? subscription,
  }) {
    return ProfileModel(
      isHandicap: isHandicap ?? this.isHandicap,
      isFriendRequest: isFriendRequest ?? this.isFriendRequest,
      isLeaderBoardUpdate: isLeaderBoardUpdate ?? this.isLeaderBoardUpdate,
      isTournamentInvite: isTournamentInvite ?? this.isTournamentInvite,
      isScoreUpdate: isScoreUpdate ?? this.isScoreUpdate,
      isPlayCourse: isPlayCourse ?? this.isPlayCourse,
      id: id ?? this.id,
      profile: profile ?? this.profile,
      fullName: fullName ?? this.fullName,
      email: email ?? this.email,
      username: username ?? this.username,
      role: role ?? this.role,
      isActive: isActive ?? this.isActive,
      isDeleted: isDeleted ?? this.isDeleted,
      handicap: handicap ?? this.handicap,
      homeCourse: homeCourse ?? this.homeCourse,
      isVerified: isVerified ?? this.isVerified,
      isStripeConnectedAccount:
          isStripeConnectedAccount ?? this.isStripeConnectedAccount,
      friendCount: friendCount ?? this.friendCount,
      pointCount: pointCount ?? this.pointCount,
      followerCount: followerCount ?? this.followerCount,
      followingCount: followingCount ?? this.followingCount,
      referralCode: referralCode ?? this.referralCode,
      permissions: permissions ?? this.permissions,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      v: v ?? this.v,
      address: address ?? this.address,
      allWishlishCount: allWishlishCount ?? this.allWishlishCount,
      allPostCount: allPostCount ?? this.allPostCount,
      allCompareCourseCount:
          allCompareCourseCount ?? this.allCompareCourseCount,
      subscription: subscription ?? this.subscription,
    );
  }

  factory ProfileModel.fromJson(Map<String, dynamic> json) =>
      _$ProfileModelFromJson(json);
  Map<String, dynamic> toJson() => _$ProfileModelToJson(this);
}

@JsonSerializable()
class Subscription {
  @JsonKey(name: '_id')
  final String? id;
  @JsonKey(name: 'userId')
  final String? userId;
  @JsonKey(name: 'packageId')
  final PackageId? packageId;
  @JsonKey(name: 'name')
  final String? name;
  @JsonKey(name: 'amount')
  final int? amount;
  @JsonKey(name: 'startDate')
  final String? startDate;
  @JsonKey(name: 'endDate')
  final String? endDate;
  @JsonKey(name: 'createdAt')
  final String? createdAt;
  @JsonKey(name: 'updatedAt')
  final String? updatedAt;
  @JsonKey(name: '__v')
  final int? v;

  Subscription({
    this.id,
    this.userId,
    this.packageId,
    this.name,
    this.amount,
    this.startDate,
    this.endDate,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  factory Subscription.fromJson(Map<String, dynamic> json) =>
      _$SubscriptionFromJson(json);
  Map<String, dynamic> toJson() => _$SubscriptionToJson(this);
}

@JsonSerializable()
class PackageId {
  @JsonKey(name: 'features')
  final List<dynamic>? features;
  @JsonKey(name: '_id')
  final String? id;
  @JsonKey(name: 'title')
  final String? title;
  @JsonKey(name: 'price')
  final int? price;

  PackageId({this.features, this.id, this.title, this.price});

  factory PackageId.fromJson(Map<String, dynamic> json) =>
      _$PackageIdFromJson(json);
  Map<String, dynamic> toJson() => _$PackageIdToJson(this);
}
