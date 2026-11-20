// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'daily_visitiror_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DailyVisitirorModel _$DailyVisitirorModelFromJson(Map<String, dynamic> json) =>
    DailyVisitirorModel(
      id: (json['id'] as num?)?.toInt(),
      date: const UtcDateTimeConverter().fromJson(json['date'] as String?),
      feePerVisitor: (json['feePerVisitor'] as num).toDouble(),
      visitorCount: (json['visitorCount'] as num?)?.toInt(),
      totalRevenue: (json['totalRevenue'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$DailyVisitirorModelToJson(
  DailyVisitirorModel instance,
) => <String, dynamic>{
  'id': instance.id,
  'date': const UtcDateTimeConverter().toJson(instance.date),
  'feePerVisitor': instance.feePerVisitor,
  'visitorCount': instance.visitorCount,
  'totalRevenue': instance.totalRevenue,
};
