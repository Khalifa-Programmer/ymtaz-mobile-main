import 'package:freezed_annotation/freezed_annotation.dart';

part 'sign_up_request_body.g.dart';

// Run the following command in your terminal to generate the code:
// dart run build_runner build --delete-conflicting-outputs

@JsonSerializable()
class SignUpRequestBody {
  @JsonKey(name: 'name')
  final String name;

  @JsonKey(name: 'mobile')
  final String mobile;

  @JsonKey(name: 'phone_code')
  final String phoneCode;

  @JsonKey(name: 'type')
  final int type;

  @JsonKey(name: 'email')
  final String email;

  @JsonKey(name: 'password')
  final String password;

  @JsonKey(name: 'gender')
  final String gender;

  @JsonKey(name: 'activation_type')
  final int activationType;

  @JsonKey(name: 'country_id')
  final int countryId;

  @JsonKey(name: 'city_id')
  final int cityId;

  @JsonKey(name: 'nationality_id')
  final int nationalityId;

  @JsonKey(name: 'region_id')
  final int regionId;

  @JsonKey(name: 'latitude')
  final double latitude;

  @JsonKey(name: 'longitude')
  final double longitude;

  @JsonKey(name: 'referred_by')
  final String? referredBy;

  SignUpRequestBody({
    required this.name,
    required this.mobile,
    required this.phoneCode,
    required this.type,
    required this.email,
    required this.password,
    required this.activationType,
    required this.countryId,
    required this.cityId,
    required this.nationalityId,
    required this.regionId,
    required this.gender,
    required this.latitude,
    required this.longitude,
    this.referredBy,
  });

  factory SignUpRequestBody.fromJson(Map<String, dynamic> json) =>
      _$SignUpRequestBodyFromJson(json);

  Map<String, dynamic> toJson() => _$SignUpRequestBodyToJson(this);
}
