import 'package:json_annotation/json_annotation.dart';

part 'banners_model.g.dart';

@JsonSerializable()
class BannersModel {
  @JsonKey(name: "status")
  bool? status;
  @JsonKey(name: "code")
  int? code;
  @JsonKey(name: "message")
  String? message;
  @JsonKey(name: "data")
  Data? data;

  BannersModel({
    this.status,
    this.code,
    this.message,
    this.data,
  });

  factory BannersModel.fromJson(Map<String, dynamic> json) =>
      _$BannersModelFromJson(json);

  Map<String, dynamic> toJson() => _$BannersModelToJson(this);
}

@JsonSerializable()
class Data {
  @JsonKey(name: "banners")
  List<Banner>? banners;

  Data({
    this.banners,
  });

  factory Data.fromJson(Map<String, dynamic> json) => _$DataFromJson(json);

  Map<String, dynamic> toJson() => _$DataToJson(this);
}

@JsonSerializable()
class Banner {
  @JsonKey(name: "id")
  int? id;
  @JsonKey(name: "image")
  String? image;
  @JsonKey(name: "expires_at")
  dynamic expiresAt;

  Banner({
    this.id,
    this.image,
    this.expiresAt,
  });

  factory Banner.fromJson(Map<String, dynamic> json) => _$BannerFromJson(json);

  Map<String, dynamic> toJson() => _$BannerToJson(this);
}
