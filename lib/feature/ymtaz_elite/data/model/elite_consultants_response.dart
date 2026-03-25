import 'package:json_annotation/json_annotation.dart';

part 'elite_consultants_response.g.dart';

@JsonSerializable()
class EliteConsultantsResponse {
  @JsonKey(name: "status")
  bool? status;
  @JsonKey(name: "message")
  String? message;
  @JsonKey(name: "data")
  EliteConsultantsData? data;

  EliteConsultantsResponse({this.status, this.message, this.data});

  factory EliteConsultantsResponse.fromJson(Map<String, dynamic> json) =>
      _$EliteConsultantsResponseFromJson(json);

  Map<String, dynamic> toJson() => _$EliteConsultantsResponseToJson(this);
}

@JsonSerializable()
class EliteConsultantsData {
  @JsonKey(name: "statistics")
  Statistics? statistics;
  @JsonKey(name: "details")
  Details? details;

  EliteConsultantsData({this.statistics, this.details});

  factory EliteConsultantsData.fromJson(Map<String, dynamic> json) =>
      _$EliteConsultantsDataFromJson(json);

  Map<String, dynamic> toJson() => _$EliteConsultantsDataToJson(this);
}

@JsonSerializable()
class Statistics {
  @JsonKey(name: "lawyers_count")
  int? lawyersCount;
  @JsonKey(name: "price")
  int? price;
  @JsonKey(name: "duration")
  int? duration;

  Statistics({this.lawyersCount, this.price, this.duration});

  factory Statistics.fromJson(Map<String, dynamic> json) =>
      _$StatisticsFromJson(json);

  Map<String, dynamic> toJson() => _$StatisticsToJson(this);
}

@JsonSerializable()
class Details {
  @JsonKey(name: "header")
  String? header;
  @JsonKey(name: "footer")
  String? footer;

  Details({this.header, this.footer});

  factory Details.fromJson(Map<String, dynamic> json) =>
      _$DetailsFromJson(json);

  Map<String, dynamic> toJson() => _$DetailsToJson(this);
}
