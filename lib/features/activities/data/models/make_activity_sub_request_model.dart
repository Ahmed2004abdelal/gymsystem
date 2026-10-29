import 'package:json_annotation/json_annotation.dart';

part 'make_activity_sub_request_model.g.dart';

@JsonSerializable()
class MakeActivitySubRequestModel {
  final int memberId;
  final int activityId;

  MakeActivitySubRequestModel({
    required this.memberId,
    required this.activityId,
  });

  factory MakeActivitySubRequestModel.fromJson(Map<String, dynamic> json) =>
      _$MakeActivitySubRequestModelFromJson(json);

  Map<String, dynamic> toJson() => _$MakeActivitySubRequestModelToJson(this);
}
