import 'package:json_annotation/json_annotation.dart';

part 'advisories_accurate_specialization.g.dart';

@JsonSerializable()
class AdvisoriesAccurateSpecialization {
  @JsonKey(name: "status")
  bool? status;
  @JsonKey(name: "code")
  int? code;
  @JsonKey(name: "message")
  String? message;
  @JsonKey(name: "data")
  AdvisoriesAccurateData? data;

  AdvisoriesAccurateSpecialization({
    this.status,
    this.code,
    this.message,
    this.data,
  });

  factory AdvisoriesAccurateSpecialization.fromJson(
          Map<String, dynamic> json) =>
      _$AdvisoriesAccurateSpecializationFromJson(json);

  Map<String, dynamic> toJson() =>
      _$AdvisoriesAccurateSpecializationToJson(this);
}

@JsonSerializable()
class AdvisoriesAccurateData {
  @JsonKey(name: "subCategories")
  List<SubCategory>? subCategories;

  AdvisoriesAccurateData({
    this.subCategories,
  });

  factory AdvisoriesAccurateData.fromJson(Map<String, dynamic> json) =>
      _$AdvisoriesAccurateDataFromJson(json);

  Map<String, dynamic> toJson() => _$AdvisoriesAccurateDataToJson(this);
}

@JsonSerializable()
class SubCategory {
  @JsonKey(name: "id")
  int? id;
  @JsonKey(name: "name")
  String? name;
  @JsonKey(name: "description")
  String? description;
  @JsonKey(name: "general_category")
  GeneralCategory? generalCategory;
  @JsonKey(name: "levels")
  List<LevelElement>? levels;

  SubCategory({
    this.id,
    this.name,
    this.description,
    this.generalCategory,
    this.levels,
  });

  factory SubCategory.fromJson(Map<String, dynamic> json) =>
      _$SubCategoryFromJson(json);

  Map<String, dynamic> toJson() => _$SubCategoryToJson(this);
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

  LevelElement({
    this.id,
    this.duration,
    this.level,
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
