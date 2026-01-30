abstract class BaseServiceRequest {
  final int price;

  BaseServiceRequest({required this.price});
}

class ConsultationRequest extends BaseServiceRequest {
  final String advisoryTypeId;
  final String generalSpecializationId;
  final String accurateSpecializationId;
  final String date;
  final String fromTime;
  final String toTime;

  ConsultationRequest({
    required super.price,
    required this.advisoryTypeId,
    required this.generalSpecializationId,
    required this.accurateSpecializationId,
    required this.date,
    required this.fromTime,
    required this.toTime,
  });
}

class ServiceRequest extends BaseServiceRequest {
  final String mainServiceId;
  final String subServiceId;

  ServiceRequest({
    required super.price,
    required this.mainServiceId,
    required this.subServiceId,
  });
}

class AppointmentRequest extends BaseServiceRequest {
  final String appointmentTypeId;
  final DateTime date;
  final String startTime;
  final String endTime;
  final String address;
  final String lat;
  final String lng;

  AppointmentRequest({
    required super.price,
    required this.appointmentTypeId,
    required this.date,
    required this.startTime,
    required this.endTime,
    required this.address,
    required this.lat,
    required this.lng,
  });
}
