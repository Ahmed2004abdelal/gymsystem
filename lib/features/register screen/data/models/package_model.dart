import 'package:json_annotation/json_annotation.dart';

part 'package_model.g.dart';

@JsonSerializable()
class PackageModel {
  final int id;
  final String name;
  final double price;
  final int durationDays;
  final int maxSessions;
  final String genderTarget;
  final String description;

  PackageModel({
    required this.id,
    required this.name,
    required this.price,
    required this.durationDays,
    required this.maxSessions,
    required this.genderTarget,
    required this.description,
  });

  factory PackageModel.fromJson(Map<String, dynamic> json) =>
      _$PackageModelFromJson(json);

  Map<String, dynamic> toJson() => _$PackageModelToJson(this);
}
