import 'package:json_annotation/json_annotation.dart';

part 'success_appointments_request.g.dart';

@JsonSerializable()
class SuccessAppointmentsRequest {
  @JsonKey(name: "status")
  bool? status;
  @JsonKey(name: "code")
  int? code;
  @JsonKey(name: "message")
  String? message;
  @JsonKey(name: "data")
  dynamic data;

  SuccessAppointmentsRequest({
    this.status,
    this.code,
    this.message,
    this.data,
  });

  factory SuccessAppointmentsRequest.fromJson(Map<String, dynamic> json) =>
      _$SuccessAppointmentsRequestFromJson(json);

  Map<String, dynamic> toJson() => _$SuccessAppointmentsRequestToJson(this);
}
