import 'package:json_annotation/json_annotation.dart';

part 'advisory_category_response.g.dart';

@JsonSerializable()
class AdvisoryCateogryResponse {
  @JsonKey(name: "status")
  bool? status;
  @JsonKey(name: "code")
  int? code;
  @JsonKey(name: "message")
  String? message;
  @JsonKey(name: "data")
  Data? data;

  AdvisoryCateogryResponse({
    this.status,
    this.code,
    this.message,
    this.data,
  });

  factory AdvisoryCateogryResponse.fromJson(Map<String, dynamic> json) =>
      _$AdvisoryCateogryResponseFromJson(json);

  Map<String, dynamic> toJson() => _$AdvisoryCateogryResponseToJson(this);
}

@JsonSerializable()
class Data {
  @JsonKey(name: "items")
  List<ItemAdvisor>? items;

  Data({
    this.items,
  });

  factory Data.fromJson(Map<String, dynamic> json) => _$DataFromJson(json);

  Map<String, dynamic> toJson() => _$DataToJson(this);
}

@JsonSerializable()
class ItemAdvisor {
  @JsonKey(name: "id")
  int? id;
  @JsonKey(name: "title")
  String? title;
  @JsonKey(name: "description")
  String? description;
  @JsonKey(name: "instructions")
  String? instructions;
  @JsonKey(name: "min_price")
  int? minPrice;
  @JsonKey(name: "max_price")
  int? maxPrice;
  @JsonKey(name: "ymtaz_price")
  int? ymtazPrice;
  @JsonKey(name: "phone")
  dynamic phone;
  @JsonKey(name: "need_appointment")
  int? needAppointment;
  @JsonKey(name: "image")
  String? image;
  @JsonKey(name: "payment_category")
  PaymentCategory? paymentCategory;
  @JsonKey(name: "available_dates")
  List<AvailableDate>? availableDates;
  @JsonKey(name: "advisory_service_prices")
  List<AdvisoryServicePrice>? advisoryServicePrices;

  ItemAdvisor({
    this.id,
    this.title,
    this.description,
    this.instructions,
    this.minPrice,
    this.maxPrice,
    this.ymtazPrice,
    this.phone,
    this.needAppointment,
    this.image,
    this.paymentCategory,
    this.availableDates,
    this.advisoryServicePrices,
  });

  factory ItemAdvisor.fromJson(Map<String, dynamic> json) =>
      _$ItemAdvisorFromJson(json);

  Map<String, dynamic> toJson() => _$ItemAdvisorToJson(this);
}

@JsonSerializable()
class AdvisoryServicePrice {
  @JsonKey(name: "id")
  int? id;
  @JsonKey(name: "title")
  String? title;
  @JsonKey(name: "advisory_service_id")
  int? advisoryServiceId;
  @JsonKey(name: "request_level")
  int? requestLevel;
  @JsonKey(name: "price")
  int? price;

  AdvisoryServicePrice({
    this.id,
    this.title,
    this.advisoryServiceId,
    this.requestLevel,
    this.price,
  });

  @override
  String toString() {
    return '$title - $price ريال ';
  }

  factory AdvisoryServicePrice.fromJson(Map<String, dynamic> json) =>
      _$AdvisoryServicePriceFromJson(json);

  Map<String, dynamic> toJson() => _$AdvisoryServicePriceToJson(this);
}

@JsonSerializable()
class AvailableDate {
  @JsonKey(name: "id")
  int? id;
  @JsonKey(name: "date")
  DateTime? date;
  @JsonKey(name: "times")
  List<Time>? times;

  AvailableDate({
    this.id,
    this.date,
    this.times,
  });

  factory AvailableDate.fromJson(Map<String, dynamic> json) =>
      _$AvailableDateFromJson(json);

  Map<String, dynamic> toJson() => _$AvailableDateToJson(this);
}

@JsonSerializable()
class Time {
  @JsonKey(name: "id")
  int? id;
  @JsonKey(name: "time_from")
  String? timeFrom;
  @JsonKey(name: "time_to")
  String? timeTo;

  Time({
    this.id,
    this.timeFrom,
    this.timeTo,
  });

  factory Time.fromJson(Map<String, dynamic> json) => _$TimeFromJson(json);

  Map<String, dynamic> toJson() => _$TimeToJson(this);
}

@JsonSerializable()
class PaymentCategory {
  @JsonKey(name: "id")
  int? id;
  @JsonKey(name: "name")
  String? name;
  @JsonKey(name: "payment_method")
  String? paymentMethod;
  @JsonKey(name: "count")
  dynamic count;
  @JsonKey(name: "period")
  dynamic period;

  PaymentCategory({
    this.id,
    this.name,
    this.paymentMethod,
    this.count,
    this.period,
  });

  factory PaymentCategory.fromJson(Map<String, dynamic> json) =>
      _$PaymentCategoryFromJson(json);

  Map<String, dynamic> toJson() => _$PaymentCategoryToJson(this);
}
