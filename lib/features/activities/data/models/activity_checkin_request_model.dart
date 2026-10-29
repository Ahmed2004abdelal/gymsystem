import 'package:json_annotation/json_annotation.dart';

part 'activity_checkin_request_model.g.dart';

@JsonSerializable()
class ActivityCheckinRequestModel {
  final String memberCode;
  final int activityId;

  ActivityCheckinRequestModel({
    required this.memberCode,
    required this.activityId,
  });

  factory ActivityCheckinRequestModel.fromJson(Map<String, dynamic> json) =>
      _$ActivityCheckinRequestModelFromJson(json);

  Map<String, dynamic> toJson() => _$ActivityCheckinRequestModelToJson(this);
}
