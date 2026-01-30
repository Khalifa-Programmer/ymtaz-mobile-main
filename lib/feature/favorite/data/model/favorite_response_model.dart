import 'package:json_annotation/json_annotation.dart';

part 'favorite_response_model.g.dart';

@JsonSerializable()
class FavoriteResponseModel {
  @JsonKey(name: "status")
  bool? status;
  @JsonKey(name: "message")
  String? message;
  @JsonKey(name: "data")
  Data? data;
  @JsonKey(name: "code")
  int? code;

  FavoriteResponseModel({
    this.status,
    this.message,
    this.data,
    this.code,
  });

  factory FavoriteResponseModel.fromJson(Map<String, dynamic> json) =>
      _$FavoriteResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$FavoriteResponseModelToJson(this);
}

@JsonSerializable()
class Data {
  @JsonKey(name: "favouriteLawyers")
  List<FavouriteLawyer>? favouriteLawyers;

  Data({
    this.favouriteLawyers,
  });

  factory Data.fromJson(Map<String, dynamic> json) => _$DataFromJson(json);

  Map<String, dynamic> toJson() => _$DataToJson(this);
}

@JsonSerializable()
class FavouriteLawyer {
  @JsonKey(name: "id")
  int? id;
  @JsonKey(name: "userType")
  String? userType;
  @JsonKey(name: "service_user_id")
  dynamic serviceUserId;
  @JsonKey(name: "lawyer_id")
  int? lawyerId;
  @JsonKey(name: "fav_lawyer_id")
  int? favLawyerId;
  @JsonKey(name: "created_at")
  String? createdAt;
  @JsonKey(name: "updated_at")
  String? updatedAt;
  @JsonKey(name: "fav_lawyer")
  FavLawyer? favLawyer;

  FavouriteLawyer({
    this.id,
    this.userType,
    this.serviceUserId,
    this.lawyerId,
    this.favLawyerId,
    this.createdAt,
    this.updatedAt,
    this.favLawyer,
  });

  factory FavouriteLawyer.fromJson(Map<String, dynamic> json) =>
      _$FavouriteLawyerFromJson(json);

  Map<String, dynamic> toJson() => _$FavouriteLawyerToJson(this);
}

@JsonSerializable()
class FavLawyer {
  @JsonKey(name: "id")
  int? id;
  @JsonKey(name: "first_name")
  String? firstName;
  @JsonKey(name: "second_name")
  String? secondName;
  @JsonKey(name: "third_name")
  dynamic thirdName;
  @JsonKey(name: "fourth_name")
  String? fourthName;
  @JsonKey(name: "name")
  String? name;
  @JsonKey(name: "city")
  int? city;
  @JsonKey(name: "photo")
  String? photo;
  @JsonKey(name: "email")
  String? email;
  @JsonKey(name: "gender")
  String? gender;
  @JsonKey(name: "degree")
  int? degree;
  @JsonKey(name: "degree_certificate")
  dynamic degreeCertificate;
  @JsonKey(name: "phone_code")
  String? phoneCode;
  @JsonKey(name: "phone")
  String? phone;
  @JsonKey(name: "about")
  String? about;
  @JsonKey(name: "nat_id")
  String? natId;
  @JsonKey(name: "licence_no")
  String? licenceNo;
  @JsonKey(name: "is_advisor")
  int? isAdvisor;
  @JsonKey(name: "advisor_cat_id")
  int? advisorCatId;
  @JsonKey(name: "show_in_advoisory_website")
  int? showInAdvoisoryWebsite;
  @JsonKey(name: "accepted")
  int? accepted;
  @JsonKey(name: "sections")
  String? sections;
  @JsonKey(name: "twitter")
  dynamic twitter;
  @JsonKey(name: "username")
  String? username;
  @JsonKey(name: "country_id")
  int? countryId;
  @JsonKey(name: "pass_code")
  dynamic passCode;
  @JsonKey(name: "pass_reset")
  int? passReset;
  @JsonKey(name: "office_request")
  int? officeRequest;
  @JsonKey(name: "office_request_status")
  int? officeRequestStatus;
  @JsonKey(name: "paid_status")
  int? paidStatus;
  @JsonKey(name: "office_request_from")
  dynamic officeRequestFrom;
  @JsonKey(name: "office_request_to")
  dynamic officeRequestTo;
  @JsonKey(name: "accept_rules")
  int? acceptRules;
  @JsonKey(name: "license_image")
  dynamic licenseImage;
  @JsonKey(name: "id_image")
  dynamic idImage;
  @JsonKey(name: "digital_guide_subscription")
  int? digitalGuideSubscription;
  @JsonKey(name: "digital_guide_subscription_payment_status")
  int? digitalGuideSubscriptionPaymentStatus;
  @JsonKey(name: "show_at_digital_guide")
  int? showAtDigitalGuide;
  @JsonKey(name: "digital_guide_subscription_from")
  dynamic digitalGuideSubscriptionFrom;
  @JsonKey(name: "digital_guide_subscription_to")
  dynamic digitalGuideSubscriptionTo;
  @JsonKey(name: "special")
  int? special;
  @JsonKey(name: "type")
  int? type;
  @JsonKey(name: "longitude")
  String? longitude;
  @JsonKey(name: "latitude")
  String? latitude;
  @JsonKey(name: "device_id")
  dynamic deviceId;
  @JsonKey(name: "nationality")
  int? nationality;
  @JsonKey(name: "created_at")
  String? createdAt;
  @JsonKey(name: "updated_at")
  String? updatedAt;
  @JsonKey(name: "deleted_at")
  dynamic deletedAt;
  @JsonKey(name: "birthday")
  DateTime? birthday;
  @JsonKey(name: "other_degree")
  dynamic otherDegree;
  @JsonKey(name: "company_name")
  String? companyName;
  @JsonKey(name: "company_lisences_no")
  dynamic companyLisencesNo;
  @JsonKey(name: "company_lisences_file")
  dynamic companyLisencesFile;
  @JsonKey(name: "region")
  int? region;
  @JsonKey(name: "other_city")
  dynamic otherCity;
  @JsonKey(name: "identity_type")
  int? identityType;
  @JsonKey(name: "other_idetity_type")
  dynamic otherIdetityType;
  @JsonKey(name: "has_licence_no")
  int? hasLicenceNo;
  @JsonKey(name: "logo")
  String? logo;
  @JsonKey(name: "id_file")
  String? idFile;
  @JsonKey(name: "license_file")
  dynamic licenseFile;
  @JsonKey(name: "other_entity_name")
  dynamic otherEntityName;
  @JsonKey(name: "else_city")
  dynamic elseCity;
  @JsonKey(name: "personal_image")
  dynamic personalImage;
  @JsonKey(name: "day")
  String? day;
  @JsonKey(name: "month")
  String? month;
  @JsonKey(name: "year")
  String? year;
  @JsonKey(name: "electronic_id_code")
  dynamic electronicIdCode;
  @JsonKey(name: "general_specialty")
  int? generalSpecialty;
  @JsonKey(name: "accurate_specialty")
  int? accurateSpecialty;
  @JsonKey(name: "cv")
  dynamic cv;
  @JsonKey(name: "district")
  dynamic district;
  @JsonKey(name: "profile_complete")
  int? profileComplete;
  @JsonKey(name: "functional_cases")
  int? functionalCases;
  @JsonKey(name: "activate_email")
  int? activateEmail;
  @JsonKey(name: "activate_email_otp")
  String? activateEmailOtp;

  FavLawyer({
    this.id,
    this.firstName,
    this.secondName,
    this.thirdName,
    this.fourthName,
    this.name,
    this.city,
    this.photo,
    this.email,
    this.gender,
    this.degree,
    this.degreeCertificate,
    this.phoneCode,
    this.phone,
    this.about,
    this.natId,
    this.licenceNo,
    this.isAdvisor,
    this.advisorCatId,
    this.showInAdvoisoryWebsite,
    this.accepted,
    this.sections,
    this.twitter,
    this.username,
    this.countryId,
    this.passCode,
    this.passReset,
    this.officeRequest,
    this.officeRequestStatus,
    this.paidStatus,
    this.officeRequestFrom,
    this.officeRequestTo,
    this.acceptRules,
    this.licenseImage,
    this.idImage,
    this.digitalGuideSubscription,
    this.digitalGuideSubscriptionPaymentStatus,
    this.showAtDigitalGuide,
    this.digitalGuideSubscriptionFrom,
    this.digitalGuideSubscriptionTo,
    this.special,
    this.type,
    this.longitude,
    this.latitude,
    this.deviceId,
    this.nationality,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.birthday,
    this.otherDegree,
    this.companyName,
    this.companyLisencesNo,
    this.companyLisencesFile,
    this.region,
    this.otherCity,
    this.identityType,
    this.otherIdetityType,
    this.hasLicenceNo,
    this.logo,
    this.idFile,
    this.licenseFile,
    this.otherEntityName,
    this.elseCity,
    this.personalImage,
    this.day,
    this.month,
    this.year,
    this.electronicIdCode,
    this.generalSpecialty,
    this.accurateSpecialty,
    this.cv,
    this.district,
    this.profileComplete,
    this.functionalCases,
    this.activateEmail,
    this.activateEmailOtp,
  });

  factory FavLawyer.fromJson(Map<String, dynamic> json) =>
      _$FavLawyerFromJson(json);

  Map<String, dynamic> toJson() => _$FavLawyerToJson(this);
}
