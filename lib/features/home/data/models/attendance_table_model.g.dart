// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'attendance_table_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AttendanceTableModel _$AttendanceTableModelFromJson(
  Map<String, dynamic> json,
) => AttendanceTableModel(
  totalCount: (json['totalCount'] as num).toInt(),
  pageNumber: (json['pageNumber'] as num).toInt(),
  pageSize: (json['pageSize'] as num).toInt(),
  totalPages: (json['totalPages'] as num).toInt(),
  items: (json['items'] as List<dynamic>)
      .map(
        (e) => MemberLogedinResponseModel.fromJson(e as Map<String, dynamic>),
      )
      .toList(),
);

Map<String, dynamic> _$AttendanceTableModelToJson(
  AttendanceTableModel instance,
) => <String, dynamic>{
  'totalCount': instance.totalCount,
  'pageNumber': instance.pageNumber,
  'pageSize': instance.pageSize,
  'totalPages': instance.totalPages,
  'items': instance.items,
};
