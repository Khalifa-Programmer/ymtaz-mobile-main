class ElitePricingRequest {
  final int eliteServiceRequestId;
  final int? advisoryServiceSubId;
  final int? advisoryServiceSubPrice;
  final String? advisoryServiceDate;
  final String? advisoryServiceFromTime;
  final String? advisoryServiceToTime;
  final int? serviceSubId;
  final int? serviceSubPrice;
  final int? reservationTypeId;
  final int? reservationPrice;
  final String? reservationDate;
  final String? reservationFromTime;
  final String? reservationToTime;
  final double? reservationLatitude;
  final double? reservationLongitude;

  ElitePricingRequest({
    required this.eliteServiceRequestId,
    this.advisoryServiceSubId,
    this.advisoryServiceSubPrice,
    this.advisoryServiceDate,
    this.advisoryServiceFromTime,
    this.advisoryServiceToTime,
    this.serviceSubId,
    this.serviceSubPrice,
    this.reservationTypeId,
    this.reservationPrice,
    this.reservationDate,
    this.reservationFromTime,
    this.reservationToTime,
    this.reservationLatitude,
    this.reservationLongitude,
  });

  Map<String, dynamic> toJson() {
    return {
      'elite_service_request_id': eliteServiceRequestId,
      if (advisoryServiceSubId != null)
        'advisory_service_sub_id': advisoryServiceSubId,
      if (advisoryServiceSubPrice != null)
        'advisory_service_sub_price': advisoryServiceSubPrice,
      if (advisoryServiceDate != null)
        'advisory_service_date': advisoryServiceDate,
      if (advisoryServiceFromTime != null)
        'advisory_service_from_time': advisoryServiceFromTime,
      if (advisoryServiceToTime != null)
        'advisory_service_to_time': advisoryServiceToTime,
      if (serviceSubId != null) 'service_sub_id': serviceSubId,
      if (serviceSubPrice != null) 'service_sub_price': serviceSubPrice,
      if (reservationTypeId != null) 'reservation_type_id': reservationTypeId,
      if (reservationPrice != null) 'reservation_price': reservationPrice,
      if (reservationDate != null) 'reservation_date': reservationDate,
      if (reservationFromTime != null)
        'reservation_from_time': reservationFromTime,
      if (reservationToTime != null) 'reservation_to_time': reservationToTime,
      if (reservationLatitude != null)
        'reservation_latitude': reservationLatitude,
      if (reservationLongitude != null)
        'reservation_longitude': reservationLongitude,
    };
  }
}
