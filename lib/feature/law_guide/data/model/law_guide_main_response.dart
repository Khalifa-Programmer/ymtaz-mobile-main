import 'package:json_annotation/json_annotation.dart';

part 'law_guide_main_response.g.dart';

@JsonSerializable()
class LawGuideMainResponse {
  @JsonKey(name: "status")
  bool? status;
  @JsonKey(name: "code")
  int? code;
  @JsonKey(name: "message")
  String? message;
  @JsonKey(name: "data")
  Data? data;

  LawGuideMainResponse({
    this.status,
    this.code,
    this.message,
    this.data,
  });

  factory LawGuideMainResponse.fromJson(Map<String, dynamic> json) =>
      _$LawGuideMainResponseFromJson(json);

  Map<String, dynamic> toJson() => _$LawGuideMainResponseToJson(this);
}

@JsonSerializable()
class Data {
  @JsonKey(name: "mainCategories")
  List<MainCategory>? mainCategories;

  Data({
    this.mainCategories,
  });

  factory Data.fromJson(Map<String, dynamic> json) => _$DataFromJson(json);

  Map<String, dynamic> toJson() => _$DataToJson(this);
}

@JsonSerializable()
class MainCategory {
  @JsonKey(name: "id")
  int? id;
  @JsonKey(name: "name")
  String? name;
  @JsonKey(name: "name_en")
  String? nameEn;
  @JsonKey(name: "count")
  int? count;

  MainCategory({
    this.id,
    this.name,
    this.nameEn,
    this.count,
  });

  factory MainCategory.fromJson(Map<String, dynamic> json) =>
      _$MainCategoryFromJson(json);

  Map<String, dynamic> toJson() => _$MainCategoryToJson(this);
}
