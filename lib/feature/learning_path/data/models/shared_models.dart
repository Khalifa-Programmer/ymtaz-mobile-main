class MainCategory {
  final int id;
  final String name;
  final String? nameEn;

  MainCategory({
    required this.id,
    required this.name,
    this.nameEn,
  });

  factory MainCategory.fromJson(Map<String, dynamic> json) {
    final id = json['id'] is String ? int.parse(json['id']) : json['id'] ?? 0;
    
    return MainCategory(
      id: id,
      name: json['name']?.toString() ?? '',
      nameEn: json['name_en']?.toString(),
    );
  }
}

class SubCategory {
  final SubCategoryDetails subcategory;
  final List<SubCategoryItem> items;

  SubCategory({
    required this.subcategory,
    required this.items,
  });

  factory SubCategory.fromJson(Map<String, dynamic> json) {
    return SubCategory(
      subcategory: SubCategoryDetails.fromJson(json['subcategory'] ?? {}),
      items: (json['items'] as List?)
              ?.map((e) => SubCategoryItem.fromJson(e))
              .toList() ??
          [],
    );
  }
}

class SubCategoryDetails {
  final int id;
  final String name;
  final String? nameEn;
  final String? about;
  final String? aboutEn;
  final String releasedAt;
  final String publishedAt;
  final dynamic status;

  SubCategoryDetails({
    required this.id,
    required this.name,
    this.nameEn,
    this.about,
    this.aboutEn,
    required this.releasedAt,
    required this.publishedAt,
    required this.status,
  });

  factory SubCategoryDetails.fromJson(Map<String, dynamic> json) {
    final id = json['id'] is String ? int.parse(json['id']) : json['id'] ?? 0;
    
    return SubCategoryDetails(
      id: id,
      name: json['name']?.toString() ?? '',
      nameEn: json['name_en']?.toString(),
      about: json['about']?.toString(),
      aboutEn: json['about_en']?.toString(),
      releasedAt: json['released_at']?.toString() ?? '',
      publishedAt: json['published_at']?.toString() ?? '',
      status: json['status'],
    );
  }
}

class SubCategoryItem {
  final int id;
  final String name;
  final bool locked;
  final int mandatory;
  final bool alreadyDone;
  final int learningPathItemId;

  SubCategoryItem({
    required this.id,
    required this.name,
    required this.locked,
    required this.mandatory,
    required this.alreadyDone,
    required this.learningPathItemId,
  });

  factory SubCategoryItem.fromJson(Map<String, dynamic> json) {
    return SubCategoryItem(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      locked: json['locked'] ?? false,
      mandatory: json['mandatory'] ?? 0,
      alreadyDone: json['alreadyDone'] ?? false,
      learningPathItemId: json['learning_path_item_id'] ?? 0,
    );
  }
}

class AnalyticsDetails {
  final int totalItems;
  final int doneItems;
  final int notDoneItems;
  final int readItems;
  final int learnedItems;

  AnalyticsDetails({
    required this.totalItems,
    required this.doneItems,
    required this.notDoneItems,
    required this.readItems,
    required this.learnedItems,
  });

  factory AnalyticsDetails.fromJson(Map<String, dynamic> json) {
    return AnalyticsDetails(
      totalItems: json['total_items'] ?? 0,
      doneItems: json['done_items'] ?? 0,
      notDoneItems: json['not_done_items'] ?? 0,
      readItems: json['read_items'] ?? 0,
      learnedItems: json['learned_items'] ?? 0,
    );
  }
} 
