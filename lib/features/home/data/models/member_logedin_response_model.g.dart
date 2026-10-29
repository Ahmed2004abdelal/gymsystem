// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'member_logedin_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MemberLogedinResponseModel _$MemberLogedinResponseModelFromJson(
  Map<String, dynamic> json,
) => MemberLogedinResponseModel(
  id: (json['id'] as num).toInt(),
  memberCode: json['memberCode'] as String,
  memberName: json['memberName'] as String,
  packageNameAtCheckIn: json['packageNameAtCheckIn'] as String,
  trainerNameAtCheckIn: json['trainerNameAtCheckIn'] as String?,
  statusAtCheckIn: json['statusAtCheckIn'] as String,
  checkInTime: DateTime.parse(json['checkInTime'] as String),
);

Map<String, dynamic> _$MemberLogedinResponseModelToJson(
  MemberLogedinResponseModel instance,
) => <String, dynamic>{
  'id': instance.id,
  'memberCode': instance.memberCode,
  'memberName': instance.memberName,
  'packageNameAtCheckIn': instance.packageNameAtCheckIn,
  'trainerNameAtCheckIn': instance.trainerNameAtCheckIn,
  'statusAtCheckIn': instance.statusAtCheckIn,
  'checkInTime': instance.checkInTime.toIso8601String(),
};
