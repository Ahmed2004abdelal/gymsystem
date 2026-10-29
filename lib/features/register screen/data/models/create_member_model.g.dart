// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_member_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CreateMemberModel _$CreateMemberModelFromJson(Map<String, dynamic> json) =>
    CreateMemberModel(
      code: json['code'] as String,
      name: json['name'] as String,
      gender: (json['gender'] as num).toInt(),
      phone: json['phone'] as String,
      emergencyPhone: json['emergencyPhone'] as String?,
      email: json['email'] as String,
      dateOfBirth: json['dateOfBirth'] as String?,
    );

Map<String, dynamic> _$CreateMemberModelToJson(CreateMemberModel instance) =>
    <String, dynamic>{
      'code': instance.code,
      'name': instance.name,
      'gender': instance.gender,
      'phone': instance.phone,
      'emergencyPhone': instance.emergencyPhone,
      'email': instance.email,
      'dateOfBirth': instance.dateOfBirth,
    };
