import 'package:json_annotation/json_annotation.dart';

part 'packages_subscribe_model.g.dart';

@JsonSerializable()
class PackagesSubscribeModel {
  @JsonKey(name: "status")
  bool? status;
  @JsonKey(name: "code")
  int? code;
  @JsonKey(name: "message")
  String? message;
  @JsonKey(name: "data")
  Data? data;

  PackagesSubscribeModel({
    this.status,
    this.code,
    this.message,
    this.data,
  });

  factory PackagesSubscribeModel.fromJson(Map<String, dynamic> json) => _$PackagesSubscribeModelFromJson(json);

  Map<String, dynamic> toJson() => _$PackagesSubscribeModelToJson(this);
}

@JsonSerializable()
class Data {
  @JsonKey(name: "subscription")
  Subscription? subscription;
  @JsonKey(name: "transaction_id")
  String? transactionId;
  @JsonKey(name: "payment_url")
  String? paymentUrl;

  Data({
    this.subscription,
    this.transactionId,
    this.paymentUrl,
  });

  factory Data.fromJson(Map<String, dynamic> json) => _$DataFromJson(json);

  Map<String, dynamic> toJson() => _$DataToJson(this);
}

@JsonSerializable()
class Subscription {
  @JsonKey(name: "package_id")
  int? packageId;
  @JsonKey(name: "account_id")
  String? accountId;
  @JsonKey(name: "transaction_id")
  String? transactionId;
  @JsonKey(name: "transaction_complete")
  int? transactionComplete;
  @JsonKey(name: "updated_at")
  String? updatedAt;
  @JsonKey(name: "created_at")
  String? createdAt;
  @JsonKey(name: "id")
  int? id;

  Subscription({
    this.packageId,
    this.accountId,
    this.transactionId,
    this.transactionComplete,
    this.updatedAt,
    this.createdAt,
    this.id,
  });

  factory Subscription.fromJson(Map<String, dynamic> json) => _$SubscriptionFromJson(json);

  Map<String, dynamic> toJson() => _$SubscriptionToJson(this);
}
