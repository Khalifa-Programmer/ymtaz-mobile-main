// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'books_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BooksResponse _$BooksResponseFromJson(Map<String, dynamic> json) =>
    BooksResponse(
      status: json['status'] as bool?,
      message: json['message'] as String?,
      data: json['data'] == null
          ? null
          : Data.fromJson(json['data'] as Map<String, dynamic>),
      code: (json['code'] as num?)?.toInt(),
    );

Map<String, dynamic> _$BooksResponseToJson(BooksResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
      'data': instance.data,
      'code': instance.code,
    };

Data _$DataFromJson(Map<String, dynamic> json) => Data(
      booksMainCategories: (json['booksMainCategories'] as List<dynamic>?)
          ?.map((e) => BooksMainCategory.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$DataToJson(Data instance) => <String, dynamic>{
      'booksMainCategories': instance.booksMainCategories,
    };

BooksMainCategory _$BooksMainCategoryFromJson(Map<String, dynamic> json) =>
    BooksMainCategory(
      id: (json['id'] as num?)?.toInt(),
      name: json['name'] as String?,
      subCategories: (json['subCategories'] as List<dynamic>?)
          ?.map((e) => SubCategory.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$BooksMainCategoryToJson(BooksMainCategory instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'subCategories': instance.subCategories,
    };

SubCategory _$SubCategoryFromJson(Map<String, dynamic> json) => SubCategory(
      id: (json['id'] as num?)?.toInt(),
      name: json['name'] as String?,
      books: (json['books'] as List<dynamic>?)
          ?.map((e) => Book.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$SubCategoryToJson(SubCategory instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'books': instance.books,
    };

Book _$BookFromJson(Map<String, dynamic> json) => Book(
      id: (json['id'] as num?)?.toInt(),
      name: json['name'] as String?,
      authorName: json['author_name'] as String?,
      file: json['file'] as String?,
      subCategory: json['sub_category'] == null
          ? null
          : SubCategoryClass.fromJson(
              json['sub_category'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$BookToJson(Book instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'author_name': instance.authorName,
      'file': instance.file,
      'sub_category': instance.subCategory,
    };

SubCategoryClass _$SubCategoryClassFromJson(Map<String, dynamic> json) =>
    SubCategoryClass(
      id: (json['id'] as num?)?.toInt(),
      name: json['name'] as String?,
      mainCategory: json['main_category'] == null
          ? null
          : MainCategory.fromJson(
              json['main_category'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$SubCategoryClassToJson(SubCategoryClass instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'main_category': instance.mainCategory,
    };

MainCategory _$MainCategoryFromJson(Map<String, dynamic> json) => MainCategory(
      id: (json['id'] as num?)?.toInt(),
      name: json['name'] as String?,
    );

Map<String, dynamic> _$MainCategoryToJson(MainCategory instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
    };
