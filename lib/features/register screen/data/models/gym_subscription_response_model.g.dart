// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'gym_subscription_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GymSubscriptionResponseModel _$GymSubscriptionResponseModelFromJson(
  Map<String, dynamic> json,
) => GymSubscriptionResponseModel(
  id: (json['id'] as num).toInt(),
  memberName: json['memberName'] as String,
  memberCode: json['memberCode'] as String,
  packageName: json['packageName'] as String,
  trainerName: json['trainerName'] as String?,
  paidAmount: (json['paidAmount'] as num).toDouble(),
  startDate: DateTime.parse(json['startDate'] as String),
  endDate: DateTime.parse(json['endDate'] as String),
  totalSessions: (json['totalSessions'] as num).toInt(),
  remainingSessions: (json['remainingSessions'] as num).toInt(),
  status: json['status'] as String,
);

Map<String, dynamic> _$GymSubscriptionResponseModelToJson(
  GymSubscriptionResponseModel instance,
) => <String, dynamic>{
  'id': instance.id,
  'memberName': instance.memberName,
  'memberCode': instance.memberCode,
  'packageName': instance.packageName,
  'trainerName': instance.trainerName,
  'paidAmount': instance.paidAmount,
  'startDate': instance.startDate.toIso8601String(),
  'endDate': instance.endDate.toIso8601String(),
  'totalSessions': instance.totalSessions,
  'remainingSessions': instance.remainingSessions,
  'status': instance.status,
};
