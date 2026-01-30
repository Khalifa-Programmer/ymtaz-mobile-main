// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'judicial_guide_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

JudicialGuideResponseModel _$JudicialGuideResponseModelFromJson(
        Map<String, dynamic> json) =>
    JudicialGuideResponseModel(
      status: json['status'] as bool?,
      message: json['message'] as String?,
      data: json['data'] == null
          ? null
          : Data.fromJson(json['data'] as Map<String, dynamic>),
      code: (json['code'] as num?)?.toInt(),
    );

Map<String, dynamic> _$JudicialGuideResponseModelToJson(
        JudicialGuideResponseModel instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
      'data': instance.data,
      'code': instance.code,
    };

Data _$DataFromJson(Map<String, dynamic> json) => Data(
      judicialGuidesMainCategories: (json['judicialGuidesMainCategories']
              as List<dynamic>?)
          ?.map((e) =>
              JudicialGuidesMainCategory.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$DataToJson(Data instance) => <String, dynamic>{
      'judicialGuidesMainCategories': instance.judicialGuidesMainCategories,
    };

JudicialGuidesMainCategory _$JudicialGuidesMainCategoryFromJson(
        Map<String, dynamic> json) =>
    JudicialGuidesMainCategory(
      id: (json['id'] as num?)?.toInt(),
      name: json['name'] as String?,
      subCategories: (json['subCategories'] as List<dynamic>?)
          ?.map((e) => SubCategory.fromJson(e as Map<String, dynamic>))
          .toList(),
      country: json['country'] == null
          ? null
          : Country.fromJson(json['country'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$JudicialGuidesMainCategoryToJson(
        JudicialGuidesMainCategory instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'subCategories': instance.subCategories,
      'country': instance.country,
    };

Country _$CountryFromJson(Map<String, dynamic> json) => Country(
      id: (json['id'] as num?)?.toInt(),
      name: json['name'] as String?,
    );

Map<String, dynamic> _$CountryToJson(Country instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
    };

SubCategory _$SubCategoryFromJson(Map<String, dynamic> json) => SubCategory(
      id: (json['id'] as num?)?.toInt(),
      name: json['name'] as String?,
      locationUrl: json['locationUrl'] as String?,
      address: json['address'] as String?,
      judicialGuides: (json['judicialGuides'] as List<dynamic>?)
          ?.map((e) => JudicialGuide.fromJson(e as Map<String, dynamic>))
          .toList(),
      emails:
          (json['emails'] as List<dynamic>?)?.map((e) => e as String).toList(),
      numbers: (json['numbers'] as List<dynamic>?)
          ?.map((e) => Number.fromJson(e as Map<String, dynamic>))
          .toList(),
      workingHoursFrom: json['working_hours_from'] as String?,
      workingHoursTo: json['working_hours_to'] as String?,
      about: json['about'] as String?,
      image: json['image'],
      region: json['region'] == null
          ? null
          : Country.fromJson(json['region'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$SubCategoryToJson(SubCategory instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'locationUrl': instance.locationUrl,
      'address': instance.address,
      'judicialGuides': instance.judicialGuides,
      'emails': instance.emails,
      'numbers': instance.numbers,
      'working_hours_from': instance.workingHoursFrom,
      'working_hours_to': instance.workingHoursTo,
      'about': instance.about,
      'image': instance.image,
      'region': instance.region,
    };

JudicialGuide _$JudicialGuideFromJson(Map<String, dynamic> json) =>
    JudicialGuide(
      id: (json['id'] as num?)?.toInt(),
      name: json['name'] as String?,
      image: json['image'] as String?,
      emails:
          (json['emails'] as List<dynamic>?)?.map((e) => e as String).toList(),
      numbers: json['numbers'] as List<dynamic>?,
      workingHoursFrom: json['working_hours_from'],
      workingHoursTo: json['working_hours_to'],
      url: json['url'] as String?,
      subCateogry: json['sub_cateogry'] == null
          ? null
          : SubCateogry.fromJson(json['sub_cateogry'] as Map<String, dynamic>),
      about: json['about'] as String?,
      city: json['city'] == null
          ? null
          : City.fromJson(json['city'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$JudicialGuideToJson(JudicialGuide instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'image': instance.image,
      'emails': instance.emails,
      'numbers': instance.numbers,
      'working_hours_from': instance.workingHoursFrom,
      'working_hours_to': instance.workingHoursTo,
      'url': instance.url,
      'sub_cateogry': instance.subCateogry,
      'about': instance.about,
      'city': instance.city,
    };

City _$CityFromJson(Map<String, dynamic> json) => City(
      id: (json['id'] as num?)?.toInt(),
      title: json['title'] as String?,
    );

Map<String, dynamic> _$CityToJson(City instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
    };

SubCateogry _$SubCateogryFromJson(Map<String, dynamic> json) => SubCateogry(
      id: (json['id'] as num?)?.toInt(),
      name: json['name'] as String?,
      locationUrl: json['locationUrl'] as String?,
      address: json['address'] as String?,
    );

Map<String, dynamic> _$SubCateogryToJson(SubCateogry instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'locationUrl': instance.locationUrl,
      'address': instance.address,
    };

Number _$NumberFromJson(Map<String, dynamic> json) => Number(
      id: (json['id'] as num?)?.toInt(),
      phoneCode: json['phone_code'] as String?,
      phoneNumber: json['phone_number'] as String?,
      judicialGuideSubId: (json['judicial_guide_sub_id'] as num?)?.toInt(),
      createdAt: json['created_at'] as String?,
      updatedAt: json['updated_at'] as String?,
    );

Map<String, dynamic> _$NumberToJson(Number instance) => <String, dynamic>{
      'id': instance.id,
      'phone_code': instance.phoneCode,
      'phone_number': instance.phoneNumber,
      'judicial_guide_sub_id': instance.judicialGuideSubId,
      'created_at': instance.createdAt,
      'updated_at': instance.updatedAt,
    };
