// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'make_activity_sub_request_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MakeActivitySubRequestModel _$MakeActivitySubRequestModelFromJson(
  Map<String, dynamic> json,
) => MakeActivitySubRequestModel(
  memberId: (json['memberId'] as num).toInt(),
  activityId: (json['activityId'] as num).toInt(),
);

Map<String, dynamic> _$MakeActivitySubRequestModelToJson(
  MakeActivitySubRequestModel instance,
) => <String, dynamic>{
  'memberId': instance.memberId,
  'activityId': instance.activityId,
};
