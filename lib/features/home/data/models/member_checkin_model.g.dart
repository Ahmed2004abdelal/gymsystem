// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'member_checkin_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MemberCheckintModel _$MemberCheckintModelFromJson(Map<String, dynamic> json) =>
    MemberCheckintModel(
      exists: json['exists'] as bool?,
      action: json['action'] as String?,
      message: json['message'] as String?,
      memberId: (json['memberId'] as num?)?.toInt(),
      memberName: json['memberName'] as String?,
      memberCode: json['memberCode'] as String?,
    );

Map<String, dynamic> _$MemberCheckintModelToJson(
  MemberCheckintModel instance,
) => <String, dynamic>{
  'exists': instance.exists,
  'action': instance.action,
  'message': instance.message,
  'memberId': instance.memberId,
  'memberName': instance.memberName,
  'memberCode': instance.memberCode,
};
