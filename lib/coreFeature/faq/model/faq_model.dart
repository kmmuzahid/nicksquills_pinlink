import 'package:json_annotation/json_annotation.dart';

part 'faq_model.g.dart';

@JsonSerializable()
class FaqModel {
  @JsonKey(name: '_id')
  final String? id;
  @JsonKey(name: 'question')
  final String? question;
  @JsonKey(name: 'answer')
  final String? answer;
  @JsonKey(name: 'createdAt')
  final String? createdAt;
  @JsonKey(name: 'updatedAt')
  final String? updatedAt;

  FaqModel({
    this.id,
    this.question,
    this.answer,
    this.createdAt,
    this.updatedAt,
  });

  factory FaqModel.fromJson(Map<String, dynamic> json) => _$FaqModelFromJson(json);
  Map<String, dynamic> toJson() => _$FaqModelToJson(this);
}