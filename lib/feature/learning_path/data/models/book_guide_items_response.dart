import 'package:yamtaz/feature/learning_path/data/models/shared_models.dart';
class BookGuideItemsResponse {
  final bool status;
  final int code;
  final String message;
  final BookGuideItemsData data;

  BookGuideItemsResponse({
    required this.status,
    required this.code,
    required this.message,
    required this.data,
  });

  factory BookGuideItemsResponse.fromJson(Map<String, dynamic> json) {
    return BookGuideItemsResponse(
      status: json['status'] == true || json['status'] == 1,
      code: json['code'] ?? 0,
      message: json['message'] ?? '',
      data: BookGuideItemsData.fromJson(json['data'] ?? {}),
    );
  }
}

class BookGuideItemsData {
  final Map<String, BookGuideCategory> bookGuideItems;
  final BookGuideAnalytics analytics;

  BookGuideItemsData({
    required this.bookGuideItems,
    required this.analytics,
  });

  factory BookGuideItemsData.fromJson(Map<String, dynamic> json) {
    final bookGuideItemsMap = <String, BookGuideCategory>{};
    
    if (json['bookGuideItems'] is Map) {
      final items = json['bookGuideItems'] as Map;
      items.forEach((key, value) {
        // تحويل المفتاح إلى String بغض النظر عن نوعه
        final stringKey = key.toString();
        if (value is Map<String, dynamic>) {
          try {
            bookGuideItemsMap[stringKey] = BookGuideCategory.fromJson(value);
          } catch (e) {
            print('Error parsing BookGuideCategory for key $stringKey: $e');
          }
        }
      });
    }

    return BookGuideItemsData(
      bookGuideItems: bookGuideItemsMap,
      analytics: BookGuideAnalytics.fromJson(json['analytics'] ?? {}),
    );
  }

  // إضافة طريقة للتحقق من البيانات
  bool get hasValidData => bookGuideItems.isNotEmpty;
}

class BookGuideCategory {
  final MainCategory mainCategory;
  final List<SubCategory> subcategories;

  BookGuideCategory({
    required this.mainCategory,
    required this.subcategories,
  });

  factory BookGuideCategory.fromJson(Map<String, dynamic> json) {
    try {
      return BookGuideCategory(
        mainCategory: MainCategory.fromJson(json['main_category'] ?? {}),
        subcategories: (json['subcategories'] as List?)
            ?.map((e) => SubCategory.fromJson(e as Map<String, dynamic>))
            .toList() ??
            [],
      );
    } catch (e) {
      print('Error parsing BookGuideCategory: $e');
      rethrow;
    }
  }
}

class BookGuideAnalytics {
  final int totalItems;
  final int doneItems;
  final int notDoneItems;
  final int readItems;
  final int learnedItems;
  final AnalyticsDetails mandatory;
  final AnalyticsDetails optional;

  BookGuideAnalytics({
    required this.totalItems,
    required this.doneItems,
    required this.notDoneItems,
    required this.readItems,
    required this.learnedItems,
    required this.mandatory,
    required this.optional,
  });

  factory BookGuideAnalytics.fromJson(Map<String, dynamic> json) {
    return BookGuideAnalytics(
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