import 'package:json_annotation/json_annotation.dart';

part 'elite_offer_approval_response.g.dart';

@JsonSerializable()
class EliteOfferApprovalResponse {
  final bool? status;
  final int? code;
  final String? message;
  final EliteOfferApprovalData? data;

  EliteOfferApprovalResponse({
    this.status,
    this.code,
    this.message,
    this.data,
  });

  factory EliteOfferApprovalResponse.fromJson(Map<String, dynamic> json) =>
      _$EliteOfferApprovalResponseFromJson(json);

  Map<String, dynamic> toJson() => _$EliteOfferApprovalResponseToJson(this);
}

@JsonSerializable()
class EliteOfferApprovalData {
  @JsonKey(name: 'payment_url')
  final String? paymentUrl;

  EliteOfferApprovalData({this.paymentUrl});

  factory EliteOfferApprovalData.fromJson(Map<String, dynamic> json) =>
      _$EliteOfferApprovalDataFromJson(json);

  Map<String, dynamic> toJson() => _$EliteOfferApprovalDataToJson(this);
}
