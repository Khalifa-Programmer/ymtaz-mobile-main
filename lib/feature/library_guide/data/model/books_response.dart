import 'package:json_annotation/json_annotation.dart';

part 'books_response.g.dart';

@JsonSerializable()
class BooksResponse {
  @JsonKey(name: "status")
  bool? status;
  @JsonKey(name: "message")
  String? message;
  @JsonKey(name: "data")
  Data? data;
  @JsonKey(name: "code")
  int? code;

  BooksResponse({
    this.status,
    this.message,
    this.data,
    this.code,
  });

  factory BooksResponse.fromJson(Map<String, dynamic> json) =>
      _$BooksResponseFromJson(json);

  Map<String, dynamic> toJson() => _$BooksResponseToJson(this);
}

@JsonSerializable()
class Data {
  @JsonKey(name: "booksMainCategories")
  List<BooksMainCategory>? booksMainCategories;

  Data({
    this.booksMainCategories,
  });

  factory Data.fromJson(Map<String, dynamic> json) => _$DataFromJson(json);

  Map<String, dynamic> toJson() => _$DataToJson(this);
}

@JsonSerializable()
class BooksMainCategory {
  @JsonKey(name: "id")
  int? id;
  @JsonKey(name: "name")
  String? name;
  @JsonKey(name: "subCategories")
  List<SubCategory>? subCategories;

  BooksMainCategory({
    this.id,
    this.name,
    this.subCategories,
  });

  factory BooksMainCategory.fromJson(Map<String, dynamic> json) =>
      _$BooksMainCategoryFromJson(json);

  Map<String, dynamic> toJson() => _$BooksMainCategoryToJson(this);
}

@JsonSerializable()
class SubCategory {
  @JsonKey(name: "id")
  int? id;
  @JsonKey(name: "name")
  String? name;
  @JsonKey(name: "books")
  List<Book>? books;

  SubCategory({
    this.id,
    this.name,
    this.books,
  });

  factory SubCategory.fromJson(Map<String, dynamic> json) =>
      _$SubCategoryFromJson(json);

  Map<String, dynamic> toJson() => _$SubCategoryToJson(this);
}

@JsonSerializable()
class Book {
  @JsonKey(name: "id")
  int? id;
  @JsonKey(name: "name")
  String? name;
  @JsonKey(name: "author_name")
  String? authorName;
  @JsonKey(name: "file")
  String? file;
  @JsonKey(name: "sub_category")
  SubCategoryClass? subCategory;

  Book({
    this.id,
    this.name,
    this.authorName,
    this.file,
    this.subCategory,
  });

  factory Book.fromJson(Map<String, dynamic> json) => _$BookFromJson(json);

  Map<String, dynamic> toJson() => _$BookToJson(this);
}

@JsonSerializable()
class SubCategoryClass {
  @JsonKey(name: "id")
  int? id;
  @JsonKey(name: "name")
  String? name;
  @JsonKey(name: "main_category")
  MainCategory? mainCategory;

  SubCategoryClass({
    this.id,
    this.name,
    this.mainCategory,
  });

  factory SubCategoryClass.fromJson(Map<String, dynamic> json) =>
      _$SubCategoryClassFromJson(json);

  Map<String, dynamic> toJson() => _$SubCategoryClassToJson(this);
}

@JsonSerializable()
class MainCategory {
  @JsonKey(name: "id")
  int? id;
  @JsonKey(name: "name")
  String? name;

  MainCategory({
    this.id,
    this.name,
  });

  factory MainCategory.fromJson(Map<String, dynamic> json) =>
      _$MainCategoryFromJson(json);

  Map<String, dynamic> toJson() => _$MainCategoryToJson(this);
}
