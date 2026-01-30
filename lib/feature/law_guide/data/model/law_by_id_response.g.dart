// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'law_by_id_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LawByIdResponse _$LawByIdResponseFromJson(Map<String, dynamic> json) =>
    LawByIdResponse(
      status: json['status'] as bool?,
      code: (json['code'] as num?)?.toInt(),
      message: json['message'] as String?,
      data: json['data'] == null
          ? null
          : Data.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$LawByIdResponseToJson(LawByIdResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'code': instance.code,
      'message': instance.message,
      'data': instance.data,
    };

Data _$DataFromJson(Map<String, dynamic> json) => Data(
      law: json['law'] == null
          ? null
          : Law.fromJson(json['law'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$DataToJson(Data instance) => <String, dynamic>{
      'law': instance.law,
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
          : LawGuide.fromJson(json['lawGuide'] as Map<String, dynamic>),
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

LawGuide _$LawGuideFromJson(Map<String, dynamic> json) => LawGuide(
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
    )
      ..releasedAtHijri = json['released_at_hijri'] == null
          ? null
          : DateTime.parse(json['released_at_hijri'] as String)
      ..publishedAtHijri = json['published_at_hijri'] == null
          ? null
          : DateTime.parse(json['published_at_hijri'] as String);

Map<String, dynamic> _$LawGuideToJson(LawGuide instance) => <String, dynamic>{
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
