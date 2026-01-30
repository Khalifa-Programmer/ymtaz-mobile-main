import 'package:json_annotation/json_annotation.dart';

part 'advisories_general_specialization.g.dart';

@JsonSerializable()
class AdvisoriesGeneralSpecialization {
  @JsonKey(name: "status")
  bool? status;
  @JsonKey(name: "code")
  int? code;
  @JsonKey(name: "message")
  String? message;
  @JsonKey(name: "data")
  List<AdvisoriesGeneralData>? data;

  AdvisoriesGeneralSpecialization({
    this.status,
    this.code,
    this.message,
    this.data,
  });

  factory AdvisoriesGeneralSpecialization.fromJson(Map<String, dynamic> json) =>
      _$AdvisoriesGeneralSpecializationFromJson(json);

  Map<String, dynamic> toJson() =>
      _$AdvisoriesGeneralSpecializationToJson(this);
}

@JsonSerializable()
class AdvisoriesGeneralData {
  @JsonKey(name: "id")
  int? id;
  @JsonKey(name: "name")
  String? name;
  @JsonKey(name: "description")
  String? description;
  @JsonKey(name: "payment_category_type")
  PaymentCategoryType? paymentCategoryType;

  AdvisoriesGeneralData({
    this.id,
    this.name,
    this.description,
    this.paymentCategoryType,
  });

  factory AdvisoriesGeneralData.fromJson(Map<String, dynamic> json) =>
      _$AdvisoriesGeneralDataFromJson(json);

  Map<String, dynamic> toJson() => _$AdvisoriesGeneralDataToJson(this);
}

@JsonSerializable()
class PaymentCategoryType {
  @JsonKey(name: "id")
  int? id;
  @JsonKey(name: "name")
  String? name;
  @JsonKey(name: "description")
  String? description;
  @JsonKey(name: "requires_appointment")
  int? requiresAppointment;

  PaymentCategoryType({
    this.id,
    this.name,
    this.description,
    this.requiresAppointment,
  });

  factory PaymentCategoryType.fromJson(Map<String, dynamic> json) =>
      _$PaymentCategoryTypeFromJson(json);

  Map<String, dynamic> toJson() => _$PaymentCategoryTypeToJson(this);
}
