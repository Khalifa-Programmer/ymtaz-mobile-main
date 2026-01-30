import 'package:json_annotation/json_annotation.dart';

part 'sign_up_response_body.g.dart';

// Run the following command in your terminal to generate the code:
// dart run build_runner build --delete-conflicting-outputs
@JsonSerializable()
class SignUpResponse {
  @JsonKey(name: "status")
  bool? status;
  @JsonKey(name: "code")
  int? code;
  @JsonKey(name: "message")
  String? message;
  @JsonKey(name: "data")
  Data? data;

  SignUpResponse({
    this.status,
    this.code,
    this.message,
    this.data,
  });

  factory SignUpResponse.fromJson(Map<String, dynamic> json) =>
      _$SignUpResponseFromJson(json);

  Map<String, dynamic> toJson() => _$SignUpResponseToJson(this);
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
  @JsonKey(name: "token")
  dynamic token;

  Client({
    this.id,
    this.name,
    this.mobile,
    this.type,
    this.email,
    this.image,
    this.token,
  });

  factory Client.fromJson(Map<String, dynamic> json) => _$ClientFromJson(json);

  Map<String, dynamic> toJson() => _$ClientToJson(this);
}

// Run the following command in your terminal to generate the code:
// dart run build_runner build --delete-conflicting-outputs
