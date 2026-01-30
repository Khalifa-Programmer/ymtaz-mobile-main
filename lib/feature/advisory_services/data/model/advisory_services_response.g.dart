// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'advisory_services_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AdvisoryServicesResponse _$AdvisoryServicesResponseFromJson(
        Map<String, dynamic> json) =>
    AdvisoryServicesResponse(
      status: json['status'] as bool?,
      code: (json['code'] as num?)?.toInt(),
      message: json['message'] as String?,
      data: json['data'] == null
          ? null
          : Data.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$AdvisoryServicesResponseToJson(
        AdvisoryServicesResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'code': instance.code,
      'message': instance.message,
      'data': instance.data,
    };

Data _$DataFromJson(Map<String, dynamic> json) => Data(
      items: (json['items'] as List<dynamic>?)
          ?.map((e) => Item.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$DataToJson(Data instance) => <String, dynamic>{
      'items': instance.items,
    };

Item _$ItemFromJson(Map<String, dynamic> json) => Item(
      id: (json['id'] as num?)?.toInt(),
      title: json['title'] as String?,
      description: json['description'] as String?,
      instructions: json['instructions'] as String?,
      minPrice: (json['min_price'] as num?)?.toInt(),
      maxPrice: (json['max_price'] as num?)?.toInt(),
      ymtazPrice: (json['ymtaz_price'] as num?)?.toInt(),
      phone: json['phone'],
      needAppointment: (json['need_appointment'] as num?)?.toInt(),
      image: json['image'] as String?,
      paymentCategory: json['payment_category'] == null
          ? null
          : PaymentCategory.fromJson(
              json['payment_category'] as Map<String, dynamic>),
      availableDates: (json['available_dates'] as List<dynamic>?)
          ?.map((e) => AvailableDate.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ItemToJson(Item instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'description': instance.description,
      'instructions': instance.instructions,
      'min_price': instance.minPrice,
      'max_price': instance.maxPrice,
      'ymtaz_price': instance.ymtazPrice,
      'phone': instance.phone,
      'need_appointment': instance.needAppointment,
      'image': instance.image,
      'payment_category': instance.paymentCategory,
      'available_dates': instance.availableDates,
    };

AdvisoryServicePrice _$AdvisoryServicePriceFromJson(
        Map<String, dynamic> json) =>
    AdvisoryServicePrice(
      id: (json['id'] as num?)?.toInt(),
      title: json['title'] as String?,
      advisoryServiceId: (json['advisory_service_id'] as num?)?.toInt(),
      requestLevel: (json['request_level'] as num?)?.toInt(),
      price: (json['price'] as num?)?.toInt(),
    );

Map<String, dynamic> _$AdvisoryServicePriceToJson(
        AdvisoryServicePrice instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'advisory_service_id': instance.advisoryServiceId,
      'request_level': instance.requestLevel,
      'price': instance.price,
    };

AvailableDate _$AvailableDateFromJson(Map<String, dynamic> json) =>
    AvailableDate(
      id: (json['id'] as num?)?.toInt(),
      date:
          json['date'] == null ? null : DateTime.parse(json['date'] as String),
      times: (json['times'] as List<dynamic>?)
          ?.map((e) => Time.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$AvailableDateToJson(AvailableDate instance) =>
    <String, dynamic>{
      'id': instance.id,
      'date': instance.date?.toIso8601String(),
      'times': instance.times,
    };

Time _$TimeFromJson(Map<String, dynamic> json) => Time(
      id: (json['id'] as num?)?.toInt(),
      timeFrom: json['time_from'] as String?,
      timeTo: json['time_to'] as String?,
    );

Map<String, dynamic> _$TimeToJson(Time instance) => <String, dynamic>{
      'id': instance.id,
      'time_from': instance.timeFrom,
      'time_to': instance.timeTo,
    };

PaymentCategory _$PaymentCategoryFromJson(Map<String, dynamic> json) =>
    PaymentCategory(
      id: (json['id'] as num?)?.toInt(),
      name: json['name'] as String?,
      paymentMethod: json['payment_method'] as String?,
      count: json['count'],
      period: json['period'],
    );

Map<String, dynamic> _$PaymentCategoryToJson(PaymentCategory instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'payment_method': instance.paymentMethod,
      'count': instance.count,
      'period': instance.period,
    };
