import 'package:json_annotation/json_annotation.dart';

part 'notification_model.g.dart';

@JsonSerializable()
class NotificationModel {
  @JsonKey(name: '_id')
  final String? id;
  @JsonKey(name: 'userId')
  final String? userId;
  @JsonKey(name: 'title')
  final String? title;
  @JsonKey(name: 'message')
  final String? message;
  @JsonKey(name: 'type')
  final String? type;
  @JsonKey(name: 'status')
  final String? status;
  @JsonKey(name: 'isRead')
  final bool isRead;
  @JsonKey(name: 'profile')
  final String? profile;
  @JsonKey(name: 'friendRequestId')
  final String? friendRequestId;
  @JsonKey(name: 'createdAt')
  final DateTime? createdAt;
  @JsonKey(name: 'updatedAt')
  final DateTime? updatedAt;

  NotificationModel copyWith({
    String? id,
    String? userId,
    String? title,
    String? message,
    String? type,
    String? status,
    bool? isRead,
    String? profile,
    String? friendRequestId,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return NotificationModel(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      title: title ?? this.title,
      message: message ?? this.message,
      type: type ?? this.type,
      status: status ?? this.status,
      isRead: isRead ?? this.isRead,
      profile: profile ?? this.profile,
      friendRequestId: friendRequestId ?? this.friendRequestId,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  NotificationModel({
    this.id,
    this.userId,
    this.title,
    this.message,
    this.type,
    this.status,
    this.isRead = false,
    this.profile,
    this.friendRequestId,
    this.createdAt,
    this.updatedAt,
  });

  factory NotificationModel.fromJson(Map<String, dynamic> json) =>
      _$NotificationModelFromJson(json);
  Map<String, dynamic> toJson() => _$NotificationModelToJson(this);
}
