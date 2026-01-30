import 'package:json_annotation/json_annotation.dart';

part 'current_rank.g.dart';

@JsonSerializable()
class CurrentRank {
  @JsonKey(name: "id")
  int? id;
  @JsonKey(name: "name")
  String? name;
  @JsonKey(name: "border_color")
  String? borderColor;
  @JsonKey(name: "image")
  dynamic image;

  CurrentRank({
    this.id,
    this.name,
    this.borderColor,
    this.image,
  });

  factory CurrentRank.fromJson(Map<String, dynamic> json) =>
      _$CurrentRankFromJson(json);

  Map<String, dynamic> toJson() => _$CurrentRankToJson(this);
}
