// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'session_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SessionResponseModel _$SessionResponseModelFromJson(
  Map<String, dynamic> json,
) => SessionResponseModel(
  id: (json['id'] as num).toInt(),
  date: const UtcDateTimeRequiredConverter().fromJson(json['date'] as String),
  feePerVisitor: (json['feePerVisitor'] as num).toDouble(),
  visitorCount: (json['visitorCount'] as num).toInt(),
  totalRevenue: (json['totalRevenue'] as num).toDouble(),
);

Map<String, dynamic> _$SessionResponseModelToJson(
  SessionResponseModel instance,
) => <String, dynamic>{
  'id': instance.id,
  'date': const UtcDateTimeRequiredConverter().toJson(instance.date),
  'feePerVisitor': instance.feePerVisitor,
  'visitorCount': instance.visitorCount,
  'totalRevenue': instance.totalRevenue,
};
