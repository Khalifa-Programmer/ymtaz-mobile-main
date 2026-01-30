class ElitePricingResponse {
  final bool status;
  final int code;
  final String message;
  final ElitePricingData? data;

  ElitePricingResponse({
    required this.status,
    required this.code,
    required this.message,
    this.data,
  });

  factory ElitePricingResponse.fromJson(Map<String, dynamic> json) {
    return ElitePricingResponse(
      status: json['status'] ?? false,
      code: json['code'] ?? 0,
      message: json['message'] ?? '',
      data: json['data'] != null ? ElitePricingData.fromJson(json['data']) : null,
    );
  }
}

class ElitePricingData {
  final EliteServiceRequest eliteServiceRequest;

  ElitePricingData({required this.eliteServiceRequest});

  factory ElitePricingData.fromJson(Map<String, dynamic> json) {
    return ElitePricingData(
      eliteServiceRequest: EliteServiceRequest.fromJson(json['eliteServiceRequest']),
    );
  }
}

class EliteServiceRequest {
  final int id;
  final String accountId;
  final EliteServiceCategory eliteServiceCategory;
  final String description;
  final int transactionComplete;
  final String? transactionId;
  final String status;
  final String createdAt;
  final List<EliteServiceFile> files;
  final EliteServiceOffer? offers;

  EliteServiceRequest({
    required this.id,
    required this.accountId,
    required this.eliteServiceCategory,
    required this.description,
    required this.transactionComplete,
    this.transactionId,
    required this.status,
    required this.createdAt,
    required this.files,
    this.offers,
  });

  factory EliteServiceRequest.fromJson(Map<String, dynamic> json) {
    return EliteServiceRequest(
      id: json['id'] ?? 0,
      accountId: json['account_id'] ?? '',
      eliteServiceCategory: EliteServiceCategory.fromJson(json['elite_service_category']),
      description: json['description'] ?? '',
      transactionComplete: json['transaction_complete'] ?? 0,
      transactionId: json['transaction_id'],
      status: json['status'] ?? '',
      createdAt: json['created_at'] ?? '',
      files: (json['files'] as List<dynamic>?)?.map((e) => EliteServiceFile.fromJson(e)).toList() ?? [],
      offers: json['offers'] != null ? EliteServiceOffer.fromJson(json['offers']) : null,
    );
  }
}

class EliteServiceCategory {
  final int id;
  final String name;

  EliteServiceCategory({required this.id, required this.name});

  factory EliteServiceCategory.fromJson(Map<String, dynamic> json) {
    return EliteServiceCategory(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
    );
  }
}

class EliteServiceFile {
  final int id;
  final int eliteServiceRequestId;
  final String? advisoryServicesReservationsId;
  final String? servicesReservationsId;
  final String? reservationsId;
  final String file;
  final int isVoice;
  final int isReply;

  EliteServiceFile({
    required this.id,
    required this.eliteServiceRequestId,
    this.advisoryServicesReservationsId,
    this.servicesReservationsId,
    this.reservationsId,
    required this.file,
    required this.isVoice,
    required this.isReply,
  });

  factory EliteServiceFile.fromJson(Map<String, dynamic> json) {
    return EliteServiceFile(
      id: json['id'] ?? 0,
      eliteServiceRequestId: json['elite_service_request_id'] ?? 0,
      advisoryServicesReservationsId: json['advisory_services_reservations_id'],
      servicesReservationsId: json['services_reservations_id'],
      reservationsId: json['reservations_id'],
      file: json['file'] ?? '',
      isVoice: json['is_voice'] ?? 0,
      isReply: json['is_reply'] ?? 0,
    );
  }
}

class EliteServiceOffer {
  final int id;
  final int eliteServiceRequestId;
  final AdvisoryServiceSub? advisoryServiceSub;
  final int? advisoryServiceSubPrice;
  final String? advisoryServiceDate;
  final String? advisoryServiceFromTime;
  final String? advisoryServiceToTime;
  final dynamic serviceSub;
  final int? serviceSubPrice;
  final ReservationType? reservationType;
  final int? reservationPrice;
  final String? reservationDate;
  final String? reservationFromTime;
  final String? reservationToTime;
  final String? reservationLatitude;
  final String? reservationLongitude;
  final String createdAt;
  final String updatedAt;

  EliteServiceOffer({
    required this.id,
    required this.eliteServiceRequestId,
    this.advisoryServiceSub,
    this.advisoryServiceSubPrice,
    this.advisoryServiceDate,
    this.advisoryServiceFromTime,
    this.advisoryServiceToTime,
    this.serviceSub,
    this.serviceSubPrice,
    this.reservationType,
    this.reservationPrice,
    this.reservationDate,
    this.reservationFromTime,
    this.reservationToTime,
    this.reservationLatitude,
    this.reservationLongitude,
    required this.createdAt,
    required this.updatedAt,
  });

  factory EliteServiceOffer.fromJson(Map<String, dynamic> json) {
    return EliteServiceOffer(
      id: json['id'] ?? 0,
      eliteServiceRequestId: json['elite_service_request_id'] ?? 0,
      advisoryServiceSub: json['advisory_service_sub'] != null ? AdvisoryServiceSub.fromJson(json['advisory_service_sub']) : null,
      advisoryServiceSubPrice: json['advisory_service_sub_price'],
      advisoryServiceDate: json['advisory_service_date'],
      advisoryServiceFromTime: json['advisory_service_from_time'],
      advisoryServiceToTime: json['advisory_service_to_time'],
      serviceSub: json['service_sub'],
      serviceSubPrice: json['service_sub_price'],
      reservationType: json['reservation_type'] != null ? ReservationType.fromJson(json['reservation_type']) : null,
      reservationPrice: json['reservation_price'],
      reservationDate: json['reservation_date'],
      reservationFromTime: json['reservation_from_time'],
      reservationToTime: json['reservation_to_time'],
      reservationLatitude: json['reservation_latitude'],
      reservationLongitude: json['reservation_longitude'],
      createdAt: json['created_at'] ?? '',
      updatedAt: json['updated_at'] ?? '',
    );
  }
}

class AdvisoryServiceSub {
  final int id;
  final String name;
  final String description;
  final int minPrice;
  final int maxPrice;
  final GeneralCategory generalCategory;
  final List<Level> levels;

  AdvisoryServiceSub({
    required this.id,
    required this.name,
    required this.description,
    required this.minPrice,
    required this.maxPrice,
    required this.generalCategory,
    required this.levels,
  });

  factory AdvisoryServiceSub.fromJson(Map<String, dynamic> json) {
    return AdvisoryServiceSub(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      description: json['description'] ?? '',
      minPrice: json['min_price'] ?? 0,
      maxPrice: json['max_price'] ?? 0,
      generalCategory: GeneralCategory.fromJson(json['general_category']),
      levels: (json['levels'] as List<dynamic>?)?.map((e) => Level.fromJson(e)).toList() ?? [],
    );
  }
}

class GeneralCategory {
  final int id;
  final String name;
  final String description;
  final PaymentCategoryType paymentCategoryType;

  GeneralCategory({
    required this.id,
    required this.name,
    required this.description,
    required this.paymentCategoryType,
  });

  factory GeneralCategory.fromJson(Map<String, dynamic> json) {
    return GeneralCategory(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      description: json['description'] ?? '',
      paymentCategoryType: PaymentCategoryType.fromJson(json['payment_category_type']),
    );
  }
}

class PaymentCategoryType {
  final int id;
  final String name;
  final String description;
  final int requiresAppointment;

  PaymentCategoryType({
    required this.id,
    required this.name,
    required this.description,
    required this.requiresAppointment,
  });

  factory PaymentCategoryType.fromJson(Map<String, dynamic> json) {
    return PaymentCategoryType(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      description: json['description'] ?? '',
      requiresAppointment: json['requires_appointment'] ?? 0,
    );
  }
}

class Level {
  final int id;
  final int duration;
  final LevelInfo level;
  final String price;

  Level({
    required this.id,
    required this.duration,
    required this.level,
    required this.price,
  });

  factory Level.fromJson(Map<String, dynamic> json) {
    return Level(
      id: json['id'] ?? 0,
      duration: json['duration'] ?? 0,
      level: LevelInfo.fromJson(json['level']),
      price: json['price'] ?? '0',
    );
  }
}

class LevelInfo {
  final int id;
  final String title;

  LevelInfo({required this.id, required this.title});

  factory LevelInfo.fromJson(Map<String, dynamic> json) {
    return LevelInfo(
      id: json['id'] ?? 0,
      title: json['title'] ?? '',
    );
  }
}

class ReservationType {
  final int id;
  final String name;
  final int minPrice;
  final int maxPrice;
  final List<TypeImportance> typesImportance;

  ReservationType({
    required this.id,
    required this.name,
    required this.minPrice,
    required this.maxPrice,
    required this.typesImportance,
  });

  factory ReservationType.fromJson(Map<String, dynamic> json) {
    return ReservationType(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      minPrice: json['minPrice'] ?? 0,
      maxPrice: json['maxPrice'] ?? 0,
      typesImportance: (json['typesImportance'] as List<dynamic>?)?.map((e) => TypeImportance.fromJson(e)).toList() ?? [],
    );
  }
}

class TypeImportance {
  final int id;
  final int price;
  final int reservationImportanceId;
  final ReservationImportance reservationImportance;
  final int isYmtaz;
  final dynamic lawyer;

  TypeImportance({
    required this.id,
    required this.price,
    required this.reservationImportanceId,
    required this.reservationImportance,
    required this.isYmtaz,
    this.lawyer,
  });

  factory TypeImportance.fromJson(Map<String, dynamic> json) {
    return TypeImportance(
      id: json['id'] ?? 0,
      price: json['price'] ?? 0,
      reservationImportanceId: json['reservation_importance_id'] ?? 0,
      reservationImportance: ReservationImportance.fromJson(json['reservation_importance']),
      isYmtaz: json['isYmtaz'] ?? 0,
      lawyer: json['lawyer'],
    );
  }
}

class ReservationImportance {
  final int id;
  final String name;

  ReservationImportance({required this.id, required this.name});

  factory ReservationImportance.fromJson(Map<String, dynamic> json) {
    return ReservationImportance(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
    );
  }
}
