import 'law_guide_items_response.dart';

class LawDetailsResponse {
  final bool status;
  final int code;
  final String message;
  final LawDetailsData data;

  LawDetailsResponse({
    required this.status,
    required this.code,
    required this.message,
    required this.data,
  });

  factory LawDetailsResponse.fromJson(Map<String, dynamic> json) {
    return LawDetailsResponse(
      status: json['status'] ?? false,
      code: json['code'] ?? 0,
      message: json['message'] ?? '',
      data: LawDetailsData.fromJson(json['data'] ?? {}),
    );
  }
}

class LawDetailsData {
  final LawDetails law;

  LawDetailsData({required this.law});

  factory LawDetailsData.fromJson(Map<String, dynamic> json) {
    return LawDetailsData(
      law: LawDetails.fromJson(json['law'] ?? {}),
    );
  }
}

class LawDetails {
  final int id;
  final String name;
  final String nameEn;
  final String law;
  final String lawEn;
  final String? changes;
  final String changesEn;
  final LawGuideInfo lawGuide;

  LawDetails({
    required this.id,
    required this.name,
    required this.nameEn,
    required this.law,
    required this.lawEn,
    this.changes,
    required this.changesEn,
    required this.lawGuide,
  });

  factory LawDetails.fromJson(Map<String, dynamic> json) {
    return LawDetails(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      nameEn: json['name_en'] ?? '',
      law: json['law'] ?? '',
      lawEn: json['law_en'] ?? '',
      changes: json['changes'],
      changesEn: json['changes_en'] ?? '',
      lawGuide: LawGuideInfo.fromJson(json['lawGuide'] ?? {}),
    );
  }
}

class LawGuideInfo {
  final int id;
  final String name;
  final String nameEn;
  final String releasedAt;
  final String publishedAt;
  final String releasedAtHijri;
  final String publishedAtHijri;
  final String status;
  final String releaseTool;
  final String releaseToolEn;
  final int numberOfChapters;
  final int count;
  final LawGuideCategory lawGuideMainCategory;

  LawGuideInfo({
    required this.id,
    required this.name,
    required this.nameEn,
    required this.releasedAt,
    required this.publishedAt,
    required this.releasedAtHijri,
    required this.publishedAtHijri,
    required this.status,
    required this.releaseTool,
    required this.releaseToolEn,
    required this.numberOfChapters,
    required this.count,
    required this.lawGuideMainCategory,
  });

  factory LawGuideInfo.fromJson(Map<String, dynamic> json) {
    return LawGuideInfo(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      nameEn: json['name_en'] ?? '',
      releasedAt: json['released_at'] ?? '',
      publishedAt: json['published_at'] ?? '',
      releasedAtHijri: json['released_at_hijri'] ?? '',
      publishedAtHijri: json['published_at_hijri'] ?? '',
      status: json['status'] ?? '',
      releaseTool: json['release_tool'] ?? '',
      releaseToolEn: json['release_tool_en'] ?? '',
      numberOfChapters: json['number_of_chapters'] ?? 0,
      count: json['count'] ?? 0,
      lawGuideMainCategory: LawGuideCategory.fromJson(json['lawGuideMainCategory'] ?? {}),
    );
  }
} 
