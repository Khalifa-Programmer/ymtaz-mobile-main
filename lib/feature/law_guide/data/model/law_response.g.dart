// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'law_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LawResponse _$LawResponseFromJson(Map<String, dynamic> json) => LawResponse(
      status: json['status'] as bool?,
      code: (json['code'] as num?)?.toInt(),
      message: json['message'] as String?,
      data: json['data'] == null
          ? null
          : Data.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$LawResponseToJson(LawResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'code': instance.code,
      'message': instance.message,
      'data': instance.data,
    };

Data _$DataFromJson(Map<String, dynamic> json) => Data(
      lawGuide: json['lawGuide'] == null
          ? null
          : DataLawGuide.fromJson(json['lawGuide'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$DataToJson(Data instance) => <String, dynamic>{
      'lawGuide': instance.lawGuide,
    };

DataLawGuide _$DataLawGuideFromJson(Map<String, dynamic> json) => DataLawGuide(
      id: (json['id'] as num?)?.toInt(),
      name: json['name'] as String?,
      nameEn: json['name_en'] as String?,
      wordFileAr: json['word_file_ar'],
      wordFileEn: json['word_file_en'],
      pdfFileAr: json['pdf_file_ar'] as String?,
      pdfFileEn: json['pdf_file_en'] as String?,
      releasedAt: json['released_at'] == null
          ? null
          : DateTime.parse(json['released_at'] as String),
      publishedAt: json['published_at'] == null
          ? null
          : DateTime.parse(json['published_at'] as String),
      releasedAtHijri: json['released_at_hijri'] == null
          ? null
          : DateTime.parse(json['released_at_hijri'] as String),
      publishedAtHijri: json['published_at_hijri'] == null
          ? null
          : DateTime.parse(json['published_at_hijri'] as String),
      about: json['about'] as String?,
      aboutEn: json['about_en'] as String?,
      status: json['status'] as String?,
      releaseTool: json['release_tool'] as String?,
      releaseToolEn: json['release_tool_en'] as String?,
      numberOfChapters: (json['number_of_chapters'] as num?)?.toInt(),
      count: (json['count'] as num?)?.toInt(),
      laws: json['laws'] == null
          ? null
          : Laws.fromJson(json['laws'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$DataLawGuideToJson(DataLawGuide instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'name_en': instance.nameEn,
      'word_file_ar': instance.wordFileAr,
      'word_file_en': instance.wordFileEn,
      'pdf_file_ar': instance.pdfFileAr,
      'pdf_file_en': instance.pdfFileEn,
      'released_at': instance.releasedAt?.toIso8601String(),
      'published_at': instance.publishedAt?.toIso8601String(),
      'released_at_hijri': instance.releasedAtHijri?.toIso8601String(),
      'published_at_hijri': instance.publishedAtHijri?.toIso8601String(),
      'about': instance.about,
      'about_en': instance.aboutEn,
      'status': instance.status,
      'release_tool': instance.releaseTool,
      'release_tool_en': instance.releaseToolEn,
      'number_of_chapters': instance.numberOfChapters,
      'count': instance.count,
      'laws': instance.laws,
    };

Laws _$LawsFromJson(Map<String, dynamic> json) => Laws(
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => Datum.fromJson(e as Map<String, dynamic>))
          .toList(),
      total: (json['total'] as num?)?.toInt(),
      currentPage: (json['current_page'] as num?)?.toInt(),
      perPage: (json['per_page'] as num?)?.toInt(),
      lastPage: (json['last_page'] as num?)?.toInt(),
    );

Map<String, dynamic> _$LawsToJson(Laws instance) => <String, dynamic>{
      'data': instance.data,
      'total': instance.total,
      'current_page': instance.currentPage,
      'per_page': instance.perPage,
      'last_page': instance.lastPage,
    };

Datum _$DatumFromJson(Map<String, dynamic> json) => Datum(
      id: (json['id'] as num?)?.toInt(),
      name: json['name'] as String?,
      nameEn: json['name_en'] as String?,
      law: json['law'] as String?,
      lawEn: json['law_en'] as String?,
      changes: json['changes'] as String?,
      changesEn: json['changes_en'] as String?,
      lawGuide: json['lawGuide'] == null
          ? null
          : DatumLawGuide.fromJson(json['lawGuide'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$DatumToJson(Datum instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'name_en': instance.nameEn,
      'law': instance.law,
      'law_en': instance.lawEn,
      'changes': instance.changes,
      'changes_en': instance.changesEn,
      'lawGuide': instance.lawGuide,
    };

DatumLawGuide _$DatumLawGuideFromJson(Map<String, dynamic> json) =>
    DatumLawGuide(
      id: (json['id'] as num?)?.toInt(),
      name: json['name'] as String?,
      nameEn: json['name_en'] as String?,
      releasedAt: json['released_at'] == null
          ? null
          : DateTime.parse(json['released_at'] as String),
      publishedAt: json['published_at'] == null
          ? null
          : DateTime.parse(json['published_at'] as String),
      releasedAtHijri: json['released_at_hijri'] == null
          ? null
          : DateTime.parse(json['released_at_hijri'] as String),
      publishedAtHijri: json['published_at_hijri'] == null
          ? null
          : DateTime.parse(json['published_at_hijri'] as String),
      status: json['status'] as String?,
      releaseTool: json['release_tool'] as String?,
      releaseToolEn: json['release_tool_en'] as String?,
      numberOfChapters: (json['number_of_chapters'] as num?)?.toInt(),
      count: (json['count'] as num?)?.toInt(),
      lawGuideMainCategory: json['lawGuideMainCategory'] == null
          ? null
          : LawGuideMainCategory.fromJson(
              json['lawGuideMainCategory'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$DatumLawGuideToJson(DatumLawGuide instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'name_en': instance.nameEn,
      'released_at': instance.releasedAt?.toIso8601String(),
      'published_at': instance.publishedAt?.toIso8601String(),
      'released_at_hijri': instance.releasedAtHijri?.toIso8601String(),
      'published_at_hijri': instance.publishedAtHijri?.toIso8601String(),
      'status': instance.status,
      'release_tool': instance.releaseTool,
      'release_tool_en': instance.releaseToolEn,
      'number_of_chapters': instance.numberOfChapters,
      'count': instance.count,
      'lawGuideMainCategory': instance.lawGuideMainCategory,
    };

Law _$LawFromJson(Map<String, dynamic> json) => Law(
      id: (json['id'] as num?)?.toInt(),
      name: json['name'] as String?,
      nameEn: json['name_en'] as String?,
      law: json['law'] as String?,
      lawEn: json['law_en'] as String?,
      changes: json['changes'] as String?,
      changesEn: json['changes_en'] as String?,
      lawGuide: json['lawGuide'] == null
          ? null
          : LawLawGuide.fromJson(json['lawGuide'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$LawToJson(Law instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'name_en': instance.nameEn,
      'law': instance.law,
      'law_en': instance.lawEn,
      'changes': instance.changes,
      'changes_en': instance.changesEn,
      'lawGuide': instance.lawGuide,
    };

LawLawGuide _$LawLawGuideFromJson(Map<String, dynamic> json) => LawLawGuide(
      id: (json['id'] as num?)?.toInt(),
      name: json['name'] as String?,
      nameEn: json['name_en'] as String?,
      wordFileAr: json['word_file_ar'],
      wordFileEn: json['word_file_en'],
      pdfFileAr: json['pdf_file_ar'] as String?,
      pdfFileEn: json['pdf_file_en'] as String?,
      releasedAt: json['released_at'] == null
          ? null
          : DateTime.parse(json['released_at'] as String),
      publishedAt: json['published_at'] == null
          ? null
          : DateTime.parse(json['published_at'] as String),
      releasedAtHijri: json['released_at_hijri'] == null
          ? null
          : DateTime.parse(json['released_at_hijri'] as String),
      publishedAtHijri: json['published_at_hijri'] == null
          ? null
          : DateTime.parse(json['published_at_hijri'] as String),
      about: json['about'] as String?,
      aboutEn: json['about_en'] as String?,
      status: json['status'] as String?,
      releaseTool: json['release_tool'] as String?,
      releaseToolEn: json['release_tool_en'] as String?,
      numberOfChapters: (json['number_of_chapters'] as num?)?.toInt(),
      count: (json['count'] as num?)?.toInt(),
      lawGuideMainCategory: json['lawGuideMainCategory'] == null
          ? null
          : LawGuideMainCategory.fromJson(
              json['lawGuideMainCategory'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$LawLawGuideToJson(LawLawGuide instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'name_en': instance.nameEn,
      'word_file_ar': instance.wordFileAr,
      'word_file_en': instance.wordFileEn,
      'pdf_file_ar': instance.pdfFileAr,
      'pdf_file_en': instance.pdfFileEn,
      'released_at': instance.releasedAt?.toIso8601String(),
      'published_at': instance.publishedAt?.toIso8601String(),
      'released_at_hijri': instance.releasedAtHijri?.toIso8601String(),
      'published_at_hijri': instance.publishedAtHijri?.toIso8601String(),
      'about': instance.about,
      'about_en': instance.aboutEn,
      'status': instance.status,
      'release_tool': instance.releaseTool,
      'release_tool_en': instance.releaseToolEn,
      'number_of_chapters': instance.numberOfChapters,
      'count': instance.count,
      'lawGuideMainCategory': instance.lawGuideMainCategory,
    };

LawGuideMainCategory _$LawGuideMainCategoryFromJson(
        Map<String, dynamic> json) =>
    LawGuideMainCategory(
      id: (json['id'] as num?)?.toInt(),
      name: json['name'] as String?,
    );

Map<String, dynamic> _$LawGuideMainCategoryToJson(
        LawGuideMainCategory instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
    };
