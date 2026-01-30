import 'package:json_annotation/json_annotation.dart';

part 'response_lawyer_to_offer.g.dart';

@JsonSerializable()
class ResponseLawyerToOffer {
  @JsonKey(name: "status")
  bool? status;
  @JsonKey(name: "code")
  int? code;
  @JsonKey(name: "message")
  String? message;
  @JsonKey(name: "data")
  Data? data;

  ResponseLawyerToOffer({
    this.status,
    this.code,
    this.message,
    this.data,
  });

  factory ResponseLawyerToOffer.fromJson(Map<String, dynamic> json) =>
      _$ResponseLawyerToOfferFromJson(json);

  Map<String, dynamic> toJson() => _$ResponseLawyerToOfferToJson(this);
}

@JsonSerializable()
class Data {
  @JsonKey(name: "offer")
  Offer? offer;

  Data({
    this.offer,
  });

  factory Data.fromJson(Map<String, dynamic> json) => _$DataFromJson(json);

  Map<String, dynamic> toJson() => _$DataToJson(this);
}

@JsonSerializable()
class Offer {
  @JsonKey(name: "id")
  int? id;
  @JsonKey(name: "service_id")
  int? serviceId;
  @JsonKey(name: "importance_id")
  int? importanceId;
  @JsonKey(name: "account_id")
  String? accountId;
  @JsonKey(name: "description")
  String? description;
  @JsonKey(name: "lawyer_id")
  String? lawyerId;
  @JsonKey(name: "price")
  String? price;
  @JsonKey(name: "status")
  String? status;
  @JsonKey(name: "created_at")
  String? createdAt;
  @JsonKey(name: "updated_at")
  String? updatedAt;

  Offer({
    this.id,
    this.serviceId,
    this.importanceId,
    this.accountId,
    this.description,
    this.lawyerId,
    this.price,
    this.status,
    this.createdAt,
    this.updatedAt,
  });

  factory Offer.fromJson(Map<String, dynamic> json) => _$OfferFromJson(json);

  Map<String, dynamic> toJson() => _$OfferToJson(this);
}
