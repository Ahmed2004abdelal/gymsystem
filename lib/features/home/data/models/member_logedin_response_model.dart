import 'package:gymsystem/core/utils/utc_datetime_converter.dart';
import 'package:json_annotation/json_annotation.dart';

part 'member_logedin_response_model.g.dart';

@JsonSerializable()
class MemberLogedinResponseModel {
  final int id;
  final String memberCode;
  final String memberName;
  final String packageNameAtCheckIn;
  final String? trainerNameAtCheckIn;
  final String statusAtCheckIn;
  @UtcDateTimeConverter()
  final DateTime checkInTime;

  MemberLogedinResponseModel({
    required this.id,
    required this.memberCode,
    required this.memberName,
    required this.packageNameAtCheckIn,
    this.trainerNameAtCheckIn,
    required this.statusAtCheckIn,
    required this.checkInTime,
  });

  factory MemberLogedinResponseModel.fromJson(Map<String, dynamic> json) =>
      _$MemberLogedinResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$MemberLogedinResponseModelToJson(this);
}
