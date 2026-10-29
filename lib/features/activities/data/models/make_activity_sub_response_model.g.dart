// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'make_activity_sub_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MakeActivitySubResponseModel _$MakeActivitySubResponseModelFromJson(
  Map<String, dynamic> json,
) => MakeActivitySubResponseModel(
  id: (json['id'] as num).toInt(),
  memberName: json['memberName'] as String,
  activityName: json['activityName'] as String,
  activitySchedule: json['activitySchedule'] as String,
  paidAmount: (json['paidAmount'] as num).toDouble(),
  startDate: DateTime.parse(json['startDate'] as String),
  endDate: DateTime.parse(json['endDate'] as String),
  totalSessions: (json['totalSessions'] as num).toInt(),
  remainingSessions: (json['remainingSessions'] as num).toInt(),
  status: json['status'] as String,
);

Map<String, dynamic> _$MakeActivitySubResponseModelToJson(
  MakeActivitySubResponseModel instance,
) => <String, dynamic>{
  'id': instance.id,
  'memberName': instance.memberName,
  'activityName': instance.activityName,
  'activitySchedule': instance.activitySchedule,
  'paidAmount': instance.paidAmount,
  'startDate': instance.startDate.toIso8601String(),
  'endDate': instance.endDate.toIso8601String(),
  'totalSessions': instance.totalSessions,
  'remainingSessions': instance.remainingSessions,
  'status': instance.status,
};
