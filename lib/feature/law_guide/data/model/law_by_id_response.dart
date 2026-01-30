import 'package:json_annotation/json_annotation.dart';

part 'law_by_id_response.g.dart';

@JsonSerializable()
class LawByIdResponse {
  @JsonKey(name: "status")
  bool? status;
  @JsonKey(name: "code")
  int? code;
  @JsonKey(name: "message")
  String? message;
  @JsonKey(name: "data")
  Data? data;

  LawByIdResponse({
    this.status,
    this.code,
    this.message,
    this.data,
  });

  factory LawByIdResponse.fromJson(Map<String, dynamic> json) =>
      _$LawByIdResponseFromJson(json);

  Map<String, dynamic> toJson() => _$LawByIdResponseToJson(this);
}

@JsonSerializable()
class Data {
  @JsonKey(name: "law")
  Law? law;

  Data({
    this.law,
  });

  factory Data.fromJson(Map<String, dynamic> json) => _$DataFromJson(json);

  Map<String, dynamic> toJson() => _$DataToJson(this);
}

@JsonSerializable()
class Law {
  @JsonKey(name: "id")
  int? id;
  @JsonKey(name: "name")
  String? name;
  @JsonKey(name: "name_en")
  String? nameEn;
  @JsonKey(name: "law")
  String? law;
  @JsonKey(name: "law_en")
  String? lawEn;
  @JsonKey(name: "changes")
  String? changes;
  @JsonKey(name: "changes_en")
  String? changesEn;
  @JsonKey(name: "lawGuide")
  LawGuide? lawGuide;

  Law({
    this.id,
    this.name,
    this.nameEn,
    this.law,
    this.lawEn,
    this.changes,
    this.changesEn,
    this.lawGuide,
  });

  factory Law.fromJson(Map<String, dynamic> json) => _$LawFromJson(json);

  Map<String, dynamic> toJson() => _$LawToJson(this);
}

@JsonSerializable()
class LawGuide {
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

  LawGuide({
    this.id,
    this.name,
    this.nameEn,
    this.wordFileAr,
    this.wordFileEn,
    this.pdfFileAr,
    this.pdfFileEn,
    this.releasedAt,
    this.publishedAt,
    this.about,
    this.aboutEn,
    this.status,
    this.releaseTool,
    this.releaseToolEn,
    this.numberOfChapters,
    this.count,
    this.lawGuideMainCategory,
  });

  factory LawGuide.fromJson(Map<String, dynamic> json) =>
      _$LawGuideFromJson(json);

  Map<String, dynamic> toJson() => _$LawGuideToJson(this);
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
