// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'activity_checkin_request_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ActivityCheckinRequestModel _$ActivityCheckinRequestModelFromJson(
  Map<String, dynamic> json,
) => ActivityCheckinRequestModel(
  memberCode: json['memberCode'] as String,
  activityId: (json['activityId'] as num).toInt(),
);

Map<String, dynamic> _$ActivityCheckinRequestModelToJson(
  ActivityCheckinRequestModel instance,
) => <String, dynamic>{
  'memberCode': instance.memberCode,
  'activityId': instance.activityId,
};
