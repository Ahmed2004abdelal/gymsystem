// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'activity_checkin_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ActivityCheckinResponseModel _$ActivityCheckinResponseModelFromJson(
  Map<String, dynamic> json,
) => ActivityCheckinResponseModel(
  id: (json['id'] as num).toInt(),
  memberCode: json['memberCode'] as String,
  memberName: json['memberName'] as String,
  activityName: json['activityName'] as String,
  checkInTime: DateTime.parse(json['checkInTime'] as String),
  message: json['message'] as String,
);

Map<String, dynamic> _$ActivityCheckinResponseModelToJson(
  ActivityCheckinResponseModel instance,
) => <String, dynamic>{
  'id': instance.id,
  'memberCode': instance.memberCode,
  'memberName': instance.memberName,
  'activityName': instance.activityName,
  'checkInTime': instance.checkInTime.toIso8601String(),
  'message': instance.message,
};
