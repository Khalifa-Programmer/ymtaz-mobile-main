import 'package:json_annotation/json_annotation.dart';

part 'profile_response.g.dart';

@JsonSerializable()
class ProfileResponse {
  @JsonKey(name: 'message')
  final String message;

  @JsonKey(name: 'user')
  final User user;

  ProfileResponse({
    required this.message,
    required this.user,
  });

  factory ProfileResponse.fromJson(Map<String, dynamic> json) =>
      _$ProfileResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ProfileResponseToJson(this);
}

@JsonSerializable()
class User {
  @JsonKey(name: 'id')
  final int id;

  @JsonKey(name: 'name')
  final String name;

  @JsonKey(name: 'email')
  final String email;

  @JsonKey(name: 'phone')
  final String phone;

  @JsonKey(name: 'address')
  final String? address;

  @JsonKey(name: 'created_at')
  final String createdAt;

  @JsonKey(name: 'updated_at')
  final String updatedAt;

  @JsonKey(name: 'media')
  final List<Media> media;

  User({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    this.address,
    required this.createdAt,
    required this.updatedAt,
    required this.media,
  });

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);
}

@JsonSerializable()
class Media {
  @JsonKey(name: 'id')
  final int id;

  @JsonKey(name: 'name')
  final String name;

  @JsonKey(name: 'description')
  final String description;

  @JsonKey(name: 'path')
  final String path;

  @JsonKey(name: 'type')
  final String type;

  @JsonKey(name: 'order')
  final int order;

  @JsonKey(name: 'is_main')
  final bool isMain;

  @JsonKey(name: 'size')
  final String size;

  @JsonKey(name: 'created_at')
  final String createdAt;

  @JsonKey(name: 'updated_at')
  final String updatedAt;

  Media({
    required this.id,
    required this.name,
    required this.description,
    required this.path,
    required this.type,
    required this.order,
    required this.isMain,
    required this.size,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Media.fromJson(Map<String, dynamic> json) => _$MediaFromJson(json);

  Map<String, dynamic> toJson() => _$MediaToJson(this);
}
