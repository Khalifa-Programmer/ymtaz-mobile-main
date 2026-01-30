import 'package:json_annotation/json_annotation.dart';

part 'elite_category_model.g.dart';

@JsonSerializable()
class EliteCategoryModel {
  @JsonKey(name: "status")
  String? status;
  @JsonKey(name: "code")
  int? code;
  @JsonKey(name: "message")
  String? message;
  @JsonKey(name: "data")
  Data? data;

  EliteCategoryModel({
    this.status,
    this.code,
    this.message,
    this.data,
  });

  factory EliteCategoryModel.fromJson(Map<String, dynamic> json) =>
      _$EliteCategoryModelFromJson(json);

  Map<String, dynamic> toJson() => _$EliteCategoryModelToJson(this);
}

@JsonSerializable()
class Data {
  @JsonKey(name: "categories")
  List<Category>? categories;

  Data({
    this.categories,
  });

  factory Data.fromJson(Map<String, dynamic> json) => _$DataFromJson(json);

  Map<String, dynamic> toJson() => _$DataToJson(this);
}

@JsonSerializable()
class Category {
  @JsonKey(name: "id")
  int? id;
  @JsonKey(name: "name")
  String? name;

  Category({
    this.id,
    this.name,
  });

  factory Category.fromJson(Map<String, dynamic> json) =>
      _$CategoryFromJson(json);

  Map<String, dynamic> toJson() => _$CategoryToJson(this);
}
