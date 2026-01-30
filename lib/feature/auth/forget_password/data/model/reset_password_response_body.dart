import 'package:json_annotation/json_annotation.dart';

part 'reset_password_response_body.g.dart';

// Run the following command in your terminal to generate the code:
// dart run build_runner build --delete-conflicting-outputs
@JsonSerializable()
class ResetResponse {
  @JsonKey(name: "status")
  bool? status;
  @JsonKey(name: "code")
  int? code;
  @JsonKey(name: "message")
  String? message;
  @JsonKey(name: "data")
  Data? data;

  ResetResponse({
    this.status,
    this.code,
    this.message,
    this.data,
  });

  factory ResetResponse.fromJson(Map<String, dynamic> json) =>
      _$ResetResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ResetResponseToJson(this);
}

@JsonSerializable()
class Data {
  @JsonKey(name: "client")
  Client? client;

  Data({
    this.client,
  });

  factory Data.fromJson(Map<String, dynamic> json) => _$DataFromJson(json);

  Map<String, dynamic> toJson() => _$DataToJson(this);
}

@JsonSerializable()
class Client {
  @JsonKey(name: "id")
  String? id;
  @JsonKey(name: "name")
  String? name;
  @JsonKey(name: "mobile")
  String? mobile;
  @JsonKey(name: "type")
  int? type;
  @JsonKey(name: "email")
  String? email;
  @JsonKey(name: "image")
  String? image;
  @JsonKey(name: "nationality")
  String? nationality;
  @JsonKey(name: "country")
  String? country;
  @JsonKey(name: "region")
  String? region;
  @JsonKey(name: "city")
  String? city;
  @JsonKey(name: "longitude")
  String? longitude;
  @JsonKey(name: "latitude")
  String? latitude;
  @JsonKey(name: "token")
  String? token;

  Client({
    this.id,
    this.name,
    this.mobile,
    this.type,
    this.email,
    this.image,
    this.nationality,
    this.country,
    this.region,
    this.city,
    this.longitude,
    this.latitude,
    this.token,
  });

  factory Client.fromJson(Map<String, dynamic> json) => _$ClientFromJson(json);

  Map<String, dynamic> toJson() => _$ClientToJson(this);
}

// Run the following command in your terminal to generate the code:
// dart run build_runner build --delete-conflicting-outputs
