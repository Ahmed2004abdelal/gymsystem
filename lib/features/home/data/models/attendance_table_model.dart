import 'package:gymsystem/features/home/data/models/member_logedin_response_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'attendance_table_model.g.dart';

@JsonSerializable()
class AttendanceTableModel {
  final int totalCount;
  final int pageNumber;
  final int pageSize;
  final int totalPages;
  final List<MemberLogedinResponseModel> items;

  AttendanceTableModel({
    required this.totalCount,
    required this.pageNumber,
    required this.pageSize,
    required this.totalPages,
    required this.items,
  });

  factory AttendanceTableModel.fromJson(Map<String, dynamic> json) =>
      _$AttendanceTableModelFromJson(json);

  Map<String, dynamic> toJson() => _$AttendanceTableModelToJson(this);
}
