import 'package:json_annotation/json_annotation.dart';

part 'advisory_available_types_response.g.dart';

@JsonSerializable()
class AdvisoryAvailableTypesResponse {
  @JsonKey(name: "status")
  bool? status;
  @JsonKey(name: "code")
  int? code;
  @JsonKey(name: "message")
  String? message;
  @JsonKey(name: "data")
  List<Type>? data;

  AdvisoryAvailableTypesResponse({
    this.status,
    this.code,
    this.message,
    this.data,
  });

  factory AdvisoryAvailableTypesResponse.fromJson(Map<String, dynamic> json) =>
      _$AdvisoryAvailableTypesResponseFromJson(json);

  Map<String, dynamic> toJson() => _$AdvisoryAvailableTypesResponseToJson(this);
}

@JsonSerializable()
class Type {
  @JsonKey(name: "id")
  int? id;

  @JsonKey(name: "min_price")
  int? minPrice;

  @JsonKey(name: "max_price")
  int? maxPrice;

  @JsonKey(name: "name")
  String? name;
  @JsonKey(name: "description")
  String? description;
  @JsonKey(name: "general_category_id")
  int? generalCategoryId;
  @JsonKey(name: "created_at")
  String? createdAt;
  @JsonKey(name: "updated_at")
  String? updatedAt;
  @JsonKey(name: "deleted_at")
  dynamic deletedAt;
  @JsonKey(name: "ymtazPrices")
  List<Price>? ymtazPrices;
  @JsonKey(name: "is_activated")
  bool? isActivated;
  @JsonKey(name: "isHidden")
  bool? isHidden;
  @JsonKey(name: "lawyerPrices")
  List<Price>? lawyerPrices;

  Type({
    this.id,
    this.name,
    this.description,
    this.generalCategoryId,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.ymtazPrices,
    this.isActivated,
    this.isHidden,
    this.lawyerPrices,
  });

  factory Type.fromJson(Map<String, dynamic> json) => _$TypeFromJson(json);

  Map<String, dynamic> toJson() => _$TypeToJson(this);
}

@JsonSerializable()
class Price {
  @JsonKey(name: "id")
  int? id;
  @JsonKey(name: "price")
  String? price;
  @JsonKey(name: "duration")
  int? duration;
  @JsonKey(name: "isHidden")
  int? isHidden;
  @JsonKey(name: "level")
  Level? level;

  Price({
    this.id,
    this.price,
    this.duration,
    this.isHidden,
    this.level,
  });

  factory Price.fromJson(Map<String, dynamic> json) => _$PriceFromJson(json);

  Map<String, dynamic> toJson() => _$PriceToJson(this);
}

@JsonSerializable()
class Level {
  @JsonKey(name: "id")
  int? id;
  @JsonKey(name: "name")
  String? name;

  Level({
    this.id,
    this.name,
  });

  factory Level.fromJson(Map<String, dynamic> json) => _$LevelFromJson(json);

  Map<String, dynamic> toJson() => _$LevelToJson(this);
}
