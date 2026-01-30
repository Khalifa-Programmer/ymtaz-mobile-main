import 'package:json_annotation/json_annotation.dart';

part 'general_specialty.g.dart';

@JsonSerializable()
class GeneralSpecialty {
  @JsonKey(name: "status")
  bool? status;
  @JsonKey(name: "code")
  int? code;
  @JsonKey(name: "message")
  String? message;
  @JsonKey(name: "data")
  Data? data;

  GeneralSpecialty({
    this.status,
    this.code,
    this.message,
    this.data,
  });

  factory GeneralSpecialty.fromJson(Map<String, dynamic> json) =>
      _$GeneralSpecialtyFromJson(json);

  Map<String, dynamic> toJson() => _$GeneralSpecialtyToJson(this);
}

@JsonSerializable()
class Data {
  @JsonKey(name: "GeneralSpecialty")
  List<GeneralSpecialtyElement>? generalSpecialty;

  Data({
    this.generalSpecialty,
  });

  factory Data.fromJson(Map<String, dynamic> json) => _$DataFromJson(json);

  Map<String, dynamic> toJson() => _$DataToJson(this);
}

@JsonSerializable()
class GeneralSpecialtyElement {
  @JsonKey(name: "id")
  int? id;
  @JsonKey(name: "title")
  String? title;

  @override
  String toString() {
    return '$title';
  }

  GeneralSpecialtyElement({
    this.id,
    this.title,
  });

  factory GeneralSpecialtyElement.fromJson(Map<String, dynamic> json) =>
      _$GeneralSpecialtyElementFromJson(json);

  Map<String, dynamic> toJson() => _$GeneralSpecialtyElementToJson(this);
}
