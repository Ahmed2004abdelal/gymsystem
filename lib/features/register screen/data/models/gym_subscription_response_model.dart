import 'package:gymsystem/core/utils/utc_datetime_converter.dart';
import 'package:json_annotation/json_annotation.dart';

part 'gym_subscription_response_model.g.dart';

@JsonSerializable()
class GymSubscriptionResponseModel {
  final int id;
  final String memberName;
  final String memberCode;
  final String packageName;
  final String? trainerName;
  final double paidAmount;
  @UtcDateTimeConverter()
  final DateTime startDate;
  @UtcDateTimeConverter()
  final DateTime endDate;
  final int totalSessions;
  final int remainingSessions;
  final String status;

  GymSubscriptionResponseModel({
    required this.id,
    required this.memberName,
    required this.memberCode,
    required this.packageName,
    this.trainerName,
    required this.paidAmount,
    required this.startDate,
    required this.endDate,
    required this.totalSessions,
    required this.remainingSessions,
    required this.status,
  });

  factory GymSubscriptionResponseModel.fromJson(Map<String, dynamic> json) =>
      _$GymSubscriptionResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$GymSubscriptionResponseModelToJson(this);
}
