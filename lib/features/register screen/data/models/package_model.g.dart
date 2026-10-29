// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'package_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PackageModel _$PackageModelFromJson(Map<String, dynamic> json) => PackageModel(
  id: (json['id'] as num).toInt(),
  name: json['name'] as String,
  price: (json['price'] as num).toDouble(),
  durationDays: (json['durationDays'] as num).toInt(),
  maxSessions: (json['maxSessions'] as num).toInt(),
  genderTarget: json['genderTarget'] as String,
  description: json['description'] as String,
);

Map<String, dynamic> _$PackageModelToJson(PackageModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'price': instance.price,
      'durationDays': instance.durationDays,
      'maxSessions': instance.maxSessions,
      'genderTarget': instance.genderTarget,
      'description': instance.description,
    };
