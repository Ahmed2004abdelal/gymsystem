// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LoginResponseModel _$LoginResponseModelFromJson(Map<String, dynamic> json) =>
    LoginResponseModel(
      isSuccess: json['isSuccess'] as bool,
      message: json['message'] as String,
      token: json['token'] as String,
      username: json['username'] as String,
      role: json['role'] as String,
      expiresOn: json['expiresOn'] as String,
    );

Map<String, dynamic> _$LoginResponseModelToJson(LoginResponseModel instance) =>
    <String, dynamic>{
      'isSuccess': instance.isSuccess,
      'message': instance.message,
      'token': instance.token,
      'username': instance.username,
      'role': instance.role,
      'expiresOn': instance.expiresOn,
    };
