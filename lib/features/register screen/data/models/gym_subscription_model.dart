import 'package:json_annotation/json_annotation.dart';

part 'gym_subscription_model.g.dart';

@JsonSerializable()
class GymSubscriptionModel {
  final int memberId;
  final int packageId;
  final int? trainerId;

  GymSubscriptionModel({
    required this.memberId,
    required this.packageId,
    this.trainerId,
  });

  factory GymSubscriptionModel.fromJson(Map<String, dynamic> json) =>
      _$GymSubscriptionModelFromJson(json);

  Map<String, dynamic> toJson() => _$GymSubscriptionModelToJson(this);
}
