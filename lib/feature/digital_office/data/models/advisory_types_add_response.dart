import 'package:json_annotation/json_annotation.dart';

part 'advisory_types_add_response.g.dart';

@JsonSerializable()
class AdvisoryTypesAddResponse {
  @JsonKey(name: "status")
  bool? status;
  @JsonKey(name: "code")
  int? code;
  @JsonKey(name: "message")
  String? message;
  @JsonKey(name: "data")
  Data? data;

  AdvisoryTypesAddResponse({
    this.status,
    this.code,
    this.message,
    this.data,
  });

  factory AdvisoryTypesAddResponse.fromJson(Map<String, dynamic> json) =>
      _$AdvisoryTypesAddResponseFromJson(json);

  Map<String, dynamic> toJson() => _$AdvisoryTypesAddResponseToJson(this);
}

@JsonSerializable()
class Data {
  @JsonKey(name: "id")
  int? id;
  @JsonKey(name: "name")
  String? name;
  @JsonKey(name: "description")
  String? description;
  @JsonKey(name: "min_price")
  int? minPrice;
  @JsonKey(name: "max_price")
  int? maxPrice;
  @JsonKey(name: "general_category")
  GeneralCategory? generalCategory;
  @JsonKey(name: "levels")
  List<LevelElement>? levels;

  Data({
    this.id,
    this.name,
    this.description,
    this.minPrice,
    this.maxPrice,
    this.generalCategory,
    this.levels,
  });

  factory Data.fromJson(Map<String, dynamic> json) => _$DataFromJson(json);

  Map<String, dynamic> toJson() => _$DataToJson(this);
}

@JsonSerializable()
class GeneralCategory {
  @JsonKey(name: "id")
  int? id;
  @JsonKey(name: "name")
  String? name;
  @JsonKey(name: "description")
  String? description;
  @JsonKey(name: "payment_category_type")
  PaymentCategoryType? paymentCategoryType;

  GeneralCategory({
    this.id,
    this.name,
    this.description,
    this.paymentCategoryType,
  });

  factory GeneralCategory.fromJson(Map<String, dynamic> json) =>
      _$GeneralCategoryFromJson(json);

  Map<String, dynamic> toJson() => _$GeneralCategoryToJson(this);
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

@JsonSerializable()
class LevelElement {
  @JsonKey(name: "id")
  int? id;
  @JsonKey(name: "duration")
  int? duration;
  @JsonKey(name: "level")
  LevelLevel? level;
  @JsonKey(name: "price")
  String? price;

  LevelElement({
    this.id,
    this.duration,
    this.level,
    this.price,
  });

  factory LevelElement.fromJson(Map<String, dynamic> json) =>
      _$LevelElementFromJson(json);

  Map<String, dynamic> toJson() => _$LevelElementToJson(this);
}

@JsonSerializable()
class LevelLevel {
  @JsonKey(name: "id")
  int? id;
  @JsonKey(name: "title")
  String? title;

  LevelLevel({
    this.id,
    this.title,
  });

  factory LevelLevel.fromJson(Map<String, dynamic> json) =>
      _$LevelLevelFromJson(json);

  Map<String, dynamic> toJson() => _$LevelLevelToJson(this);
}
