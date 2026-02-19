import 'package:json_annotation/json_annotation.dart';

part 'digital_guide_response.g.dart';

@JsonSerializable()
class DigitalGuideResponse {
  @JsonKey(name: "status")
  bool? status;
  @JsonKey(name: "code")
  int? code;
  @JsonKey(name: "message")
  String? message;
  @JsonKey(name: "data")
  Data? data;

  DigitalGuideResponse({
    this.status,
    this.code,
    this.message,
    this.data,
  });

  factory DigitalGuideResponse.fromJson(Map<String, dynamic> json) =>
      _$DigitalGuideResponseFromJson(json);

  Map<String, dynamic> toJson() => _$DigitalGuideResponseToJson(this);
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
  dynamic id;

  @JsonKey(name: "title")
  String? title;
  @JsonKey(name: "image")
  String? image;
  @JsonKey(name: "need_license")
  int? needLicense;
  @JsonKey(name: "lawyers_count")
  int? lawyersCount;

  Category({
    this.id,
    this.title,
    this.image,
    this.needLicense,
    this.lawyersCount,
  });

  factory Category.fromJson(Map<String, dynamic> json) =>
      _$CategoryFromJson(json);

  Map<String, dynamic> toJson() => _$CategoryToJson(this);
}
