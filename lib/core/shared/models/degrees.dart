import 'package:json_annotation/json_annotation.dart';

part 'degrees.g.dart';

@JsonSerializable()
class Degrees {
  @JsonKey(name: "status")
  bool? status;
  @JsonKey(name: "code")
  int? code;
  @JsonKey(name: "message")
  String? message;
  @JsonKey(name: "data")
  Data? data;

  Degrees({
    this.status,
    this.code,
    this.message,
    this.data,
  });

  factory Degrees.fromJson(Map<String, dynamic> json) =>
      _$DegreesFromJson(json);

  Map<String, dynamic> toJson() => _$DegreesToJson(this);
}

@JsonSerializable()
class Data {
  @JsonKey(name: "Degrees")
  List<Degree>? degrees;

  Data({
    this.degrees,
  });

  factory Data.fromJson(Map<String, dynamic> json) => _$DataFromJson(json);

  Map<String, dynamic> toJson() => _$DataToJson(this);
}

@JsonSerializable()
class Degree {
  @JsonKey(name: "id")
  int? id;
  @JsonKey(name: "title")
  String? title;
  @JsonKey(name: "isSpecial")
  int? isSpecial;
  @JsonKey(name: "need_certificate")
  int? needCertificate;

  Degree({
    this.id,
    this.title,
    this.isSpecial,
    this.needCertificate,
  });

  @override
  String toString() {
    return '$title';
  }

  factory Degree.fromJson(Map<String, dynamic> json) => _$DegreeFromJson(json);

  Map<String, dynamic> toJson() => _$DegreeToJson(this);
}
