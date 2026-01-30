// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'law_guide_search_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LawGuideSearchResponse _$LawGuideSearchResponseFromJson(
        Map<String, dynamic> json) =>
    LawGuideSearchResponse(
      status: json['status'] as bool?,
      code: (json['code'] as num?)?.toInt(),
      message: json['message'] as String?,
      data: json['data'] == null
          ? null
          : Data.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$LawGuideSearchResponseToJson(
        LawGuideSearchResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'code': instance.code,
      'message': instance.message,
      'data': instance.data,
    };

Data _$DataFromJson(Map<String, dynamic> json) => Data(
      lawGuideMainCategories: json['lawGuideMainCategories'] == null
          ? null
          : LawGuideMainCategories.fromJson(
              json['lawGuideMainCategories'] as Map<String, dynamic>),
      lawGuide: json['lawGuide'] == null
          ? null
          : DataLawGuide.fromJson(json['lawGuide'] as Map<String, dynamic>),
      laws: json['laws'] == null
          ? null
          : DataLaws.fromJson(json['laws'] as Map<String, dynamic>),
      relatedLawGuides: json['relatedLawGuides'] == null
          ? null
          : RelatedLawGuides.fromJson(
              json['relatedLawGuides'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$DataToJson(Data instance) => <String, dynamic>{
      'lawGuideMainCategories': instance.lawGuideMainCategories,
      'lawGuide': instance.lawGuide,
      'laws': instance.laws,
      'relatedLawGuides': instance.relatedLawGuides,
    };

DataLawGuide _$DataLawGuideFromJson(Map<String, dynamic> json) => DataLawGuide(
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => LawGuideDatum.fromJson(e as Map<String, dynamic>))
          .toList(),
      total: (json['total'] as num?)?.toInt(),
      perPage: (json['per_page'] as num?)?.toInt(),
      currentPage: (json['current_page'] as num?)?.toInt(),
      lastPage: (json['last_page'] as num?)?.toInt(),
    );

Map<String, dynamic> _$DataLawGuideToJson(DataLawGuide instance) =>
    <String, dynamic>{
      'data': instance.data,
      'total': instance.total,
      'per_page': instance.perPage,
      'current_page': instance.currentPage,
      'last_page': instance.lastPage,
    };

LawGuideDatum _$LawGuideDatumFromJson(Map<String, dynamic> json) =>
    LawGuideDatum(
      id: (json['id'] as num?)?.toInt(),
      name: json['name'] as String?,
      nameEn: json['name_en'] as String?,
      wordFileAr: json['word_file_ar'],
      wordFileEn: json['word_file_en'],
      pdfFileAr: json['pdf_file_ar'],
      pdfFileEn: json['pdf_file_en'],
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
          : DatumLaws.fromJson(json['laws'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$LawGuideDatumToJson(LawGuideDatum instance) =>
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

DatumLaws _$DatumLawsFromJson(Map<String, dynamic> json) => DatumLaws(
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => PurpleDatum.fromJson(e as Map<String, dynamic>))
          .toList(),
      total: (json['total'] as num?)?.toInt(),
      currentPage: (json['current_page'] as num?)?.toInt(),
      perPage: (json['per_page'] as num?)?.toInt(),
      lastPage: (json['last_page'] as num?)?.toInt(),
    );

Map<String, dynamic> _$DatumLawsToJson(DatumLaws instance) => <String, dynamic>{
      'data': instance.data,
      'total': instance.total,
      'current_page': instance.currentPage,
      'per_page': instance.perPage,
      'last_page': instance.lastPage,
    };

PurpleDatum _$PurpleDatumFromJson(Map<String, dynamic> json) => PurpleDatum(
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

Map<String, dynamic> _$PurpleDatumToJson(PurpleDatum instance) =>
    <String, dynamic>{
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

LawGuideMainCategories _$LawGuideMainCategoriesFromJson(
        Map<String, dynamic> json) =>
    LawGuideMainCategories(
      data: (json['data'] as List<dynamic>?)
          ?.map((e) =>
              LawGuideMainCategoriesDatum.fromJson(e as Map<String, dynamic>))
          .toList(),
      total: (json['total'] as num?)?.toInt(),
      perPage: (json['per_page'] as num?)?.toInt(),
      currentPage: (json['current_page'] as num?)?.toInt(),
      lastPage: (json['last_page'] as num?)?.toInt(),
    );

Map<String, dynamic> _$LawGuideMainCategoriesToJson(
        LawGuideMainCategories instance) =>
    <String, dynamic>{
      'data': instance.data,
      'total': instance.total,
      'per_page': instance.perPage,
      'current_page': instance.currentPage,
      'last_page': instance.lastPage,
    };

LawGuideMainCategoriesDatum _$LawGuideMainCategoriesDatumFromJson(
        Map<String, dynamic> json) =>
    LawGuideMainCategoriesDatum(
      id: (json['id'] as num?)?.toInt(),
      name: json['name'] as String?,
      nameEn: json['name_en'] as String?,
      count: (json['count'] as num?)?.toInt(),
    );

Map<String, dynamic> _$LawGuideMainCategoriesDatumToJson(
        LawGuideMainCategoriesDatum instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'name_en': instance.nameEn,
      'count': instance.count,
    };

DataLaws _$DataLawsFromJson(Map<String, dynamic> json) => DataLaws(
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => FluffyDatum.fromJson(e as Map<String, dynamic>))
          .toList(),
      total: (json['total'] as num?)?.toInt(),
      perPage: (json['per_page'] as num?)?.toInt(),
      currentPage: (json['current_page'] as num?)?.toInt(),
      lastPage: (json['last_page'] as num?)?.toInt(),
    );

Map<String, dynamic> _$DataLawsToJson(DataLaws instance) => <String, dynamic>{
      'data': instance.data,
      'total': instance.total,
      'per_page': instance.perPage,
      'current_page': instance.currentPage,
      'last_page': instance.lastPage,
    };

FluffyDatum _$FluffyDatumFromJson(Map<String, dynamic> json) => FluffyDatum(
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

Map<String, dynamic> _$FluffyDatumToJson(FluffyDatum instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'name_en': instance.nameEn,
      'law': instance.law,
      'law_en': instance.lawEn,
      'changes': instance.changes,
      'changes_en': instance.changesEn,
      'lawGuide': instance.lawGuide,
    };

RelatedLawGuides _$RelatedLawGuidesFromJson(Map<String, dynamic> json) =>
    RelatedLawGuides(
      data: (json['data'] as List<dynamic>?)
          ?.map(
              (e) => RelatedLawGuidesDatum.fromJson(e as Map<String, dynamic>))
          .toList(),
      total: (json['total'] as num?)?.toInt(),
      perPage: (json['per_page'] as num?)?.toInt(),
      currentPage: (json['current_page'] as num?)?.toInt(),
      lastPage: (json['last_page'] as num?)?.toInt(),
    );

Map<String, dynamic> _$RelatedLawGuidesToJson(RelatedLawGuides instance) =>
    <String, dynamic>{
      'data': instance.data,
      'total': instance.total,
      'per_page': instance.perPage,
      'current_page': instance.currentPage,
      'last_page': instance.lastPage,
    };

RelatedLawGuidesDatum _$RelatedLawGuidesDatumFromJson(
        Map<String, dynamic> json) =>
    RelatedLawGuidesDatum(
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

Map<String, dynamic> _$RelatedLawGuidesDatumToJson(
        RelatedLawGuidesDatum instance) =>
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
