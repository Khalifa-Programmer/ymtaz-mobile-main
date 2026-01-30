import 'package:json_annotation/json_annotation.dart';

part 'respond_clinet_to_offer_response.g.dart';

@JsonSerializable()
class RespondClinetToOfferResponse {
  @JsonKey(name: "status")
  bool? status;
  @JsonKey(name: "code")
  int? code;
  @JsonKey(name: "message")
  String? message;
  @JsonKey(name: "data")
  Data? data;

  RespondClinetToOfferResponse({
    this.status,
    this.code,
    this.message,
    this.data,
  });

  factory RespondClinetToOfferResponse.fromJson(Map<String, dynamic> json) =>
      _$RespondClinetToOfferResponseFromJson(json);

  Map<String, dynamic> toJson() => _$RespondClinetToOfferResponseToJson(this);
}

@JsonSerializable()
class Data {
  @JsonKey(name: "service_request")
  ServiceRequest? serviceRequest;
  @JsonKey(name: "transaction_id")
  String? transactionId;
  @JsonKey(name: "payment_url")
  String? paymentUrl;

  Data({
    this.serviceRequest,
    this.transactionId,
    this.paymentUrl,
  });

  factory Data.fromJson(Map<String, dynamic> json) => _$DataFromJson(json);

  Map<String, dynamic> toJson() => _$DataToJson(this);
}

@JsonSerializable()
class ServiceRequest {
  @JsonKey(name: "account_id")
  String? accountId;
  @JsonKey(name: "type_id")
  int? typeId;
  @JsonKey(name: "priority")
  int? priority;
  @JsonKey(name: "description")
  String? description;
  @JsonKey(name: "for_admin")
  int? forAdmin;
  @JsonKey(name: "reserved_from_lawyer_id")
  String? reservedFromLawyerId;
  @JsonKey(name: "payment_status")
  int? paymentStatus;
  @JsonKey(name: "price")
  String? price;
  @JsonKey(name: "accept_rules")
  int? acceptRules;
  @JsonKey(name: "transaction_complete")
  int? transactionComplete;
  @JsonKey(name: "status")
  int? status;
  @JsonKey(name: "request_status")
  int? requestStatus;
  @JsonKey(name: "updated_at")
  String? updatedAt;
  @JsonKey(name: "created_at")
  String? createdAt;
  @JsonKey(name: "id")
  int? id;
  @JsonKey(name: "transaction_id")
  String? transactionId;

  ServiceRequest({
    this.accountId,
    this.typeId,
    this.priority,
    this.description,
    this.forAdmin,
    this.reservedFromLawyerId,
    this.paymentStatus,
    this.price,
    this.acceptRules,
    this.transactionComplete,
    this.status,
    this.requestStatus,
    this.updatedAt,
    this.createdAt,
    this.id,
    this.transactionId,
  });

  factory ServiceRequest.fromJson(Map<String, dynamic> json) =>
      _$ServiceRequestFromJson(json);

  Map<String, dynamic> toJson() => _$ServiceRequestToJson(this);
}
