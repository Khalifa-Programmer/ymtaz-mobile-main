import 'package:json_annotation/json_annotation.dart';

part 'lawyer_type.g.dart';

@JsonSerializable()
class LawyerTypes {
  @JsonKey(name: "status")
  bool? status;
  @JsonKey(name: "code")
  int? code;
  @JsonKey(name: "message")
  String? message;
  @JsonKey(name: "data")
  Data? data;

  LawyerTypes({
    this.status,
    this.code,
    this.message,
    this.data,
  });

  factory LawyerTypes.fromJson(Map<String, dynamic> json) =>
      _$LawyerTypesFromJson(json);

  Map<String, dynamic> toJson() => _$LawyerTypesToJson(this);
}

@JsonSerializable()
class Data {
  @JsonKey(name: "types")
  List<Type>? types;

  Data({
    this.types,
  });

  factory Data.fromJson(Map<String, dynamic> json) => _$DataFromJson(json);

  Map<String, dynamic> toJson() => _$DataToJson(this);
}

@JsonSerializable()
class Type {
  @JsonKey(name: "id")
  int? id;
  @JsonKey(name: "name")
  String? name;
  @JsonKey(name: "need_company_name")
  int? needCompanyName;
  @JsonKey(name: "need_company_licence_no")
  int? needCompanyLicenceNo;
  @JsonKey(name: "need_company_licence_file")
  int? needCompanyLicenceFile;

  @override
  String toString() {
    return '$name';
  }

  Type({
    this.id,
    this.name,
    this.needCompanyName,
    this.needCompanyLicenceNo,
    this.needCompanyLicenceFile,
  });

  factory Type.fromJson(Map<String, dynamic> json) => _$TypeFromJson(json);

  Map<String, dynamic> toJson() => _$TypeToJson(this);
}
