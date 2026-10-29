// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'activities_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ActivitiesModel _$ActivitiesModelFromJson(Map<String, dynamic> json) =>
    ActivitiesModel(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String,
      price: (json['price'] as num).toDouble(),
      durationDays: (json['durationDays'] as num).toInt(),
      maxSessions: (json['maxSessions'] as num).toInt(),
      genderTarget: json['genderTarget'] as String,
      schedule: json['schedule'] as String,
      description: json['description'] as String,
    );

Map<String, dynamic> _$ActivitiesModelToJson(ActivitiesModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'price': instance.price,
      'durationDays': instance.durationDays,
      'maxSessions': instance.maxSessions,
      'genderTarget': instance.genderTarget,
      'schedule': instance.schedule,
      'description': instance.description,
    };
