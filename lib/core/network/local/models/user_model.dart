// import 'dart:math';
//
// import 'package:hive/hive.dart';
// import 'package:json_annotation/json_annotation.dart';
// import 'package:lacsapp/features/auth/login/data/models/login_response.dart';
//
// part 'user_model.g.dart';
//
//
//
// @JsonSerializable()
// @HiveType(typeId: 2)
// class UserLocalData {
//   @HiveField(0)
//   final String message;
//
//   @HiveField(1)
//   final String token;
//
//   @HiveField(2)
//   final User user;
//
//   UserLocalData({
//     required this.message,
//     required this.token,
//     required this.user,
//   });
//
//   factory UserLocalData.fromJson(Map<String, dynamic> json) =>
//       _$UserLocalDataFromJson(json);
//
//   Map<String, dynamic> toJson() => _$UserLocalDataToJson(this);
// }
//
// @JsonSerializable()
// @HiveType(typeId: 3)
// class UserData {
//   @HiveField(0)
//   final int id;
//
//   @HiveField(1)
//   final String name;
//
//   @HiveField(2)
//   final String email;
//
//   @HiveField(3)
//   final String phone;
//
//   @HiveField(4)
//   final String? address;
//
//   @HiveField(5)
//   final String createdAt;
//
//   @HiveField(6)
//   final String updatedAt;
//
//   @HiveField(7)
//   final List<String> media;
//
//   UserData({
//     required this.id,
//     required this.name,
//     required this.email,
//     required this.phone,
//     required this.address,
//     required this.createdAt,
//     required this.updatedAt,
//     required this.media,
//   });
//
//   factory UserData.fromJson(Map<String, dynamic> json) => _$UserDataFromJson(json);
//
//   Map<String, dynamic> toJson() => _$UserDataToJson(this);
// }
//
