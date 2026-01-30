import 'package:json_annotation/json_annotation.dart';

part 'notifications_resonse_model.g.dart';

@JsonSerializable()
class NotificationsResponseModel {
  @JsonKey(name: "status")
  bool? status;
  @JsonKey(name: "code")
  int? code;
  @JsonKey(name: "message")
  String? message;
  @JsonKey(name: "data")
  NotificationData? data;

  NotificationsResponseModel({
    this.status,
    this.code,
    this.message,
    this.data,
  });

  factory NotificationsResponseModel.fromJson(Map<String, dynamic> json) =>
      _$NotificationsResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$NotificationsResponseModelToJson(this);
}

@JsonSerializable()
class NotificationData {
  @JsonKey(name: "notifications")
  List<NotificationItem>? notifications;

  NotificationData({
    this.notifications,
  });

  factory NotificationData.fromJson(Map<String, dynamic> json) =>
      _$NotificationDataFromJson(json);

  Map<String, dynamic> toJson() => _$NotificationDataToJson(this);
}

@JsonSerializable()
class NotificationItem {
  @JsonKey(name: "id")
  String? id;
  @JsonKey(name: "title")
  String? title;
  @JsonKey(name: "description")
  String? description;
  @JsonKey(name: "type")
  String? type;
  @JsonKey(name: "type_id")
  String? typeId;
  @JsonKey(name: "userType")
  String? userType;
  @JsonKey(name: "service_user_id")
  String? serviceUserId;
  @JsonKey(name: "lawyer_id")
  dynamic lawyerId;
  @JsonKey(name: "seen")
  int? seen;
  @JsonKey(name: "created_at")
  String? createdAt;
  @JsonKey(name: "updated_at")
  String? updatedAt;
  @JsonKey(name: "deleted_at")
  dynamic deletedAt;

  NotificationItem({
    this.id,
    this.title,
    this.description,
    this.type,
    this.typeId,
    this.userType,
    this.serviceUserId,
    this.lawyerId,
    this.seen,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
  });

  factory NotificationItem.fromJson(Map<String, dynamic> json) =>
      _$NotificationItemFromJson(json);

  Map<String, dynamic> toJson() => _$NotificationItemToJson(this);
}
