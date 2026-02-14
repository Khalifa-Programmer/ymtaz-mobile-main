class FavouriteItemsResponse {
  final bool status;
  final int code;
  final String message;
  final FavouriteItemsData data;

  FavouriteItemsResponse({
    required this.status,
    required this.code,
    required this.message,
    required this.data,
  });

  factory FavouriteItemsResponse.fromJson(Map<String, dynamic> json) {
    return FavouriteItemsResponse(
      status: json['status'] ?? false,
      code: json['code'] ?? 0,
      message: json['message'] ?? '',
      data: FavouriteItemsData.fromJson(json['data'] ?? {}),
    );
  }
}

class FavouriteItemsData {
  final List<FavouriteItem> favouriteLearningPathItems;

  FavouriteItemsData({
    required this.favouriteLearningPathItems,
  });

  factory FavouriteItemsData.fromJson(Map<String, dynamic> json) {
    return FavouriteItemsData(
      favouriteLearningPathItems: (json['favouriteLearningPathItems'] as List?)
              ?.map((e) => FavouriteItem.fromJson(e))
              .toList() ??
          [],
    );
  }
}

class FavouriteItem {
  final int id;
  final int learningPathItemId;
  final String name;
  final String type;
  final LearningPathInfo learningPath;
  final SubcategoryInfo subcategory;

  FavouriteItem({
    required this.id,
    required this.learningPathItemId,
    required this.name,
    required this.type,
    required this.learningPath,
    required this.subcategory,
  });

  factory FavouriteItem.fromJson(Map<String, dynamic> json) {
    return FavouriteItem(
      id: json['id'] ?? 0,
      learningPathItemId: json['learning_path_item_id'] ?? 0,
      name: json['name'] ?? '',
      type: json['type'] ?? '',
      learningPath: LearningPathInfo.fromJson(json['learning_path'] ?? {}),
      subcategory: SubcategoryInfo.fromJson(json['subcategory'] ?? {}),
    );
  }
}

class LearningPathInfo {
  final int id;
  final String title;

  LearningPathInfo({
    required this.id,
    required this.title,
  });

  factory LearningPathInfo.fromJson(Map<String, dynamic> json) {
    return LearningPathInfo(
      id: json['id'] ?? 0,
      title: json['title'] ?? '',
    );
  }
}

class SubcategoryInfo {
  final int id;
  final String name;
  final String nameEn;
  final String? wordFileAr;
  final String? wordFileEn;
  final String? pdfFileAr;
  final String? pdfFileEn;
  final String releasedAt;
  final String publishedAt;
  final String releasedAtHijri;
  final String publishedAtHijri;
  final String about;
  final String aboutEn;
  final String status;
  final String releaseTool;
  final String releaseToolEn;
  final CategoryInfo lawGuideMainCategory;

  SubcategoryInfo({
    required this.id,
    required this.name,
    required this.nameEn,
    this.wordFileAr,
    this.wordFileEn,
    this.pdfFileAr,
    this.pdfFileEn,
    required this.releasedAt,
    required this.publishedAt,
    required this.releasedAtHijri,
    required this.publishedAtHijri,
    required this.about,
    required this.aboutEn,
    required this.status,
    required this.releaseTool,
    required this.releaseToolEn,
    required this.lawGuideMainCategory,
  });

  factory SubcategoryInfo.fromJson(Map<String, dynamic> json) {
    return SubcategoryInfo(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      nameEn: json['name_en'] ?? '',
      wordFileAr: json['word_file_ar'],
      wordFileEn: json['word_file_en'],
      pdfFileAr: json['pdf_file_ar'],
      pdfFileEn: json['pdf_file_en'],
      releasedAt: json['released_at'] ?? '',
      publishedAt: json['published_at'] ?? '',
      releasedAtHijri: json['released_at_hijri'] ?? '',
      publishedAtHijri: json['published_at_hijri'] ?? '',
      about: json['about'] ?? '',
      aboutEn: json['about_en'] ?? '',
      status: json['status']?.toString() ?? '',
      releaseTool: json['release_tool'] ?? '',
      releaseToolEn: json['release_tool_en'] ?? '',
      lawGuideMainCategory: CategoryInfo.fromJson(json['lawGuideMainCategory'] ?? {}),
    );
  }
}

class CategoryInfo {
  final int id;
  final String name;

  CategoryInfo({
    required this.id,
    required this.name,
  });

  factory CategoryInfo.fromJson(Map<String, dynamic> json) {
    return CategoryInfo(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
    );
  }
} 
