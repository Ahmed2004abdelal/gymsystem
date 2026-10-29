import 'package:json_annotation/json_annotation.dart';

part 'member_logedin_request_model.g.dart';

@JsonSerializable()
class MemberLogedinRequestModel {
  final String? memberCode;
  MemberLogedinRequestModel({required this.memberCode});

  factory MemberLogedinRequestModel.fromJson(Map<String, dynamic> json) =>
      _$MemberLogedinRequestModelFromJson(json);

  Map<String, dynamic> toJson() => _$MemberLogedinRequestModelToJson(this);
}
