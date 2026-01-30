import 'package:json_annotation/json_annotation.dart';

part 'advisory_types_response.g.dart';

@JsonSerializable()
class AdvisoryTypesResponse {
  @JsonKey(name: "status")
  bool? status;
  @JsonKey(name: "code")
  int? code;
  @JsonKey(name: "message")
  String? message;
  @JsonKey(name: "data")
  Data? data;

  AdvisoryTypesResponse({
    this.status,
    this.code,
    this.message,
    this.data,
  });

  factory AdvisoryTypesResponse.fromJson(Map<String, dynamic> json) =>
      _$AdvisoryTypesResponseFromJson(json);

  Map<String, dynamic> toJson() => _$AdvisoryTypesResponseToJson(this);
}

@JsonSerializable()
class Data {
  @JsonKey(name: "items")
  List<Item>? items;

  Data({
    this.items,
  });

  factory Data.fromJson(Map<String, dynamic> json) => _$DataFromJson(json);

  Map<String, dynamic> toJson() => _$DataToJson(this);
}

@JsonSerializable()
class Item {
  @JsonKey(name: "id")
  int? id;
  @JsonKey(name: "title")
  String? title;

  Item({
    this.id,
    this.title,
  });

  factory Item.fromJson(Map<String, dynamic> json) => _$ItemFromJson(json);

  Map<String, dynamic> toJson() => _$ItemToJson(this);
}
