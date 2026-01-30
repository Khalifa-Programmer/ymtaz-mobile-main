import 'package:json_annotation/json_annotation.dart';

part 'section_type.g.dart';

@JsonSerializable()
class SectionsType {
  @JsonKey(name: "status")
  bool? status;
  @JsonKey(name: "code")
  int? code;
  @JsonKey(name: "message")
  String? message;
  @JsonKey(name: "data")
  Data? data;

  SectionsType({
    this.status,
    this.code,
    this.message,
    this.data,
  });

  factory SectionsType.fromJson(Map<String, dynamic> json) =>
      _$SectionsTypeFromJson(json);

  Map<String, dynamic> toJson() => _$SectionsTypeToJson(this);
}

@JsonSerializable()
class Data {
  @JsonKey(name: "DigitalGuideCategories")
  List<DigitalGuideCategory>? digitalGuideCategories;

  Data({
    this.digitalGuideCategories,
  });

  factory Data.fromJson(Map<String, dynamic> json) => _$DataFromJson(json);

  Map<String, dynamic> toJson() => _$DataToJson(this);
}

@JsonSerializable()
class DigitalGuideCategory {
  @JsonKey(name: "id")
  int? id;
  @JsonKey(name: "title")
  String? title;
  @JsonKey(name: "image")
  String? image;
  @JsonKey(name: "need_license")
  int? needLicense;
  @JsonKey(name: "lawyers_count")
  int? lawyersCount;

  @override
  String toString() {
    return '$title';
  }

  DigitalGuideCategory({
    this.id,
    this.title,
    this.image,
    this.needLicense,
    this.lawyersCount,
  });

  factory DigitalGuideCategory.fromJson(Map<String, dynamic> json) =>
      _$DigitalGuideCategoryFromJson(json);

  Map<String, dynamic> toJson() => _$DigitalGuideCategoryToJson(this);
}
