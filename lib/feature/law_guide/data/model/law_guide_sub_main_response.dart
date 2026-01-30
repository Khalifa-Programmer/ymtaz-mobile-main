import 'package:json_annotation/json_annotation.dart';

part 'law_guide_sub_main_response.g.dart';

@JsonSerializable()
class LawGuideSubMainResponse {
  @JsonKey(name: "status")
  bool? status;
  @JsonKey(name: "code")
  int? code;
  @JsonKey(name: "message")
  String? message;
  @JsonKey(name: "data")
  Data? data;

  LawGuideSubMainResponse({
    this.status,
    this.code,
    this.message,
    this.data,
  });

  factory LawGuideSubMainResponse.fromJson(Map<String, dynamic> json) =>
      _$LawGuideSubMainResponseFromJson(json);

  Map<String, dynamic> toJson() => _$LawGuideSubMainResponseToJson(this);
}

@JsonSerializable()
class Data {
  @JsonKey(name: "subCategories")
  List<SubCategory>? subCategories;

  Data({
    this.subCategories,
  });

  factory Data.fromJson(Map<String, dynamic> json) => _$DataFromJson(json);

  Map<String, dynamic> toJson() => _$DataToJson(this);
}

@JsonSerializable()
class SubCategory {
  @JsonKey(name: "id")
  int? id;
  @JsonKey(name: "name")
  String? name;
  @JsonKey(name: "name_en")
  String? nameEn;
  @JsonKey(name: "word_file_ar")
  dynamic wordFileAr;
  @JsonKey(name: "word_file_en")
  dynamic wordFileEn;
  @JsonKey(name: "pdf_file_ar")
  String? pdfFileAr;
  @JsonKey(name: "pdf_file_en")
  String? pdfFileEn;
  @JsonKey(name: "released_at")
  DateTime? releasedAt;
  @JsonKey(name: "published_at")
  DateTime? publishedAt;
  @JsonKey(name: "released_at_hijri")
  DateTime? releasedAtHijri;
  @JsonKey(name: "published_at_hijri")
  DateTime? publishedAtHijri;
  @JsonKey(name: "about")
  String? about;
  @JsonKey(name: "about_en")
  String? aboutEn;
  @JsonKey(name: "status")
  String? status;
  @JsonKey(name: "release_tool")
  String? releaseTool;
  @JsonKey(name: "release_tool_en")
  String? releaseToolEn;
  @JsonKey(name: "number_of_chapters")
  int? numberOfChapters;
  @JsonKey(name: "count")
  int? count;
  @JsonKey(name: "lawGuideMainCategory")
  LawGuideMainCategory? lawGuideMainCategory;

  SubCategory({
    this.id,
    this.name,
    this.nameEn,
    this.wordFileAr,
    this.wordFileEn,
    this.pdfFileAr,
    this.pdfFileEn,
    this.releasedAt,
    this.publishedAt,
    this.releasedAtHijri,
    this.publishedAtHijri,
    this.about,
    this.aboutEn,
    this.status,
    this.releaseTool,
    this.releaseToolEn,
    this.numberOfChapters,
    this.count,
    this.lawGuideMainCategory,
  });

  factory SubCategory.fromJson(Map<String, dynamic> json) =>
      _$SubCategoryFromJson(json);

  Map<String, dynamic> toJson() => _$SubCategoryToJson(this);
}

@JsonSerializable()
class LawGuideMainCategory {
  @JsonKey(name: "id")
  int? id;
  @JsonKey(name: "name")
  String? name;

  LawGuideMainCategory({
    this.id,
    this.name,
  });

  factory LawGuideMainCategory.fromJson(Map<String, dynamic> json) =>
      _$LawGuideMainCategoryFromJson(json);

  Map<String, dynamic> toJson() => _$LawGuideMainCategoryToJson(this);
}
