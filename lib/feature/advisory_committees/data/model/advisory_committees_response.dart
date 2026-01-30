import 'package:json_annotation/json_annotation.dart';

part 'advisory_committees_response.g.dart';

@JsonSerializable()
class AdvisoryCommitteesResponse {
  @JsonKey(name: "status")
  bool? status;
  @JsonKey(name: "code")
  int? code;
  @JsonKey(name: "message")
  String? message;
  @JsonKey(name: "data")
  Data? data;

  AdvisoryCommitteesResponse({
    this.status,
    this.code,
    this.message,
    this.data,
  });

  factory AdvisoryCommitteesResponse.fromJson(Map<String, dynamic> json) =>
      _$AdvisoryCommitteesResponseFromJson(json);

  Map<String, dynamic> toJson() => _$AdvisoryCommitteesResponseToJson(this);
}

@JsonSerializable()
class Data {
  @JsonKey(name: "categories")
  List<CategoryAdvisorCommitte>? categories;

  Data({
    this.categories,
  });

  factory Data.fromJson(Map<String, dynamic> json) => _$DataFromJson(json);

  Map<String, dynamic> toJson() => _$DataToJson(this);
}

@JsonSerializable()
class CategoryAdvisorCommitte {
  @JsonKey(name: "id")
  int? id;
  @JsonKey(name: "title")
  String? title;
  @JsonKey(name: "image")
  String? image;
  @JsonKey(name: "advisors_available_counts")
  int? advisorsAvailableCounts;

  CategoryAdvisorCommitte({
    this.id,
    this.title,
    this.image,
    this.advisorsAvailableCounts,
  });

  factory CategoryAdvisorCommitte.fromJson(Map<String, dynamic> json) =>
      _$CategoryAdvisorCommitteFromJson(json);

  Map<String, dynamic> toJson() => _$CategoryAdvisorCommitteToJson(this);
}
