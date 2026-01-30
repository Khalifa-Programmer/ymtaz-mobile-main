// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'lawyer_services_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LawyerServicesResponseModel _$LawyerServicesResponseModelFromJson(
        Map<String, dynamic> json) =>
    LawyerServicesResponseModel(
      status: json['status'] as bool?,
      message: json['message'] as String?,
      data: json['data'] == null
          ? null
          : Data.fromJson(json['data'] as Map<String, dynamic>),
      code: (json['code'] as num?)?.toInt(),
    );

Map<String, dynamic> _$LawyerServicesResponseModelToJson(
        LawyerServicesResponseModel instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
      'data': instance.data,
      'code': instance.code,
    };

Data _$DataFromJson(Map<String, dynamic> json) => Data(
      lawyerServices: (json['lawyerServices'] as List<dynamic>?)
          ?.map((e) => LawyerService.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$DataToJson(Data instance) => <String, dynamic>{
      'lawyerServices': instance.lawyerServices,
    };

LawyerService _$LawyerServiceFromJson(Map<String, dynamic> json) =>
    LawyerService(
      serviceId: (json['service_id'] as num?)?.toInt(),
      categoryId: (json['category_id'] as num?)?.toInt(),
      requestLevelId: json['request_level_id'],
      title: json['title'] as String?,
      image: json['image'] as String?,
      intro: json['intro'] as String?,
      details: json['details'] as String?,
      slug: json['slug'] as String?,
      sectionId: (json['section_id'] as num?)?.toInt(),
      minPrice: (json['min_price'] as num?)?.toInt(),
      maxPrice: (json['max_price'] as num?)?.toInt(),
      sections: json['sections'] as String?,
      ymtazPrice: (json['ymtaz_price'] as num?)?.toInt(),
      status: (json['status'] as num?)?.toInt(),
      needAppointment: (json['need_appointment'] as num?)?.toInt(),
      lawyerPrices: (json['lawyer_prices'] as List<dynamic>?)
          ?.map((e) => LawyerPrice.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$LawyerServiceToJson(LawyerService instance) =>
    <String, dynamic>{
      'service_id': instance.serviceId,
      'category_id': instance.categoryId,
      'request_level_id': instance.requestLevelId,
      'title': instance.title,
      'image': instance.image,
      'intro': instance.intro,
      'details': instance.details,
      'slug': instance.slug,
      'section_id': instance.sectionId,
      'min_price': instance.minPrice,
      'max_price': instance.maxPrice,
      'sections': instance.sections,
      'ymtaz_price': instance.ymtazPrice,
      'status': instance.status,
      'need_appointment': instance.needAppointment,
      'lawyer_prices': instance.lawyerPrices,
    };

LawyerPrice _$LawyerPriceFromJson(Map<String, dynamic> json) => LawyerPrice(
      price: (json['price'] as num?)?.toInt(),
      importance: json['importance'] == null
          ? null
          : Importance.fromJson(json['importance'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$LawyerPriceToJson(LawyerPrice instance) =>
    <String, dynamic>{
      'price': instance.price,
      'importance': instance.importance,
    };

Importance _$ImportanceFromJson(Map<String, dynamic> json) => Importance(
      id: (json['id'] as num?)?.toInt(),
      title: json['title'] as String?,
    );

Map<String, dynamic> _$ImportanceToJson(Importance instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
    };
