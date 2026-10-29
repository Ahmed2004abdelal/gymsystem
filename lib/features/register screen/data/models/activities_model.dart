import 'package:json_annotation/json_annotation.dart';

part 'activities_model.g.dart';

@JsonSerializable()
class ActivitiesModel {
  final int id;
  final String name;
  final double price;
  final int durationDays;
  final int maxSessions;
  final String genderTarget;
  final String schedule;
  final String description;

  ActivitiesModel({
    required this.id,
    required this.name,
    required this.price,
    required this.durationDays,
    required this.maxSessions,
    required this.genderTarget,
    required this.schedule,
    required this.description,
  });

  factory ActivitiesModel.fromJson(Map<String, dynamic> json) =>
      _$ActivitiesModelFromJson(json);

  Map<String, dynamic> toJson() => _$ActivitiesModelToJson(this);
}
