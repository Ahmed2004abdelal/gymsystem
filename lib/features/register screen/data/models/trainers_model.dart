import 'package:json_annotation/json_annotation.dart';

part 'trainers_model.g.dart';

@JsonSerializable()
class TrainersModel {
  final int id;
  final String name;
  final String phone;
  final String genderTarget;

  TrainersModel({
    required this.id,
    required this.name,
    required this.phone,
    required this.genderTarget,
  });

  factory TrainersModel.fromJson(Map<String, dynamic> json) =>
      _$TrainersModelFromJson(json);

  Map<String, dynamic> toJson() => _$TrainersModelToJson(this);
}
