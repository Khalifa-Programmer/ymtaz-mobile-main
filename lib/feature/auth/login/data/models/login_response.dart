import 'package:json_annotation/json_annotation.dart';

part 'login_response.g.dart';

@JsonSerializable()
class LoginResponse {
  @JsonKey(name: "status")
  bool? status;
  @JsonKey(name: "code")
  int? code;
  @JsonKey(name: "message")
  String? message;
  @JsonKey(name: "data")
  Data? data;

  LoginResponse({
    this.status,
    this.code,
    this.message,
    this.data,
  });

  factory LoginResponse.fromJson(Map<String, dynamic> json) =>
      _$LoginResponseFromJson(json);

  Map<String, dynamic> toJson() => _$LoginResponseToJson(this);
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
  @JsonKey(name: "phone_code")
  String? phoneCode;
  @JsonKey(name: "mobile")
  String? mobile;
  @JsonKey(name: "type")
  int? type;
  @JsonKey(name: "email")
  String? email;
  @JsonKey(name: "image")
  String? image;
  @JsonKey(name: "nationality")
  Country? nationality;
  @JsonKey(name: "country")
  Country? country;
  @JsonKey(name: "region")
  Country? region;
  @JsonKey(name: "city")
  City? city;
  @JsonKey(name: "longitude")
  String? longitude;
  @JsonKey(name: "latitude")
  String? latitude;
  @JsonKey(name: "gender ")
  String? gender;
  @JsonKey(name: "token")
  String? token;
  @JsonKey(name: "accepted")
  int? accepted;
  @JsonKey(name: "active")
  int? active;
  @JsonKey(name: "confirmationType")
  String? confirmationType;
  @JsonKey(name: "streamio_id")
  String? streamioId;
  @JsonKey(name: "streamio_token")
  String? streamioToken;

  Client({
    this.id,
    this.name,
    this.phoneCode,
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
    this.gender,
    this.token,
    this.accepted,
    this.active,
    this.confirmationType,
    this.streamioId,
    this.streamioToken,
  });

  factory Client.fromJson(Map<String, dynamic> json) => _$ClientFromJson(json);

  Map<String, dynamic> toJson() => _$ClientToJson(this);
}

@JsonSerializable()
class City {
  @JsonKey(name: "id")
  int? id;
  @JsonKey(name: "title")
  String? title;

  City({
    this.id,
    this.title,
  });

  factory City.fromJson(Map<String, dynamic> json) => _$CityFromJson(json);

  Map<String, dynamic> toJson() => _$CityToJson(this);
}

@JsonSerializable()
class Country {
  @JsonKey(name: "id")
  int? id;
  @JsonKey(name: "name")
  String? name;

  Country({
    this.id,
    this.name,
  });

  factory Country.fromJson(Map<String, dynamic> json) =>
      _$CountryFromJson(json);

  Map<String, dynamic> toJson() => _$CountryToJson(this);
}
