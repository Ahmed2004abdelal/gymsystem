import 'package:gymsystem/core/utils/utc_datetime_converter.dart';
import 'package:json_annotation/json_annotation.dart';

part 'activity_checkin_response_model.g.dart';

@JsonSerializable()
class ActivityCheckinResponseModel {
  final int id;
  final String memberCode;
  final String memberName;
  final String activityName;
  @UtcDateTimeConverter()
  final DateTime checkInTime;
  final String message;

  ActivityCheckinResponseModel({
    required this.id,
    required this.memberCode,
    required this.memberName,
    required this.activityName,
    required this.checkInTime,
    required this.message,
  });

  factory ActivityCheckinResponseModel.fromJson(Map<String, dynamic> json) =>
      _$ActivityCheckinResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$ActivityCheckinResponseModelToJson(this);
}
