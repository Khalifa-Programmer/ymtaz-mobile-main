import 'package:json_annotation/json_annotation.dart';

part 'advisory_main_category_response.g.dart';

@JsonSerializable()
class AdvisoryMainCategory {
  @JsonKey(name: "status")
  bool? status;
  @JsonKey(name: "code")
  int? code;
  @JsonKey(name: "message")
  String? message;
  @JsonKey(name: "data")
  DataMainCategory? data;

  AdvisoryMainCategory({
    this.status,
    this.code,
    this.message,
    this.data,
  });

  factory AdvisoryMainCategory.fromJson(Map<String, dynamic> json) =>
      _$AdvisoryMainCategoryFromJson(json);

  Map<String, dynamic> toJson() => _$AdvisoryMainCategoryToJson(this);
}

@JsonSerializable()
class DataMainCategory {
  @JsonKey(name: "items")
  List<ItemMainCategory>? items;

  DataMainCategory({
    this.items,
  });

  factory DataMainCategory.fromJson(Map<String, dynamic> json) =>
      _$DataMainCategoryFromJson(json);

  Map<String, dynamic> toJson() => _$DataMainCategoryToJson(this);
}

@JsonSerializable()
class ItemMainCategory {
  @JsonKey(name: "id")
  int? id;
  @JsonKey(name: "title")
  String? title;

  @override
  String toString() {
    return '$title';
  }

  ItemMainCategory({
    this.id,
    this.title,
  });

  factory ItemMainCategory.fromJson(Map<String, dynamic> json) =>
      _$ItemMainCategoryFromJson(json);

  Map<String, dynamic> toJson() => _$ItemMainCategoryToJson(this);
}
