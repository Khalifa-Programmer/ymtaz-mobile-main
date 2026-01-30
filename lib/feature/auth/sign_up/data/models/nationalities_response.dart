import 'package:json_annotation/json_annotation.dart';

part 'nationalities_response.g.dart';

@JsonSerializable()
class NationalitiesResponse {
  @JsonKey(name: "status")
  bool? status;
  @JsonKey(name: "code")
  int? code;
  @JsonKey(name: "message")
  String? message;
  @JsonKey(name: "data")
  Data? data;

  NationalitiesResponse({
    this.status,
    this.code,
    this.message,
    this.data,
  });

  factory NationalitiesResponse.fromJson(Map<String, dynamic> json) =>
      _$NationalitiesResponseFromJson(json);

  Map<String, dynamic> toJson() => _$NationalitiesResponseToJson(this);
}

@JsonSerializable()
class Data {
  @JsonKey(name: "nationalities")
  List<Nationality>? nationalities;

  Data({
    this.nationalities,
  });

  factory Data.fromJson(Map<String, dynamic> json) => _$DataFromJson(json);

  Map<String, dynamic> toJson() => _$DataToJson(this);
}

@JsonSerializable()
class Nationality {
  @JsonKey(name: "id")
  int? id;
  @JsonKey(name: "name")
  String? name;

  Nationality({
    this.id,
    this.name,
  });

  @override
  String toString() {
    return '$name';
  }

  factory Nationality.fromJson(Map<String, dynamic> json) =>
      _$NationalityFromJson(json);

  Map<String, dynamic> toJson() => _$NationalityToJson(this);
}
