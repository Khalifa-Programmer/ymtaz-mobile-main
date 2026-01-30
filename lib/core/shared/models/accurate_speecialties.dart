import 'package:json_annotation/json_annotation.dart';

part 'accurate_speecialties.g.dart';

@JsonSerializable()
class AccurateSpecialties {
  @JsonKey(name: "status")
  bool? status;
  @JsonKey(name: "code")
  int? code;
  @JsonKey(name: "message")
  String? message;
  @JsonKey(name: "data")
  Data? data;

  AccurateSpecialties({
    this.status,
    this.code,
    this.message,
    this.data,
  });

  factory AccurateSpecialties.fromJson(Map<String, dynamic> json) =>
      _$AccurateSpecialtiesFromJson(json);

  Map<String, dynamic> toJson() => _$AccurateSpecialtiesToJson(this);
}

@JsonSerializable()
class Data {
  @JsonKey(name: "AccurateSpecialty")
  List<AccurateSpecialty>? accurateSpecialty;

  Data({
    this.accurateSpecialty,
  });

  factory Data.fromJson(Map<String, dynamic> json) => _$DataFromJson(json);

  Map<String, dynamic> toJson() => _$DataToJson(this);
}

@JsonSerializable()
class AccurateSpecialty {
  @JsonKey(name: "id")
  int? id;
  @JsonKey(name: "title")
  String? title;

  @override
  String toString() {
    return '$title';
  }

  AccurateSpecialty({
    this.id,
    this.title,
  });

  factory AccurateSpecialty.fromJson(Map<String, dynamic> json) =>
      _$AccurateSpecialtyFromJson(json);

  Map<String, dynamic> toJson() => _$AccurateSpecialtyToJson(this);
}
