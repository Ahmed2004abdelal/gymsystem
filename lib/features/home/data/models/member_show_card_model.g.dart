// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'member_show_card_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_MemberShowCardModel _$MemberShowCardModelFromJson(Map<String, dynamic> json) =>
    _MemberShowCardModel(
      id: (json['id'] as num).toInt(),
      code: json['code'] as String,
      name: json['name'] as String,
      phone: json['phone'] as String,
      gender: json['gender'] as String,
      packageName: json['packageName'] as String?,
      subscriptionEndDate: const UtcDateTimeConverter().fromJson(
        json['subscriptionEndDate'] as String?,
      ),
      subscriptionStatus: json['subscriptionStatus'] as String?,
      remainingDays: (json['remainingDays'] as num?)?.toInt(),
      totalSessions: (json['totalSessions'] as num?)?.toInt(),
      remainingSessions: (json['remainingSessions'] as num?)?.toInt(),
      activityNames: (json['activityNames'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      trainerName: json['trainerName'] as String?,
      lastAttendanceTime: const UtcDateTimeConverter().fromJson(
        json['lastAttendanceTime'] as String?,
      ),
    );

Map<String, dynamic> _$MemberShowCardModelToJson(
  _MemberShowCardModel instance,
) => <String, dynamic>{
  'id': instance.id,
  'code': instance.code,
  'name': instance.name,
  'phone': instance.phone,
  'gender': instance.gender,
  'packageName': instance.packageName,
  'subscriptionEndDate': const UtcDateTimeConverter().toJson(
    instance.subscriptionEndDate,
  ),
  'subscriptionStatus': instance.subscriptionStatus,
  'remainingDays': instance.remainingDays,
  'totalSessions': instance.totalSessions,
  'remainingSessions': instance.remainingSessions,
  'activityNames': instance.activityNames,
  'trainerName': instance.trainerName,
  'lastAttendanceTime': const UtcDateTimeConverter().toJson(
    instance.lastAttendanceTime,
  ),
};
