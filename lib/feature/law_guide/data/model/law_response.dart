import 'package:json_annotation/json_annotation.dart';

part 'law_response.g.dart';

@JsonSerializable()
class LawResponse {
  @JsonKey(name: "status")
  bool? status;
  @JsonKey(name: "code")
  int? code;
  @JsonKey(name: "message")
  String? message;
  @JsonKey(name: "data")
  Data? data;

  LawResponse({
    this.status,
    this.code,
    this.message,
    this.data,
  });

  factory LawResponse.fromJson(Map<String, dynamic> json) =>
      _$LawResponseFromJson(json);

  Map<String, dynamic> toJson() => _$LawResponseToJson(this);

  // copy with
  LawResponse copyWith({
    bool? status,
    int? code,
    String? message,
    Data? data,
  }) {
    return LawResponse(
      status: status ?? this.status,
      code: code ?? this.code,
      message: message ?? this.message,
      data: data ?? this.data,
    );
  }
}

@JsonSerializable()
class Data {
  @JsonKey(name: "lawGuide")
  DataLawGuide? lawGuide;

  Data({
    this.lawGuide,
  });

  factory Data.fromJson(Map<String, dynamic> json) => _$DataFromJson(json);

  Map<String, dynamic> toJson() => _$DataToJson(this);

  // copy with
  Data copyWith({
    DataLawGuide? lawGuide,
  }) {
    return Data(
      lawGuide: lawGuide ?? this.lawGuide,
    );
  }
}

@JsonSerializable()
class DataLawGuide {
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
  @JsonKey(name: "laws")
  Laws? laws;

  DataLawGuide({
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

  factory DataLawGuide.fromJson(Map<String, dynamic> json) =>
      _$DataLawGuideFromJson(json);

  Map<String, dynamic> toJson() => _$DataLawGuideToJson(this);

  // copy with
  DataLawGuide copyWith({
    int? id,
    String? name,
    String? nameEn,
    dynamic wordFileAr,
    dynamic wordFileEn,
    String? pdfFileAr,
    String? pdfFileEn,
    DateTime? releasedAt,
    DateTime? publishedAt,
    DateTime? releasedAtHijri,
    DateTime? publishedAtHijri,
    String? about,
    String? aboutEn,
    String? status,
    String? releaseTool,
    String? releaseToolEn,
    int? numberOfChapters,
    int? count,
    Laws? laws,
  }) {
    return DataLawGuide(
      id: id ?? this.id,
      name: name ?? this.name,
      nameEn: nameEn ?? this.nameEn,
      wordFileAr: wordFileAr ?? this.wordFileAr,
      wordFileEn: wordFileEn ?? this.wordFileEn,
      pdfFileAr: pdfFileAr ?? this.pdfFileAr,
      pdfFileEn: pdfFileEn ?? this.pdfFileEn,
      releasedAt: releasedAt ?? this.releasedAt,
      publishedAt: publishedAt ?? this.publishedAt,
      releasedAtHijri: releasedAtHijri ?? this.releasedAtHijri,
      publishedAtHijri: publishedAtHijri ?? this.publishedAtHijri,
      about: about ?? this.about,
      aboutEn: aboutEn ?? this.aboutEn,
      status: status ?? this.status,
      releaseTool: releaseTool ?? this.releaseTool,
      releaseToolEn: releaseToolEn ?? this.releaseToolEn,
      numberOfChapters: numberOfChapters ?? this.numberOfChapters,
      count: count ?? this.count,
      laws: laws ?? this.laws,
    );
  }
}

@JsonSerializable()
class Laws {
  @JsonKey(name: "data")
  List<Datum>? data;
  @JsonKey(name: "total")
  int? total;
  @JsonKey(name: "current_page")
  int? currentPage;
  @JsonKey(name: "per_page")
  int? perPage;
  @JsonKey(name: "last_page")
  int? lastPage;

  Laws({
    this.data,
    this.total,
    this.currentPage,
    this.perPage,
    this.lastPage,
  });

  factory Laws.fromJson(Map<String, dynamic> json) => _$LawsFromJson(json);

  Map<String, dynamic> toJson() => _$LawsToJson(this);

  // copy with
  Laws copyWith({
    List<Datum>? data,
    int? total,
    int? currentPage,
    int? perPage,
    int? lastPage,
  }) {
    return Laws(
      data: data ?? this.data,
      total: total ?? this.total,
      currentPage: currentPage ?? this.currentPage,
      perPage: perPage ?? this.perPage,
      lastPage: lastPage ?? this.lastPage,
    );
  }
}

@JsonSerializable()
class Datum {
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

  Datum({
    this.id,
    this.name,
    this.nameEn,
    this.law,
    this.lawEn,
    this.changes,
    this.changesEn,
    this.lawGuide,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => _$DatumFromJson(json);

  Map<String, dynamic> toJson() => _$DatumToJson(this);

  // copy with
  Datum copyWith({
    int? id,
    String? name,
    String? nameEn,
    String? law,
    String? lawEn,
    String? changes,
    String? changesEn,
    DatumLawGuide? lawGuide,
  }) {
    return Datum(
      id: id ?? this.id,
      name: name ?? this.name,
      nameEn: nameEn ?? this.nameEn,
      law: law ?? this.law,
      lawEn: lawEn ?? this.lawEn,
      changes: changes ?? this.changes,
      changesEn: changesEn ?? this.changesEn,
      lawGuide: lawGuide ?? this.lawGuide,
    );
  }
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

  // copy with
  DatumLawGuide copyWith({
    int? id,
    String? name,
    String? nameEn,
    DateTime? releasedAt,
    DateTime? publishedAt,
    DateTime? releasedAtHijri,
    DateTime? publishedAtHijri,
    String? status,
    String? releaseTool,
    String? releaseToolEn,
    int? numberOfChapters,
    int? count,
    LawGuideMainCategory? lawGuideMainCategory,
  }) {
    return DatumLawGuide(
      id: id ?? this.id,
      name: name ?? this.name,
      nameEn: nameEn ?? this.nameEn,
      releasedAt: releasedAt ?? this.releasedAt,
      publishedAt: publishedAt ?? this.publishedAt,
      releasedAtHijri: releasedAtHijri ?? this.releasedAtHijri,
      publishedAtHijri: publishedAtHijri ?? this.publishedAtHijri,
      status: status ?? this.status,
      releaseTool: releaseTool ?? this.releaseTool,
      releaseToolEn: releaseToolEn ?? this.releaseToolEn,
      numberOfChapters: numberOfChapters ?? this.numberOfChapters,
      count: count ?? this.count,
      lawGuideMainCategory: lawGuideMainCategory ?? this.lawGuideMainCategory,
    );
  }
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
  LawLawGuide? lawGuide;

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

  // copy with
  Law copyWith({
    int? id,
    String? name,
    String? nameEn,
    String? law,
    String? lawEn,
    String? changes,
    String? changesEn,
    LawLawGuide? lawGuide,
  }) {
    return Law(
      id: id ?? this.id,
      name: name ?? this.name,
      nameEn: nameEn ?? this.nameEn,
      law: law ?? this.law,
      lawEn: lawEn ?? this.lawEn,
      changes: changes ?? this.changes,
      changesEn: changesEn ?? this.changesEn,
      lawGuide: lawGuide ?? this.lawGuide,
    );
  }
}

@JsonSerializable()
class LawLawGuide {
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

  LawLawGuide({
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

  factory LawLawGuide.fromJson(Map<String, dynamic> json) =>
      _$LawLawGuideFromJson(json);

  Map<String, dynamic> toJson() => _$LawLawGuideToJson(this);
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

  // copy with
  LawGuideMainCategory copyWith({
    int? id,
    String? name,
  }) {
    return LawGuideMainCategory(
      id: id ?? this.id,
      name: name ?? this.name,
    );
  }
}
