import 'package:json_annotation/json_annotation.dart';

part 'map_point_model.g.dart';

@JsonSerializable()
class MapPointModel {
  @JsonKey(name: '_id')
  final String? id;
  @JsonKey(name: 'name')
  final String? name;
  @JsonKey(name: 'locationName')
  final String? locationName;
  @JsonKey(name: 'image')
  final String? image;
  @JsonKey(name: 'isPinkLink5')
  final bool? isPinkLink5;
  @JsonKey(name: 'latitude')
  final double? latitude;
  @JsonKey(name: 'longitude')
  final double? longitude;

  MapPointModel({
    this.id,
    this.name,
    this.locationName,
    this.image,
    this.isPinkLink5,
    this.latitude,
    this.longitude,
  });

  factory MapPointModel.fromJson(Map<String, dynamic> json) => _$MapPointModelFromJson(json);
  Map<String, dynamic> toJson() => _$MapPointModelToJson(this);
}