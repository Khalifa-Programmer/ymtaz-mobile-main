// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'my_office_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MyOfficeResponseModel _$MyOfficeResponseModelFromJson(
        Map<String, dynamic> json) =>
    MyOfficeResponseModel(
      status: json['status'] as bool?,
      code: (json['code'] as num?)?.toInt(),
      message: json['message'] as String?,
      data: json['data'] == null
          ? null
          : OfficeData.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$MyOfficeResponseModelToJson(
        MyOfficeResponseModel instance) =>
    <String, dynamic>{
      'status': instance.status,
      'code': instance.code,
      'message': instance.message,
      'data': instance.data,
    };

OfficeData _$OfficeDataFromJson(Map<String, dynamic> json) => OfficeData(
      services: json['services'] == null
          ? null
          : Services.fromJson(json['services'] as Map<String, dynamic>),
      advisoryServices: json['advisoryServices'] == null
          ? null
          : AdvisoryServices.fromJson(
              json['advisoryServices'] as Map<String, dynamic>),
      appointments: json['appointments'] == null
          ? null
          : Appointments.fromJson(json['appointments'] as Map<String, dynamic>),
    )..wallet = json['wallet'] == null
        ? null
        : Wallet.fromJson(json['wallet'] as Map<String, dynamic>);

Map<String, dynamic> _$OfficeDataToJson(OfficeData instance) =>
    <String, dynamic>{
      'services': instance.services,
      'advisoryServices': instance.advisoryServices,
      'appointments': instance.appointments,
      'wallet': instance.wallet,
    };

AdvisoryServices _$AdvisoryServicesFromJson(Map<String, dynamic> json) =>
    AdvisoryServices(
      total: (json['total'] as num?)?.toInt(),
      done: (json['done'] as num?)?.toInt(),
      pending: (json['pending'] as num?)?.toInt(),
      late: (json['late'] as num?)?.toInt(),
      percentageChange: (json['percentageChange'] as num?)?.toInt(),
      changeDirection: json['changeDirection'] as String?,
      amounts: json['amounts'] == null
          ? null
          : AdvisoryServicesAmounts.fromJson(
              json['amounts'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$AdvisoryServicesToJson(AdvisoryServices instance) =>
    <String, dynamic>{
      'total': instance.total,
      'done': instance.done,
      'pending': instance.pending,
      'late': instance.late,
      'percentageChange': instance.percentageChange,
      'changeDirection': instance.changeDirection,
      'amounts': instance.amounts,
    };

AdvisoryServicesAmounts _$AdvisoryServicesAmountsFromJson(
        Map<String, dynamic> json) =>
    AdvisoryServicesAmounts(
      total: json['total'],
      done: json['done'],
      pending: json['pending'],
      late: json['late'],
      percentageChange: (json['percentageChange'] as num?)?.toInt(),
      changeDirection: json['changeDirection'] as String?,
    )..amounts = json['amounts'] == null
        ? null
        : AdvisoryServicesAmounts.fromJson(
            json['amounts'] as Map<String, dynamic>);

Map<String, dynamic> _$AdvisoryServicesAmountsToJson(
        AdvisoryServicesAmounts instance) =>
    <String, dynamic>{
      'total': instance.total,
      'done': instance.done,
      'pending': instance.pending,
      'late': instance.late,
      'percentageChange': instance.percentageChange,
      'changeDirection': instance.changeDirection,
      'amounts': instance.amounts,
    };

Services _$ServicesFromJson(Map<String, dynamic> json) => Services(
      total: json['total'],
      done: json['done'],
      pending: json['pending'],
      late: json['late'],
    )
      ..percentageChange = (json['percentageChange'] as num?)?.toInt()
      ..changeDirection = json['changeDirection'] as String?
      ..amounts = json['amounts'] == null
          ? null
          : AdvisoryServicesAmounts.fromJson(
              json['amounts'] as Map<String, dynamic>);

Map<String, dynamic> _$ServicesToJson(Services instance) => <String, dynamic>{
      'total': instance.total,
      'done': instance.done,
      'pending': instance.pending,
      'late': instance.late,
      'percentageChange': instance.percentageChange,
      'changeDirection': instance.changeDirection,
      'amounts': instance.amounts,
    };

Appointments _$AppointmentsFromJson(Map<String, dynamic> json) => Appointments(
      total: json['total'],
      done: json['done'],
      pending: json['pending'],
    )
      ..late = json['late']
      ..percentageChange = (json['percentageChange'] as num?)?.toInt()
      ..changeDirection = json['changeDirection'] as String?
      ..amounts = json['amounts'] == null
          ? null
          : AdvisoryServicesAmounts.fromJson(
              json['amounts'] as Map<String, dynamic>);

Map<String, dynamic> _$AppointmentsToJson(Appointments instance) =>
    <String, dynamic>{
      'total': instance.total,
      'done': instance.done,
      'pending': instance.pending,
      'late': instance.late,
      'percentageChange': instance.percentageChange,
      'changeDirection': instance.changeDirection,
      'amounts': instance.amounts,
    };

Wallet _$WalletFromJson(Map<String, dynamic> json) => Wallet(
      pendingAction: (json['pendingAction'] as num?)?.toInt(),
      pendingTransfer: (json['pendingTransfer'] as num?)?.toInt(),
      transferred: (json['transferred'] as num?)?.toInt(),
      total: (json['total'] as num?)?.toInt(),
    );

Map<String, dynamic> _$WalletToJson(Wallet instance) => <String, dynamic>{
      'pendingAction': instance.pendingAction,
      'pendingTransfer': instance.pendingTransfer,
      'transferred': instance.transferred,
      'total': instance.total,
    };
