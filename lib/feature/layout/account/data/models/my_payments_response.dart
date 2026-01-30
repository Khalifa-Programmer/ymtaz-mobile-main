import 'package:json_annotation/json_annotation.dart';

part 'my_payments_response.g.dart';

@JsonSerializable()
class MyPaymentsResponse {
  @JsonKey(name: "status")
  bool? status;
  @JsonKey(name: "code")
  int? code;
  @JsonKey(name: "message")
  String? message;
  @JsonKey(name: "data")
  Data? data;

  MyPaymentsResponse({
    this.status,
    this.code,
    this.message,
    this.data,
  });

  factory MyPaymentsResponse.fromJson(Map<String, dynamic> json) =>
      _$MyPaymentsResponseFromJson(json);

  Map<String, dynamic> toJson() => _$MyPaymentsResponseToJson(this);
}

@JsonSerializable()
class Data {
  @JsonKey(name: "payments")
  List<Payment>? payments;

  Data({
    this.payments,
  });

  factory Data.fromJson(Map<String, dynamic> json) => _$DataFromJson(json);

  Map<String, dynamic> toJson() => _$DataToJson(this);
}

@JsonSerializable()
class Payment {
  @JsonKey(name: "transaction_id")
  String? transactionId;
  @JsonKey(name: "payment_category_type_name")
  String? paymentCategoryTypeName;
  @JsonKey(name: "main_category_name")
  String? mainCategoryName;
  @JsonKey(name: "name")
  String? name;
  @JsonKey(name: "type")
  String? type;
  @JsonKey(name: "importance")
  String? importance;
  @JsonKey(name: "price")
  int? price;
  @JsonKey(name: "created_at")
  String? createdAt;
  @JsonKey(name: "transaction_complete")
  int? transactionComplete;

  Payment({
    this.transactionId,
    this.paymentCategoryTypeName,
    this.mainCategoryName,
    this.name,
    this.type,
    this.importance,
    this.price,
    this.createdAt,
    this.transactionComplete,
  });

  factory Payment.fromJson(Map<String, dynamic> json) =>
      _$PaymentFromJson(json);

  Map<String, dynamic> toJson() => _$PaymentToJson(this);
}
