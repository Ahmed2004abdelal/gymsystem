// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'member_details_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MemberDetailsModel _$MemberDetailsModelFromJson(Map<String, dynamic> json) =>
    MemberDetailsModel(
      id: (json['id'] as num).toInt(),
      code: json['code'] as String,
      name: json['name'] as String,
      gender: json['gender'] as String,
      phone: json['phone'] as String,
      emergencyPhone: json['emergencyPhone'] as String?,
      email: json['email'] as String?,
      dateOfBirth: const UtcDateTimeConverter().fromJson(
        json['dateOfBirth'] as String?,
      ),
      createdAt: const UtcDateTimeConverter().fromJson(
        json['createdAt'] as String?,
      ),
      packageName: json['packageName'] as String?,
      subscriptionStatus: json['subscriptionStatus'] as String?,
      subscriptionEndDate: json['subscriptionEndDate'] as String?,
      remainingDays: (json['remainingDays'] as num?)?.toInt(),
      totalSessions: (json['totalSessions'] as num?)?.toInt(),
      remainingSessions: (json['remainingSessions'] as num?)?.toInt(),
      trainerName: json['trainerName'] as String?,
    );

Map<String, dynamic> _$MemberDetailsModelToJson(MemberDetailsModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'code': instance.code,
      'name': instance.name,
      'gender': instance.gender,
      'phone': instance.phone,
      'emergencyPhone': instance.emergencyPhone,
      'email': instance.email,
      'dateOfBirth': const UtcDateTimeConverter().toJson(instance.dateOfBirth),
      'createdAt': const UtcDateTimeConverter().toJson(instance.createdAt),
      'packageName': instance.packageName,
      'subscriptionStatus': instance.subscriptionStatus,
      'subscriptionEndDate': instance.subscriptionEndDate,
      'remainingDays': instance.remainingDays,
      'totalSessions': instance.totalSessions,
      'remainingSessions': instance.remainingSessions,
      'trainerName': instance.trainerName,
    };
