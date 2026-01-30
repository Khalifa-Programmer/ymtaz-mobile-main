import 'package:json_annotation/json_annotation.dart';

import '../../../../../../../core/shared/models/current_rank.dart';

part 'client_profile.g.dart';

@JsonSerializable()
class ClientProfile {
  @JsonKey(name: "status")
  bool? status;
  @JsonKey(name: "code")
  int? code;
  @JsonKey(name: "message")
  String? message;
  @JsonKey(name: "data")
  Data? data;

  ClientProfile({
    this.status,
    this.code,
    this.message,
    this.data,
  });

  factory ClientProfile.fromJson(Map<String, dynamic> json) =>
      _$ClientProfileFromJson(json);

  Map<String, dynamic> toJson() => _$ClientProfileToJson(this);
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
  @JsonKey(name: "createdAt")
  String? createdAt;
  @JsonKey(name: "nationality")
  CountryClient? nationality;
  @JsonKey(name: "country")
  CountryClient? country;
  @JsonKey(name: "region")
  CountryClient? region;
  @JsonKey(name: "city")
  CityClient? city;
  @JsonKey(name: "longitude")
  String? longitude;
  @JsonKey(name: "latitude")
  String? latitude;
  @JsonKey(name: "gender ")
  dynamic gender;
  @JsonKey(name: "token")
  dynamic token;
  @JsonKey(name: "accepted")
  int? accepted;
  @JsonKey(name: "active")
  int? active;
  @JsonKey(name: "confirmationType")
  String? confirmationType;
  @JsonKey(name: "daysStreak")
  int? daysStreak;
  @JsonKey(name: "points")
  int? points;
  @JsonKey(name: "xp")
  int? xp;
  @JsonKey(name: "currentLevel")
  int? currentLevel;

  @JsonKey(name: "xpUntilNextLevel")
  int? xpUntilNextLevel;
  @JsonKey(name: "streamio_id")
  String? streamioId;
  @JsonKey(name: "streamio_token")
  String? streamioToken;

  @JsonKey(name: "currentRank")
  CurrentRank? currentRank;
  @JsonKey(name: "referralCode")
  String? referralCode;
  @JsonKey(name: "lastSeen")
  String? lastSeen;

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
class CityClient {
  @JsonKey(name: "id")
  int? id;
  @JsonKey(name: "title")
  String? title;

  CityClient({
    this.id,
    this.title,
  });

  factory CityClient.fromJson(Map<String, dynamic> json) =>
      _$CityClientFromJson(json);

  Map<String, dynamic> toJson() => _$CityClientToJson(this);
}

@JsonSerializable()
class CountryClient {
  @JsonKey(name: "id")
  int? id;
  @JsonKey(name: "name")
  String? name;

  CountryClient({
    this.id,
    this.name,
  });

  factory CountryClient.fromJson(Map<String, dynamic> json) =>
      _$CountryClientFromJson(json);

  Map<String, dynamic> toJson() => _$CountryClientToJson(this);
}
