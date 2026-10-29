import 'package:gymsystem/features/register%20screen/data/models/member_details_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'clients_table_model.g.dart';

@JsonSerializable()
class ClientsTableModel {
  final int totalCount;
  final int pageNumber;
  final int pageSize;
  final int totalPages;
  final List<MemberDetailsModel> items;

  ClientsTableModel({
    required this.totalCount,
    required this.pageNumber,
    required this.pageSize,
    required this.totalPages,
    required this.items,
  });

  factory ClientsTableModel.fromJson(Map<String, dynamic> json) =>
      _$ClientsTableModelFromJson(json);

  Map<String, dynamic> toJson() => _$ClientsTableModelToJson(this);
}
