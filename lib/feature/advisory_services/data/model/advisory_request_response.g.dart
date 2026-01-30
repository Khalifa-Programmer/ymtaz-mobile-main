// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'advisory_request_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AdvisoryRequestResponse _$AdvisoryRequestResponseFromJson(
        Map<String, dynamic> json) =>
    AdvisoryRequestResponse(
      status: json['status'] as bool?,
      code: (json['code'] as num?)?.toInt(),
      message: json['message'] as String?,
      data: json['data'] == null
          ? null
          : Data.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$AdvisoryRequestResponseToJson(
        AdvisoryRequestResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'code': instance.code,
      'message': instance.message,
      'data': instance.data,
    };

Data _$DataFromJson(Map<String, dynamic> json) => Data(
      reservation: json['reservation'] == null
          ? null
          : Reservation.fromJson(json['reservation'] as Map<String, dynamic>),
      transactionId: json['transaction_id'] as String?,
      paymentUrl: json['payment_url'] as String?,
    );

Map<String, dynamic> _$DataToJson(Data instance) => <String, dynamic>{
      'reservation': instance.reservation,
      'transaction_id': instance.transactionId,
      'payment_url': instance.paymentUrl,
    };

Reservation _$ReservationFromJson(Map<String, dynamic> json) => Reservation(
      id: (json['id'] as num?)?.toInt(),
      description: json['description'] as String?,
      file: json['file'],
      paymentStatus: json['payment_status'] as String?,
      price: (json['price'] as num?)?.toInt(),
      replayStatus: (json['replay_status'] as num?)?.toInt(),
      replaySubject: json['replay_subject'],
      replayContent: json['replay_content'],
      replayFile: json['replay_file'],
      replayTime: json['replay_time'],
      replayDate: json['replay_date'],
      acceptDate: json['accept_date'],
      reservationStatus: json['reservation_status'] as String?,
      advisoryServicesId: json['advisory_services_id'] == null
          ? null
          : AdvisoryServicesId.fromJson(
              json['advisory_services_id'] as Map<String, dynamic>),
      type: json['type'] == null
          ? null
          : Type.fromJson(json['type'] as Map<String, dynamic>),
      importance: json['importance'] == null
          ? null
          : Importance.fromJson(json['importance'] as Map<String, dynamic>),
      appointment: json['appointment'],
      lawyer: json['lawyer'],
      rate: json['rate'],
      comment: json['comment'],
    );

Map<String, dynamic> _$ReservationToJson(Reservation instance) =>
    <String, dynamic>{
      'id': instance.id,
      'description': instance.description,
      'file': instance.file,
      'payment_status': instance.paymentStatus,
      'price': instance.price,
      'replay_status': instance.replayStatus,
      'replay_subject': instance.replaySubject,
      'replay_content': instance.replayContent,
      'replay_file': instance.replayFile,
      'replay_time': instance.replayTime,
      'replay_date': instance.replayDate,
      'accept_date': instance.acceptDate,
      'reservation_status': instance.reservationStatus,
      'advisory_services_id': instance.advisoryServicesId,
      'type': instance.type,
      'importance': instance.importance,
      'appointment': instance.appointment,
      'lawyer': instance.lawyer,
      'rate': instance.rate,
      'comment': instance.comment,
    };

AdvisoryServicesId _$AdvisoryServicesIdFromJson(Map<String, dynamic> json) =>
    AdvisoryServicesId(
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

Map<String, dynamic> _$AdvisoryServicesIdToJson(AdvisoryServicesId instance) =>
    <String, dynamic>{
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

Importance _$ImportanceFromJson(Map<String, dynamic> json) => Importance(
      id: (json['id'] as num?)?.toInt(),
      title: json['title'] as String?,
    );

Map<String, dynamic> _$ImportanceToJson(Importance instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
    };

Type _$TypeFromJson(Map<String, dynamic> json) => Type(
      id: (json['id'] as num?)?.toInt(),
      title: json['title'] as String?,
      advisoryServicePrices: (json['advisory_service_prices'] as List<dynamic>?)
          ?.map((e) => AdvisoryServicePrice.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$TypeToJson(Type instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'advisory_service_prices': instance.advisoryServicePrices,
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
