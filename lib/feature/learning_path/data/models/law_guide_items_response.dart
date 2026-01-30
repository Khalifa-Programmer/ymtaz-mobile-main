import 'package:yamtaz/feature/learning_path/data/models/shared_models.dart';

class LawGuideItemsResponse {
  final bool status;
  final int code;
  final String message;
  final LawGuideItemsData data;

  LawGuideItemsResponse({
    required this.status,
    required this.code,
    required this.message,
    required this.data,
  });

  factory LawGuideItemsResponse.fromJson(Map<String, dynamic> json) {
    return LawGuideItemsResponse(
      status: json['status'] == true || json['status'] == 1,
      code: json['code'] ?? 0,
      message: json['message'] ?? '',
      data: LawGuideItemsData.fromJson(json['data'] ?? {}),
    );
  }
}

class LawGuideItemsData {
  final List<LawGuideCategory> lawGuideItems;
  final LawGuideAnalytics analytics;

  LawGuideItemsData({
    required this.lawGuideItems,
    required this.analytics,
  });

  factory LawGuideItemsData.fromJson(Map<String, dynamic> json) {
    return LawGuideItemsData(
      lawGuideItems: (json['lawGuideItems'] as List?)
              ?.map((e) => LawGuideCategory.fromJson(e))
              .toList() ??
          [],
      analytics: LawGuideAnalytics.fromJson(json['analytics'] ?? {}),
    );
  }
}

class LawGuideCategory {
  final MainCategory mainCategory;
  final List<SubCategory> subcategories;

  LawGuideCategory({
    required this.mainCategory,
    required this.subcategories,
  });

  factory LawGuideCategory.fromJson(Map<String, dynamic> json) {
    return LawGuideCategory(
      mainCategory: MainCategory.fromJson(json['main_category'] ?? {}),
      subcategories: (json['subcategories'] as List?)
              ?.map((e) => SubCategory.fromJson(e))
              .toList() ??
          [],
    );
  }
}

class LawGuideAnalytics {
  final int totalItems;
  final int doneItems;
  final int notDoneItems;
  final int readItems;
  final int learnedItems;
  final AnalyticsDetails mandatory;
  final AnalyticsDetails optional;

  LawGuideAnalytics({
    required this.totalItems,
    required this.doneItems,
    required this.notDoneItems,
    required this.readItems,
    required this.learnedItems,
    required this.mandatory,
    required this.optional,
  });

  factory LawGuideAnalytics.fromJson(Map<String, dynamic> json) {
    return LawGuideAnalytics(
      totalItems: json['total_items'] ?? 0,
      doneItems: json['done_items'] ?? 0,
      notDoneItems: json['not_done_items'] ?? 0,
      readItems: json['read_items'] ?? 0,
      learnedItems: json['learned_items'] ?? 0,
      mandatory: AnalyticsDetails.fromJson(json['mandatory'] ?? {}),
      optional: AnalyticsDetails.fromJson(json['optional'] ?? {}),
    );
  }
}

// ... Similar models for BookGuideItemsResponse 