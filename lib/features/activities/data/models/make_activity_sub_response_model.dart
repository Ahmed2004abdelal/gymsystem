import 'package:gymsystem/core/utils/utc_datetime_converter.dart';
import 'package:json_annotation/json_annotation.dart';

part 'make_activity_sub_response_model.g.dart';

@JsonSerializable()
class MakeActivitySubResponseModel {
  final int id;
  final String memberName;
  final String activityName;
  final String activitySchedule; //can be empty
  final double paidAmount;
  @UtcDateTimeConverter()
  final DateTime startDate;
  @UtcDateTimeConverter()
  final DateTime endDate;
  final int totalSessions;
  final int remainingSessions;
  final String status; //can be empty

  MakeActivitySubResponseModel({
    required this.id,
    required this.memberName,
    required this.activityName,
    required this.activitySchedule,
    required this.paidAmount,
    required this.startDate,
    required this.endDate,
    required this.totalSessions,
    required this.remainingSessions,
    required this.status,
  });
  factory MakeActivitySubResponseModel.fromJson(Map<String, dynamic> json) =>
      _$MakeActivitySubResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$MakeActivitySubResponseModelToJson(this);
}
