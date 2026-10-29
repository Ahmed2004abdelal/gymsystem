// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'trainers_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TrainersModel _$TrainersModelFromJson(Map<String, dynamic> json) =>
    TrainersModel(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String,
      phone: json['phone'] as String,
      genderTarget: json['genderTarget'] as String,
    );

Map<String, dynamic> _$TrainersModelToJson(TrainersModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'phone': instance.phone,
      'genderTarget': instance.genderTarget,
    };
