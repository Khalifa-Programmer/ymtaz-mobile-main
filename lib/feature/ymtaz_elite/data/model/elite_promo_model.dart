import 'package:json_annotation/json_annotation.dart';

part 'elite_promo_model.g.dart';

@JsonSerializable()
class ElitePromoModel {
  @JsonKey(name: "status")
  bool? status;
  @JsonKey(name: "items")
  List<PromoItem>? items;

  ElitePromoModel({this.status, this.items});

  factory ElitePromoModel.fromJson(Map<String, dynamic> json) =>
      _$ElitePromoModelFromJson(json);

  Map<String, dynamic> toJson() => _$ElitePromoModelToJson(this);

  String? getValue(String key) {
    if (items == null) return null;
    try {
      return items!.firstWhere((item) => item.key == key).value;
    } catch (e) {
      return null;
    }
  }
}

@JsonSerializable()
class PromoItem {
  @JsonKey(name: "id")
  int? id;
  @JsonKey(name: "key")
  String? key;
  @JsonKey(name: "value")
  String? value;

  PromoItem({this.id, this.key, this.value});

  factory PromoItem.fromJson(Map<String, dynamic> json) =>
      _$PromoItemFromJson(json);

  Map<String, dynamic> toJson() => _$PromoItemToJson(this);
}
