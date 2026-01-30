import 'package:json_annotation/json_annotation.dart';

part 'advisory_payment_types.g.dart';

@JsonSerializable()
class AdvisoryPaymentsResponse {
  @JsonKey(name: "status")
  bool? status;
  @JsonKey(name: "code")
  int? code;
  @JsonKey(name: "message")
  String? message;
  @JsonKey(name: "data")
  Data? data;

  AdvisoryPaymentsResponse({
    this.status,
    this.code,
    this.message,
    this.data,
  });

  factory AdvisoryPaymentsResponse.fromJson(Map<String, dynamic> json) =>
      _$AdvisoryPaymentsResponseFromJson(json);

  Map<String, dynamic> toJson() => _$AdvisoryPaymentsResponseToJson(this);
}

@JsonSerializable()
class Data {
  @JsonKey(name: "items")
  List<Item>? items;

  Data({
    this.items,
  });

  factory Data.fromJson(Map<String, dynamic> json) => _$DataFromJson(json);

  Map<String, dynamic> toJson() => _$DataToJson(this);
}

@JsonSerializable()
class Item {
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

  Item({
    this.id,
    this.name,
    this.paymentMethod,
    this.count,
    this.period,
  });

  @override
  String toString() {
    return '$name';
  }

  factory Item.fromJson(Map<String, dynamic> json) => _$ItemFromJson(json);

  Map<String, dynamic> toJson() => _$ItemToJson(this);
}
