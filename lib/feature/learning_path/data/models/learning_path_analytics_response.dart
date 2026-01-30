class LearningPathAnalyticsResponse {
  final bool status;
  final int code;
  final String message;
  final LearningPathAnalyticsData data;

  LearningPathAnalyticsResponse({
    required this.status,
    required this.code,
    required this.message,
    required this.data,
  });

  factory LearningPathAnalyticsResponse.fromJson(Map<String, dynamic> json) {
    return LearningPathAnalyticsResponse(
      status: json['status'] ?? false,
      code: json['code'] ?? 0,
      message: json['message'] ?? '',
      data: LearningPathAnalyticsData.fromJson(json['data'] ?? {}),
    );
  }
}

class LearningPathAnalyticsData {
  final List<PathAnalytics> analytics;

  LearningPathAnalyticsData({required this.analytics});

  factory LearningPathAnalyticsData.fromJson(Map<String, dynamic> json) {
    return LearningPathAnalyticsData(
      analytics: (json['analytics'] as List?)
              ?.map((e) => PathAnalytics.fromJson(e))
              .toList() ??
          [],
    );
  }
}

class PathAnalytics {
  final int pathId;
  final String title;
  final int totalItems;
  final int doneItems;
  final int notDoneItems;
  final int readItems;
  final int learnedItems;
  final int doneLawGuides;
  final int undoneLawGuides;
  final int doneBookGuides;
  final int undoneBookGuides;

  PathAnalytics({
    required this.pathId,
    required this.title,
    required this.totalItems,
    required this.doneItems,
    required this.notDoneItems,
    required this.readItems,
    required this.learnedItems,
    required this.doneLawGuides,
    required this.undoneLawGuides,
    required this.doneBookGuides,
    required this.undoneBookGuides,
  });

  factory PathAnalytics.fromJson(Map<String, dynamic> json) {
    return PathAnalytics(
      pathId: json['path_id'] ?? 0,
      title: json['title'] ?? '',
      totalItems: json['total_items'] ?? 0,
      doneItems: json['done_items'] ?? 0,
      notDoneItems: json['not_done_items'] ?? 0,
      readItems: json['read_items'] ?? 0,
      learnedItems: json['learned_items'] ?? 0,
      doneLawGuides: json['done_law_guides'] ?? 0,
      undoneLawGuides: json['undone_law_guides'] ?? 0,
      doneBookGuides: json['done_book_guides'] ?? 0,
      undoneBookGuides: json['undone_book_guides'] ?? 0,
    );
  }
} 