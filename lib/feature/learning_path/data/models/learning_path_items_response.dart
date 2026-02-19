class LearningPathItemsResponse {
  final bool status;
  final int code;
  final String message;
  final LearningPathItemsData data;

  LearningPathItemsResponse({
    required this.status,
    required this.code,
    required this.message,
    required this.data,
  });

  factory LearningPathItemsResponse.fromJson(Map<String, dynamic> json) {
    return LearningPathItemsResponse(
      status: json['status'] ?? false,
      code: json['code'] ?? 0,
      message: json['message'] ?? '',
      data: LearningPathItemsData.fromJson(json['data'] ?? {}),
    );
  }
}

class LearningPathItemsData {
  final List<PathItem> items;
  final PathAnalytics analytics;

  LearningPathItemsData({
    required this.items,
    required this.analytics,
  });

  factory LearningPathItemsData.fromJson(Map<String, dynamic> json) {
    return LearningPathItemsData(
      items: (json['items'] as List?)
              ?.map((e) => PathItem.fromJson(e))
              .toList() ??
          [],
      analytics: PathAnalytics.fromJson(json['analytics'] ?? {}),
    );
  }
}

class PathItem {
  final String type;
  final SubcategoryDetails subcategory;
  final List<ItemDetails> items;

  PathItem({
    required this.type,
    required this.subcategory,
    required this.items,
  });

  factory PathItem.fromJson(Map<String, dynamic> json) {
    return PathItem(
      type: json['type'] ?? '',
      subcategory: SubcategoryDetails.fromJson(json['subcategory'] ?? {}),
      items: (json['items'] as List?)
              ?.map((e) => ItemDetails.fromJson(e))
              .toList() ??
          [],
    );
  }
}

class SubcategoryDetails {
  final int id;
  final String name;
  final String? nameEn;
  final String? wordFile;
  final String? pdfFile;
  final String releasedAt;
  final String publishedAt;
  final String releasedAtHijri;
  final String publishedAtHijri;
  final String about;
  final int status;
  final String releaseTool;
  final CategoryInfo category;

  SubcategoryDetails({
    required this.id,
    required this.name,
    this.nameEn,
    this.wordFile,
    this.pdfFile,
    required this.releasedAt,
    required this.publishedAt,
    required this.releasedAtHijri,
    required this.publishedAtHijri,
    required this.about,
    required this.status,
    required this.releaseTool,
    required this.category,
  });

  factory SubcategoryDetails.fromJson(Map<String, dynamic> json) {
    final categoryKey = json['bookGuideCategory'] != null ? 'bookGuideCategory' : 'lawGuideMainCategory';
    
    return SubcategoryDetails(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      nameEn: json['name_en'],
      wordFile: json['word_file'],
      pdfFile: json['pdf_file'],
      releasedAt: json['released_at'] ?? '',
      publishedAt: json['published_at'] ?? '',
      releasedAtHijri: json['released_at_hijri'] ?? '',
      publishedAtHijri: json['published_at_hijri'] ?? '',
      about: json['about'] ?? '',
      status: json['status'] is int ? json['status'] : int.tryParse(json['status']?.toString() ?? '0') ?? 0,
      releaseTool: json['release_tool'] ?? '',
      category: CategoryInfo.fromJson(json[categoryKey] ?? {}),
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

class ItemDetails {
  final int id;
  final String name;
   bool locked;
  final int mandatory;
   bool alreadyDone;
  final int learningPathItemId;
  final int order;
   bool isFavourite;

  ItemDetails({
    required this.id,
    required this.name,
    required this.locked,
    required this.mandatory,
    required this.alreadyDone,
    required this.learningPathItemId,
    required this.order,
    this.isFavourite = false,
  });

  factory ItemDetails.fromJson(Map<String, dynamic> json) {
    return ItemDetails(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      locked: json['locked'] ?? false,
      mandatory: json['mandatory'] ?? 0,
      alreadyDone: json['alreadyDone'] ?? false,
      learningPathItemId: json['learning_path_item_id'] ?? 0,
      order: json['order'] ?? 0,
      isFavourite: json['is_favourite'] ?? false,
    );
  }
}

class PathAnalytics {
  final int totalItems;
  final int readItems;
  final int learnedItems;
  final int notDoneItems;
  final int totalSubCategories;
  final int doneSubCategories;
  final int notDoneSubCategories;
  final int totalFavourite;
  final int lawGuidesFavourite;
  final int bookGuidesFavourite;

  PathAnalytics({
    required this.totalItems,
    required this.readItems,
    required this.learnedItems,
    required this.notDoneItems,
    required this.totalSubCategories,
    required this.doneSubCategories,
    required this.notDoneSubCategories,
    this.totalFavourite = 0,
    this.lawGuidesFavourite = 0,
    this.bookGuidesFavourite = 0,
  });

  factory PathAnalytics.fromJson(Map<String, dynamic> json) {
    return PathAnalytics(
      totalItems: json['total_items'] ?? 0,
      readItems: json['done_items'] ?? 0,
      learnedItems: json['learned_items'] ?? 0,
      notDoneItems: json['not_done_items'] ?? 0,
      totalSubCategories: json['total_subcategories'] ?? 0,
      doneSubCategories: json['done_subcategories'] ?? 0,
      notDoneSubCategories: json['not_done_subcategories'] ?? 0,
      totalFavourite: json['total_favourite'] ?? 0,
      lawGuidesFavourite: json['law_guides_favourite'] ?? 0,
      bookGuidesFavourite: json['book_guides_favourite'] ?? 0,
    );
  }
} 
