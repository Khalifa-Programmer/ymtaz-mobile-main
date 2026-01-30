import 'package:json_annotation/json_annotation.dart';

part 'languages_response.g.dart';

@JsonSerializable()
class LanguagesResponse {
  @JsonKey(name: "status")
  bool? status;
  @JsonKey(name: "code")
  int? code;
  @JsonKey(name: "message")
  String? message;
  @JsonKey(name: "data")
  Data? data;

  LanguagesResponse({
    this.status,
    this.code,
    this.message,
    this.data,
  });

  factory LanguagesResponse.fromJson(Map<String, dynamic> json) =>
      _$LanguagesResponseFromJson(json);

  Map<String, dynamic> toJson() => _$LanguagesResponseToJson(this);
}

@JsonSerializable()
class Data {
  @JsonKey(name: "languages")
  List<Language>? languages;

  Data({
    this.languages,
  });

  @override
  String toString() {
    return '$languages';
  }

  factory Data.fromJson(Map<String, dynamic> json) => _$DataFromJson(json);

  Map<String, dynamic> toJson() => _$DataToJson(this);
}

@JsonSerializable()
class Language {
  @JsonKey(name: "id")
  int? id;
  @JsonKey(name: "name")
  String? name;

  Language({
    this.id,
    this.name,
  });

  @override
  String toString() {
    return '$name';
  }

  factory Language.fromJson(Map<String, dynamic> json) =>
      _$LanguageFromJson(json);

  Map<String, dynamic> toJson() => _$LanguageToJson(this);
}
