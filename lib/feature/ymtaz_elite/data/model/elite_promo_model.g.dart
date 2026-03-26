// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'elite_promo_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ElitePromoModel _$ElitePromoModelFromJson(Map<String, dynamic> json) =>
    ElitePromoModel(
      status: json['status'] as bool?,
      items: (json['items'] as List<dynamic>?)
          ?.map((e) => PromoItem.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ElitePromoModelToJson(ElitePromoModel instance) =>
    <String, dynamic>{
      'status': instance.status,
      'items': instance.items,
    };

PromoItem _$PromoItemFromJson(Map<String, dynamic> json) => PromoItem(
      id: (json['id'] as num?)?.toInt(),
      key: json['key'] as String?,
      value: json['value'] as String?,
    );

Map<String, dynamic> _$PromoItemToJson(PromoItem instance) => <String, dynamic>{
      'id': instance.id,
      'key': instance.key,
      'value': instance.value,
    };
