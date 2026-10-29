// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'member_activity_logedin_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MemberActivityLogedinModel _$MemberActivityLogedinModelFromJson(
  Map<String, dynamic> json,
) => MemberActivityLogedinModel(
  activityId: (json['activityId'] as num).toInt(),
  activityName: json['activityName'] as String,
  price: (json['price'] as num).toDouble(),
  endDate: DateTime.parse(json['endDate'] as String),
  remainingDays: (json['remainingDays'] as num).toInt(),
  totalSessions: (json['totalSessions'] as num).toInt(),
  remainingSessions: (json['remainingSessions'] as num).toInt(),
  status: json['status'] as String,
);

Map<String, dynamic> _$MemberActivityLogedinModelToJson(
  MemberActivityLogedinModel instance,
) => <String, dynamic>{
  'activityId': instance.activityId,
  'activityName': instance.activityName,
  'price': instance.price,
  'endDate': instance.endDate.toIso8601String(),
  'remainingDays': instance.remainingDays,
  'totalSessions': instance.totalSessions,
  'remainingSessions': instance.remainingSessions,
  'status': instance.status,
};
