import 'package:json_annotation/json_annotation.dart';

part 'contact_us_types.g.dart';

@JsonSerializable()
class ContactUsTypes {
  @JsonKey(name: "status")
  bool? status;
  @JsonKey(name: "message")
  String? message;
  @JsonKey(name: "data")
  Data? data;
  @JsonKey(name: "code")
  int? code;

  ContactUsTypes({
    this.status,
    this.message,
    this.data,
    this.code,
  });

  factory ContactUsTypes.fromJson(Map<String, dynamic> json) =>
      _$ContactUsTypesFromJson(json);

  Map<String, dynamic> toJson() => _$ContactUsTypesToJson(this);
}

@JsonSerializable()
class Data {
  @JsonKey(name: "contactTypes")
  List<ContactType>? contactTypes;

  Data({
    this.contactTypes,
  });

  factory Data.fromJson(Map<String, dynamic> json) => _$DataFromJson(json);

  Map<String, dynamic> toJson() => _$DataToJson(this);
}

@JsonSerializable()
class ContactType {
  @JsonKey(name: "id")
  int? id;
  @JsonKey(name: "name")
  String? name;

  @override
  String toString() {
    return '$name';
  }

  ContactType({
    this.id,
    this.name,
  });

  factory ContactType.fromJson(Map<String, dynamic> json) =>
      _$ContactTypeFromJson(json);

  Map<String, dynamic> toJson() => _$ContactTypeToJson(this);
}
