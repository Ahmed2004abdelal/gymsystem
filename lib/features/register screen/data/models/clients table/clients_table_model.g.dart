// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'clients_table_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ClientsTableModel _$ClientsTableModelFromJson(Map<String, dynamic> json) =>
    ClientsTableModel(
      totalCount: (json['totalCount'] as num).toInt(),
      pageNumber: (json['pageNumber'] as num).toInt(),
      pageSize: (json['pageSize'] as num).toInt(),
      totalPages: (json['totalPages'] as num).toInt(),
      items: (json['items'] as List<dynamic>)
          .map((e) => MemberDetailsModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ClientsTableModelToJson(ClientsTableModel instance) =>
    <String, dynamic>{
      'totalCount': instance.totalCount,
      'pageNumber': instance.pageNumber,
      'pageSize': instance.pageSize,
      'totalPages': instance.totalPages,
      'items': instance.items,
    };
