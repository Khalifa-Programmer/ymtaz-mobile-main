import 'package:json_annotation/json_annotation.dart';

part 'law_guide_search_response.g.dart';

@JsonSerializable()
class LawGuideSearchResponse {
  @JsonKey(name: "status")
  bool? status;
  @JsonKey(name: "code")
  int? code;
  @JsonKey(name: "message")
  String? message;
  @JsonKey(name: "data")
  Data? data;

  LawGuideSearchResponse({
    this.status,
    this.code,
    this.message,
    this.data,
  });

  factory LawGuideSearchResponse.fromJson(Map<String, dynamic> json) =>
      _$LawGuideSearchResponseFromJson(json);

  Map<String, dynamic> toJson() => _$LawGuideSearchResponseToJson(this);
}

@JsonSerializable()
class Data {
  @JsonKey(name: "lawGuideMainCategories")
  LawGuideMainCategories? lawGuideMainCategories;
  @JsonKey(name: "lawGuide")
  DataLawGuide? lawGuide;
  @JsonKey(name: "laws")
  DataLaws? laws;
  @JsonKey(name: "relatedLawGuides")
  RelatedLawGuides? relatedLawGuides;

  Data({
    this.lawGuideMainCategories,
    this.lawGuide,
    this.laws,
    this.relatedLawGuides,
  });

  factory Data.fromJson(Map<String, dynamic> json) => _$DataFromJson(json);

  Map<String, dynamic> toJson() => _$DataToJson(this);
}

@JsonSerializable()
class DataLawGuide {
  @JsonKey(name: "data")
  List<LawGuideDatum>? data;
  @JsonKey(name: "total")
  int? total;
  @JsonKey(name: "per_page")
  int? perPage;
  @JsonKey(name: "current_page")
  int? currentPage;
  @JsonKey(name: "last_page")
  int? lastPage;

  DataLawGuide({
    this.data,
    this.total,
    this.perPage,
    this.currentPage,
    this.lastPage,
  });

  factory DataLawGuide.fromJson(Map<String, dynamic> json) =>
      _$DataLawGuideFromJson(json);

  Map<String, dynamic> toJson() => _$DataLawGuideToJson(this);
}

@JsonSerializable()
class LawGuideDatum {
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
  dynamic pdfFileAr;
  @JsonKey(name: "pdf_file_en")
  dynamic pdfFileEn;
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
  @JsonKey(name: "laws")
  DatumLaws? laws;

  LawGuideDatum({
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
    this.laws,
  });

  factory LawGuideDatum.fromJson(Map<String, dynamic> json) =>
      _$LawGuideDatumFromJson(json);

  Map<String, dynamic> toJson() => _$LawGuideDatumToJson(this);
}

@JsonSerializable()
class DatumLaws {
  @JsonKey(name: "data")
  List<PurpleDatum>? data;
  @JsonKey(name: "total")
  int? total;
  @JsonKey(name: "current_page")
  int? currentPage;
  @JsonKey(name: "per_page")
  int? perPage;
  @JsonKey(name: "last_page")
  int? lastPage;

  DatumLaws({
    this.data,
    this.total,
    this.currentPage,
    this.perPage,
    this.lastPage,
  });

  factory DatumLaws.fromJson(Map<String, dynamic> json) =>
      _$DatumLawsFromJson(json);

  Map<String, dynamic> toJson() => _$DatumLawsToJson(this);
}

@JsonSerializable()
class PurpleDatum {
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
  DatumLawGuide? lawGuide;

  PurpleDatum({
    this.id,
    this.name,
    this.nameEn,
    this.law,
    this.lawEn,
    this.changes,
    this.changesEn,
    this.lawGuide,
  });

  factory PurpleDatum.fromJson(Map<String, dynamic> json) =>
      _$PurpleDatumFromJson(json);

  Map<String, dynamic> toJson() => _$PurpleDatumToJson(this);
}

@JsonSerializable()
class DatumLawGuide {
  @JsonKey(name: "id")
  int? id;
  @JsonKey(name: "name")
  String? name;
  @JsonKey(name: "name_en")
  String? nameEn;
  @JsonKey(name: "released_at")
  DateTime? releasedAt;
  @JsonKey(name: "published_at")
  DateTime? publishedAt;
  @JsonKey(name: "released_at_hijri")
  DateTime? releasedAtHijri;
  @JsonKey(name: "published_at_hijri")
  DateTime? publishedAtHijri;
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

  DatumLawGuide({
    this.id,
    this.name,
    this.nameEn,
    this.releasedAt,
    this.publishedAt,
    this.releasedAtHijri,
    this.publishedAtHijri,
    this.status,
    this.releaseTool,
    this.releaseToolEn,
    this.numberOfChapters,
    this.count,
    this.lawGuideMainCategory,
  });

  factory DatumLawGuide.fromJson(Map<String, dynamic> json) =>
      _$DatumLawGuideFromJson(json);

  Map<String, dynamic> toJson() => _$DatumLawGuideToJson(this);
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

@JsonSerializable()
class LawGuideMainCategories {
  @JsonKey(name: "data")
  List<LawGuideMainCategoriesDatum>? data;
  @JsonKey(name: "total")
  int? total;
  @JsonKey(name: "per_page")
  int? perPage;
  @JsonKey(name: "current_page")
  int? currentPage;
  @JsonKey(name: "last_page")
  int? lastPage;

  LawGuideMainCategories({
    this.data,
    this.total,
    this.perPage,
    this.currentPage,
    this.lastPage,
  });

  factory LawGuideMainCategories.fromJson(Map<String, dynamic> json) =>
      _$LawGuideMainCategoriesFromJson(json);

  Map<String, dynamic> toJson() => _$LawGuideMainCategoriesToJson(this);
}

@JsonSerializable()
class LawGuideMainCategoriesDatum {
  @JsonKey(name: "id")
  int? id;
  @JsonKey(name: "name")
  String? name;
  @JsonKey(name: "name_en")
  String? nameEn;
  @JsonKey(name: "count")
  int? count;

  LawGuideMainCategoriesDatum({
    this.id,
    this.name,
    this.nameEn,
    this.count,
  });

  factory LawGuideMainCategoriesDatum.fromJson(Map<String, dynamic> json) =>
      _$LawGuideMainCategoriesDatumFromJson(json);

  Map<String, dynamic> toJson() => _$LawGuideMainCategoriesDatumToJson(this);
}

@JsonSerializable()
class DataLaws {
  @JsonKey(name: "data")
  List<FluffyDatum>? data;
  @JsonKey(name: "total")
  int? total;
  @JsonKey(name: "per_page")
  int? perPage;
  @JsonKey(name: "current_page")
  int? currentPage;
  @JsonKey(name: "last_page")
  int? lastPage;

  DataLaws({
    this.data,
    this.total,
    this.perPage,
    this.currentPage,
    this.lastPage,
  });

  factory DataLaws.fromJson(Map<String, dynamic> json) =>
      _$DataLawsFromJson(json);

  Map<String, dynamic> toJson() => _$DataLawsToJson(this);
}

@JsonSerializable()
class FluffyDatum {
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
  DatumLawGuide? lawGuide;

  FluffyDatum({
    this.id,
    this.name,
    this.nameEn,
    this.law,
    this.lawEn,
    this.changes,
    this.changesEn,
    this.lawGuide,
  });

  factory FluffyDatum.fromJson(Map<String, dynamic> json) =>
      _$FluffyDatumFromJson(json);

  Map<String, dynamic> toJson() => _$FluffyDatumToJson(this);
}

@JsonSerializable()
class RelatedLawGuides {
  @JsonKey(name: "data")
  List<RelatedLawGuidesDatum>? data;
  @JsonKey(name: "total")
  int? total;
  @JsonKey(name: "per_page")
  int? perPage;
  @JsonKey(name: "current_page")
  int? currentPage;
  @JsonKey(name: "last_page")
  int? lastPage;

  RelatedLawGuides({
    this.data,
    this.total,
    this.perPage,
    this.currentPage,
    this.lastPage,
  });

  factory RelatedLawGuides.fromJson(Map<String, dynamic> json) =>
      _$RelatedLawGuidesFromJson(json);

  Map<String, dynamic> toJson() => _$RelatedLawGuidesToJson(this);
}

@JsonSerializable()
class RelatedLawGuidesDatum {
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

  RelatedLawGuidesDatum({
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

  factory RelatedLawGuidesDatum.fromJson(Map<String, dynamic> json) =>
      _$RelatedLawGuidesDatumFromJson(json);

  Map<String, dynamic> toJson() => _$RelatedLawGuidesDatumToJson(this);
}
