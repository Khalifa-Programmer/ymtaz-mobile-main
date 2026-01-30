class LearningProgressResponse {
  final bool status;
  final int code;
  final String message;
  final ProgressData data;

  LearningProgressResponse({
    required this.status,
    required this.code,
    required this.message,
    required this.data,
  });

  factory LearningProgressResponse.fromJson(Map<String, dynamic> json) {
    return LearningProgressResponse(
      status: json['status'] ?? false,
      code: json['code'] ?? 0,
      message: json['message'] ?? '',
      data: ProgressData.fromJson(json['data'] ?? {}),
    );
  }
}

class ProgressData {
  final Progress progress;

  ProgressData({required this.progress});

  factory ProgressData.fromJson(Map<String, dynamic> json) {
    return ProgressData(
      progress: Progress.fromJson(json['progress'] ?? {}),
    );
  }
}

class Progress {
  final String learningPathItemId;
  final String type;
  final String accountId;
  final String updatedAt;
  final String createdAt;
  final int id;

  Progress({
    required this.learningPathItemId,
    required this.type,
    required this.accountId,
    required this.updatedAt,
    required this.createdAt,
    required this.id,
  });

  factory Progress.fromJson(Map<String, dynamic> json) {
    return Progress(
      learningPathItemId: json['learning_path_items']?.toString() ?? '',
      type: json['type'] ?? '',
      accountId: json['account_id'] ?? '',
      updatedAt: json['updated_at'] ?? '',
      createdAt: json['created_at'] ?? '',
      id: json['id'] ?? 0,
    );
  }
} 