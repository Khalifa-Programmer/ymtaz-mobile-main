class BookDetailsResponse {
  final bool status;
  final int code;
  final String message;
  final BookDetailsData data;

  BookDetailsResponse({
    required this.status,
    required this.code,
    required this.message,
    required this.data,
  });

  factory BookDetailsResponse.fromJson(Map<String, dynamic> json) {
    return BookDetailsResponse(
      status: json['status'],
      code: json['code'],
      message: json['message'],
      data: BookDetailsData.fromJson(json['data']),
    );
  }
}

class BookDetailsData {
  final BookDetails book;

  BookDetailsData({required this.book});

  factory BookDetailsData.fromJson(Map<String, dynamic> json) {
    return BookDetailsData(
      book: BookDetails.fromJson(json['book']),
    );
  }
}

class BookDetails {
  final int id;
  final String name;
  final String sectionText;
  final String? changes;
  final BookGuide bookGuide;

  BookDetails({
    required this.id,
    required this.name,
    required this.sectionText,
    this.changes,
    required this.bookGuide,
  });

  factory BookDetails.fromJson(Map<String, dynamic> json) {
    return BookDetails(
      id: json['id'],
      name: json['name'],
      sectionText: json['section_text'],
      changes: json['changes'],
      bookGuide: BookGuide.fromJson(json['book_guide']),
    );
  }
}

class BookGuide {
  final int id;
  final String name;
  final String? wordFile;
  final String? pdfFile;
  final String releasedAt;
  final String publishedAt;
  final String releasedAtHijri;
  final String publishedAtHijri;
  final String about;
  final int status;
  final String releaseTool;
  final BookGuideCategory bookGuideCategory;
  final int numberOfChapters;
  final int count;

  BookGuide({
    required this.id,
    required this.name,
    this.wordFile,
    this.pdfFile,
    required this.releasedAt,
    required this.publishedAt,
    required this.releasedAtHijri,
    required this.publishedAtHijri,
    required this.about,
    required this.status,
    required this.releaseTool,
    required this.bookGuideCategory,
    required this.numberOfChapters,
    required this.count,
  });

  factory BookGuide.fromJson(Map<String, dynamic> json) {
    return BookGuide(
      id: json['id'],
      name: json['name'],
      wordFile: json['word_file'],
      pdfFile: json['pdf_file'],
      releasedAt: json['released_at'],
      publishedAt: json['published_at'],
      releasedAtHijri: json['released_at_hijri'],
      publishedAtHijri: json['published_at_hijri'],
      about: json['about'],
      status: json['status'],
      releaseTool: json['release_tool'],
      bookGuideCategory: BookGuideCategory.fromJson(json['bookGuideCategory']),
      numberOfChapters: json['number_of_chapters'],
      count: json['count'],
    );
  }
}

class BookGuideCategory {
  final int id;
  final String name;

  BookGuideCategory({
    required this.id,
    required this.name,
  });

  factory BookGuideCategory.fromJson(Map<String, dynamic> json) {
    return BookGuideCategory(
      id: json['id'],
      name: json['name'],
    );
  }
} 