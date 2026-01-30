import 'package:json_annotation/json_annotation.dart';

part 'functional_cases.g.dart';

@JsonSerializable()
class FunctionalCases {
  @JsonKey(name: "status")
  bool? status;
  @JsonKey(name: "code")
  int? code;
  @JsonKey(name: "message")
  String? message;
  @JsonKey(name: "data")
  Data? data;

  FunctionalCases({
    this.status,
    this.code,
    this.message,
    this.data,
  });

  factory FunctionalCases.fromJson(Map<String, dynamic> json) =>
      _$FunctionalCasesFromJson(json);

  Map<String, dynamic> toJson() => _$FunctionalCasesToJson(this);
}

@JsonSerializable()
class Data {
  @JsonKey(name: "FunctionalCases")
  List<FunctionalCase>? functionalCases;

  Data({
    this.functionalCases,
  });

  factory Data.fromJson(Map<String, dynamic> json) => _$DataFromJson(json);

  Map<String, dynamic> toJson() => _$DataToJson(this);
}

@JsonSerializable()
class FunctionalCase {
  @JsonKey(name: "id")
  int? id;
  @JsonKey(name: "title")
  String? title;

  @override
  String toString() {
    return '$title';
  }

  FunctionalCase({
    this.id,
    this.title,
  });

  factory FunctionalCase.fromJson(Map<String, dynamic> json) =>
      _$FunctionalCaseFromJson(json);

  Map<String, dynamic> toJson() => _$FunctionalCaseToJson(this);
}
