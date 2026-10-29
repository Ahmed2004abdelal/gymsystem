import 'package:gymsystem/core/utils/utc_datetime_converter.dart';
import 'package:json_annotation/json_annotation.dart';

part 'member_details_model.g.dart';

@JsonSerializable()
class MemberDetailsModel {
  final int id;
  final String code;
  final String name;
  final String gender;
  final String phone;
  final String? emergencyPhone;
  final String? email;
  @UtcDateTimeConverter()
  final DateTime? dateOfBirth;
  @UtcDateTimeConverter()
  final DateTime? createdAt;
  final String? packageName;
  final String? subscriptionStatus;
  final String? subscriptionEndDate;
  final int? remainingDays;
  final int? totalSessions;
  final int? remainingSessions;
  final String? trainerName;

  MemberDetailsModel({
    required this.id,
    required this.code,
    required this.name,
    required this.gender,
    required this.phone,
    this.emergencyPhone,
    this.email,
    this.dateOfBirth,
    this.createdAt,
    this.packageName,
    this.subscriptionStatus,
    this.subscriptionEndDate,
    this.remainingDays,
    this.totalSessions,
    this.remainingSessions,
    this.trainerName,
  });

  factory MemberDetailsModel.fromJson(Map<String, dynamic> json) =>
      _$MemberDetailsModelFromJson(json);

  Map<String, dynamic> toJson() => _$MemberDetailsModelToJson(this);
}
