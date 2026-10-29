import 'package:json_annotation/json_annotation.dart';

part 'member_activity_logedin_model.g.dart';

@JsonSerializable()
class MemberActivityLogedinModel {
  final int activityId;
  final String activityName;
  final double price;
  final DateTime endDate;
  final int remainingDays;
  final int totalSessions;
  final int remainingSessions;
  final String status;

  MemberActivityLogedinModel({
    required this.activityId,
    required this.activityName,
    required this.price,
    required this.endDate,
    required this.remainingDays,
    required this.totalSessions,
    required this.remainingSessions,
    required this.status,
  });

  factory MemberActivityLogedinModel.fromJson(Map<String, dynamic> json) =>
      _$MemberActivityLogedinModelFromJson(json);

  Map<String, dynamic> toJson() => _$MemberActivityLogedinModelToJson(this);
}
