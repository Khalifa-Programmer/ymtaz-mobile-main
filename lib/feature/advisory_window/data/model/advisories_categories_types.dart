import 'package:json_annotation/json_annotation.dart';

part 'advisories_categories_types.g.dart';

@JsonSerializable()
class AdvisoriesCategoriesTypes {
  @JsonKey(name: "status")
  bool? status;
  @JsonKey(name: "code")
  int? code;
  @JsonKey(name: "message")
  String? message;
  @JsonKey(name: "data")
  Data? data;

  AdvisoriesCategoriesTypes({
    this.status,
    this.code,
    this.message,
    this.data,
  });

  factory AdvisoriesCategoriesTypes.fromJson(Map<String, dynamic> json) =>
      _$AdvisoriesCategoriesTypesFromJson(json);

  Map<String, dynamic> toJson() => _$AdvisoriesCategoriesTypesToJson(this);
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
  @JsonKey(name: "name")
  String? name;
  @JsonKey(name: "description")
  dynamic description;
  @JsonKey(name: "requires_appointment")
  int? requiresAppointment;

  Item({
    this.id,
    this.name,
    this.description,
    this.requiresAppointment,
  });

  factory Item.fromJson(Map<String, dynamic> json) => _$ItemFromJson(json);

  Map<String, dynamic> toJson() => _$ItemToJson(this);
}
