class LearningPathsResponse {
  final bool status;
  final int code;
  final String message;
  final LearningPathsData data;

  LearningPathsResponse({
    required this.status,
    required this.code,
    required this.message,
    required this.data,
  });

  factory LearningPathsResponse.fromJson(Map<String, dynamic> json) {
    return LearningPathsResponse(
      status: json['status'] ?? false,
      code: json['code'] ?? 0,
      message: json['message'] ?? '',
      data: LearningPathsData.fromJson(json['data'] ?? {}),
    );
  }
}

class LearningPathsData {
  final List<LearningPath> paths;

  LearningPathsData({required this.paths});

  factory LearningPathsData.fromJson(Map<String, dynamic> json) {
    return LearningPathsData(
      paths: (json['paths'] as List?)
              ?.map((e) => LearningPath.fromJson(e))
              .toList() ??
          [],
    );
  }
}

class LearningPath {
  final int id;
  final String title;
  final List<LawGuideItem> lawGuideItems;
  final List<dynamic> bookGuideItems;

  LearningPath({
    required this.id,
    required this.title,
    required this.lawGuideItems,
    required this.bookGuideItems,
  });

  factory LearningPath.fromJson(Map<String, dynamic> json) {
    return LearningPath(
      id: json['id'] ?? 0,
      title: json['title'] ?? '',
      lawGuideItems: (json['law_guide_items'] as List?)
              ?.map((e) => LawGuideItem.fromJson(e))
              .toList() ??
          [],
      bookGuideItems: json['book_guide_items'] ?? [],
    );
  }
}

class LawGuideItem {
  final ParentItem parent;
  final List<LearningPathItem> items;

  LawGuideItem({
    required this.parent,
    required this.items,
  });

  factory LawGuideItem.fromJson(Map<String, dynamic> json) {
    return LawGuideItem(
      parent: ParentItem.fromJson(json['parent'] ?? {}),
      items: (json['items'] as List?)
              ?.map((e) => LearningPathItem.fromJson(e))
              .toList() ??
          [],
    );
  }
}

class ParentItem {
  final int id;
  final String name;
  final String nameEn;
  final String about;
  final String aboutEn;
  final String publishedAt;
  final String releasedAt;
  final String status;

  ParentItem({
    required this.id,
    required this.name,
    required this.nameEn,
    required this.about,
    required this.aboutEn,
    required this.publishedAt,
    required this.releasedAt,
    required this.status,
  });

  factory ParentItem.fromJson(Map<String, dynamic> json) {
    return ParentItem(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      nameEn: json['name_en'] ?? '',
      about: json['about'] ?? '',
      aboutEn: json['about_en'] ?? '',
      publishedAt: json['published_at'] ?? '',
      releasedAt: json['released_at'] ?? '',
      status: json['status'] ?? '',
    );
  }
}

class LearningPathItem {
  final int id;
  final String itemType;
  final int itemId;
  final int order;
  final Map<String, dynamic> item;
  final Map<String, dynamic>? progress;

  LearningPathItem({
    required this.id,
    required this.itemType,
    required this.itemId,
    required this.order,
    required this.item,
    this.progress,
  });

  factory LearningPathItem.fromJson(Map<String, dynamic> json) {
    return LearningPathItem(
      id: json['id'] ?? 0,
      itemType: json['item_type'] ?? '',
      itemId: json['item_id'] ?? 0,
      order: json['order'] ?? 0,
      item: json['item'] ?? {},
      progress: json['progress'],
    );
  }
}

// ... Add other model classes (ParentItem, LearningPathItem, etc.) 
