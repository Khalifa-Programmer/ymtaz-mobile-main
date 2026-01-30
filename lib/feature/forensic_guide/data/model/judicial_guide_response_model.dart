import 'package:json_annotation/json_annotation.dart';

part 'judicial_guide_response_model.g.dart';

@JsonSerializable()
class JudicialGuideResponseModel {
  @JsonKey(name: "status")
  bool? status;
  @JsonKey(name: "message")
  String? message;
  @JsonKey(name: "data")
  Data? data;
  @JsonKey(name: "code")
  int? code;

  JudicialGuideResponseModel({
    this.status,
    this.message,
    this.data,
    this.code,
  });

  factory JudicialGuideResponseModel.fromJson(Map<String, dynamic> json) =>
      _$JudicialGuideResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$JudicialGuideResponseModelToJson(this);
}

@JsonSerializable()
class Data {
  @JsonKey(name: "judicialGuidesMainCategories")
  List<JudicialGuidesMainCategory>? judicialGuidesMainCategories;

  Data({
    this.judicialGuidesMainCategories,
  });

  factory Data.fromJson(Map<String, dynamic> json) => _$DataFromJson(json);

  Map<String, dynamic> toJson() => _$DataToJson(this);
}

@JsonSerializable()
class JudicialGuidesMainCategory {
  @JsonKey(name: "id")
  int? id;
  @JsonKey(name: "name")
  String? name;
  @JsonKey(name: "subCategories")
  List<SubCategory>? subCategories;
  @JsonKey(name: "country")
  Country? country;

  JudicialGuidesMainCategory({
    this.id,
    this.name,
    this.subCategories,
    this.country,
  });

  factory JudicialGuidesMainCategory.fromJson(Map<String, dynamic> json) =>
      _$JudicialGuidesMainCategoryFromJson(json);

  Map<String, dynamic> toJson() => _$JudicialGuidesMainCategoryToJson(this);
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

@JsonSerializable()
class SubCategory {
  @JsonKey(name: "id")
  int? id;
  @JsonKey(name: "name")
  String? name;
  @JsonKey(name: "locationUrl")
  String? locationUrl;
  @JsonKey(name: "address")
  String? address;
  @JsonKey(name: "judicialGuides")
  List<JudicialGuide>? judicialGuides;
  @JsonKey(name: "emails")
  List<String>? emails;
  @JsonKey(name: "numbers")
  List<Number>? numbers;
  @JsonKey(name: "working_hours_from")
  String? workingHoursFrom;
  @JsonKey(name: "working_hours_to")
  String? workingHoursTo;
  @JsonKey(name: "about")
  String? about;
  @JsonKey(name: "image")
  dynamic image;
  @JsonKey(name: "region")
  Country? region;

  SubCategory({
    this.id,
    this.name,
    this.locationUrl,
    this.address,
    this.judicialGuides,
    this.emails,
    this.numbers,
    this.workingHoursFrom,
    this.workingHoursTo,
    this.about,
    this.image,
    this.region,
  });

  factory SubCategory.fromJson(Map<String, dynamic> json) =>
      _$SubCategoryFromJson(json);

  Map<String, dynamic> toJson() => _$SubCategoryToJson(this);
}

@JsonSerializable()
class JudicialGuide {
  @JsonKey(name: "id")
  int? id;
  @JsonKey(name: "name")
  String? name;
  @JsonKey(name: "image")
  String? image;
  @JsonKey(name: "emails")
  List<String>? emails;
  @JsonKey(name: "numbers")
  List<dynamic>? numbers;
  @JsonKey(name: "working_hours_from")
  dynamic workingHoursFrom;
  @JsonKey(name: "working_hours_to")
  dynamic workingHoursTo;
  @JsonKey(name: "url")
  String? url;
  @JsonKey(name: "sub_cateogry")
  SubCateogry? subCateogry;
  @JsonKey(name: "about")
  String? about;
  @JsonKey(name: "city")
  City? city;

  JudicialGuide({
    this.id,
    this.name,
    this.image,
    this.emails,
    this.numbers,
    this.workingHoursFrom,
    this.workingHoursTo,
    this.url,
    this.subCateogry,
    this.about,
    this.city,
  });

  factory JudicialGuide.fromJson(Map<String, dynamic> json) =>
      _$JudicialGuideFromJson(json);

  Map<String, dynamic> toJson() => _$JudicialGuideToJson(this);
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
class SubCateogry {
  @JsonKey(name: "id")
  int? id;
  @JsonKey(name: "name")
  String? name;
  @JsonKey(name: "locationUrl")
  String? locationUrl;
  @JsonKey(name: "address")
  String? address;

  SubCateogry({
    this.id,
    this.name,
    this.locationUrl,
    this.address,
  });

  factory SubCateogry.fromJson(Map<String, dynamic> json) =>
      _$SubCateogryFromJson(json);

  Map<String, dynamic> toJson() => _$SubCateogryToJson(this);
}

@JsonSerializable()
class Number {
  @JsonKey(name: "id")
  int? id;
  @JsonKey(name: "phone_code")
  String? phoneCode;
  @JsonKey(name: "phone_number")
  String? phoneNumber;
  @JsonKey(name: "judicial_guide_sub_id")
  int? judicialGuideSubId;
  @JsonKey(name: "created_at")
  String? createdAt;
  @JsonKey(name: "updated_at")
  String? updatedAt;

  Number({
    this.id,
    this.phoneCode,
    this.phoneNumber,
    this.judicialGuideSubId,
    this.createdAt,
    this.updatedAt,
  });

  factory Number.fromJson(Map<String, dynamic> json) => _$NumberFromJson(json);

  Map<String, dynamic> toJson() => _$NumberToJson(this);
}
