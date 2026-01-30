// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_services_ymtaz_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CreateServicesYmtazResponseModel _$CreateServicesYmtazResponseModelFromJson(
        Map<String, dynamic> json) =>
    CreateServicesYmtazResponseModel(
      status: json['status'] as bool?,
      code: (json['code'] as num?)?.toInt(),
      message: json['message'] as String?,
      data: json['data'] == null
          ? null
          : Data.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$CreateServicesYmtazResponseModelToJson(
        CreateServicesYmtazResponseModel instance) =>
    <String, dynamic>{
      'status': instance.status,
      'code': instance.code,
      'message': instance.message,
      'data': instance.data,
    };

Data _$DataFromJson(Map<String, dynamic> json) => Data(
      id: (json['id'] as num?)?.toInt(),
      categoryId: json['category_id'],
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
      createdAt: json['created_at'] as String?,
      updatedAt: json['updated_at'] as String?,
      deletedAt: json['deleted_at'],
      needAppointment: (json['need_appointment'] as num?)?.toInt(),
      lawyerPrices: (json['lawyer_prices'] as List<dynamic>?)
          ?.map((e) => LawyerPrice.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$DataToJson(Data instance) => <String, dynamic>{
      'id': instance.id,
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
      'created_at': instance.createdAt,
      'updated_at': instance.updatedAt,
      'deleted_at': instance.deletedAt,
      'need_appointment': instance.needAppointment,
      'lawyer_prices': instance.lawyerPrices,
    };

LawyerPrice _$LawyerPriceFromJson(Map<String, dynamic> json) => LawyerPrice(
      id: (json['id'] as num?)?.toInt(),
      lawyerId: (json['lawyer_id'] as num?)?.toInt(),
      serviceId: (json['service_id'] as num?)?.toInt(),
      price: (json['price'] as num?)?.toInt(),
      createdAt: json['created_at'] as String?,
      updatedAt: json['updated_at'] as String?,
      deletedAt: json['deleted_at'],
      clientReservationsImportanceId:
          (json['client_reservations_importance_id'] as num?)?.toInt(),
      importance: json['importance'] == null
          ? null
          : Importance.fromJson(json['importance'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$LawyerPriceToJson(LawyerPrice instance) =>
    <String, dynamic>{
      'id': instance.id,
      'lawyer_id': instance.lawyerId,
      'service_id': instance.serviceId,
      'price': instance.price,
      'created_at': instance.createdAt,
      'updated_at': instance.updatedAt,
      'deleted_at': instance.deletedAt,
      'client_reservations_importance_id':
          instance.clientReservationsImportanceId,
      'importance': instance.importance,
    };

Importance _$ImportanceFromJson(Map<String, dynamic> json) => Importance(
      id: (json['id'] as num?)?.toInt(),
      title: json['title'] as String?,
      status: (json['status'] as num?)?.toInt(),
      createdAt: json['created_at'] as String?,
      updatedAt: json['updated_at'] as String?,
      deletedAt: json['deleted_at'],
    );

Map<String, dynamic> _$ImportanceToJson(Importance instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'status': instance.status,
      'created_at': instance.createdAt,
      'updated_at': instance.updatedAt,
      'deleted_at': instance.deletedAt,
    };
