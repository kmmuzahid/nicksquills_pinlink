import 'package:json_annotation/json_annotation.dart';

part 'map_saved_points_model.g.dart';

@JsonSerializable()
class MapSavedPointModel {
  @JsonKey(name: '_id')
  final String? id;
  @JsonKey(name: 'price')
  final double? price;
  @JsonKey(name: 'chargerType')
  final String? chargerType;
  @JsonKey(name: 'latitude')
  final double? latitude;
  @JsonKey(name: 'longitude')
  final double? longitude;
  @JsonKey(name: 'ratting')
  final double? ratting;
  @JsonKey(name: 'reviews')
  final int? totalCount;

  @JsonKey(name: 'name')
  final String? name;

  MapSavedPointModel({
    this.id,
    this.price,
    this.chargerType,
    this.latitude,
    this.longitude,
    this.ratting,
    this.totalCount,
    this.name,
  });

  factory MapSavedPointModel.fromJson(Map<String, dynamic> json) =>
      _$MapSavedPointModelFromJson(json);

  Map<String, dynamic> toJson() => _$MapSavedPointModelToJson(this);
}
