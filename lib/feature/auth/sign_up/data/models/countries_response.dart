import 'package:json_annotation/json_annotation.dart';

part 'countries_response.g.dart';

@JsonSerializable()
class CountriesResponse {
  @JsonKey(name: "status")
  bool? status;
  @JsonKey(name: "code")
  int? code;
  @JsonKey(name: "message")
  String? message;
  @JsonKey(name: "data")
  Data? data;

  CountriesResponse({
    this.status,
    this.code,
    this.message,
    this.data,
  });

  factory CountriesResponse.fromJson(Map<String, dynamic> json) =>
      _$CountriesResponseFromJson(json);

  Map<String, dynamic> toJson() => _$CountriesResponseToJson(this);
}

@JsonSerializable()
class Data {
  @JsonKey(name: "Countries")
  List<Country>? countries;

  Data({
    this.countries,
  });

  factory Data.fromJson(Map<String, dynamic> json) => _$DataFromJson(json);

  Map<String, dynamic> toJson() => _$DataToJson(this);
}

@JsonSerializable()
class Country {
  @JsonKey(name: "id")
  int? id;
  @JsonKey(name: "name")
  String? name;
  @JsonKey(name: "phone_code")
  int? phoneCode;
  @JsonKey(name: "regions")
  List<Region>? regions = [];

  Country({
    this.id,
    this.name,
    this.phoneCode,
    this.regions,
  });

  @override
  String toString() {
    return '$name';
  }

  factory Country.fromJson(Map<String, dynamic> json) =>
      _$CountryFromJson(json);

  Map<String, dynamic> toJson() => _$CountryToJson(this);
}

@JsonSerializable()
class Region {
  @JsonKey(name: "id")
  int? id;
  @JsonKey(name: "name")
  String? name;
  @JsonKey(name: "cities")
  List<City>? cities;

  Region({
    this.id,
    this.name,
    this.cities,
  });

  @override
  String toString() {
    return '$name';
  }

  factory Region.fromJson(Map<String, dynamic> json) => _$RegionFromJson(json);

  Map<String, dynamic> toJson() => _$RegionToJson(this);
}

@JsonSerializable()
class City {
  @JsonKey(name: "id")
  int? id;
  @JsonKey(name: "title")
  String? title;
  @JsonKey(name: "districts")
  List<District>? districts;

  @override
  String toString() {
    return '$title';
  }

  City({
    this.id,
    this.title,
    this.districts,
  });

  factory City.fromJson(Map<String, dynamic> json) => _$CityFromJson(json);

  Map<String, dynamic> toJson() => _$CityToJson(this);
}

@JsonSerializable()
class District {
  @JsonKey(name: "id")
  int? id;
  @JsonKey(name: "title")
  String? title;

  @override
  String toString() {
    return '$title';
  }

  District({
    this.id,
    this.title,
  });

  factory District.fromJson(Map<String, dynamic> json) =>
      _$DistrictFromJson(json);

  Map<String, dynamic> toJson() => _$DistrictToJson(this);
}
