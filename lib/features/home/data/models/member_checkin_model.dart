import 'package:json_annotation/json_annotation.dart';

part 'member_checkin_model.g.dart';

@JsonSerializable()
class MemberCheckintModel {
  final bool? exists;
  final String? action;
  final String? message;
  final int? memberId;
  final String? memberName;
  final String? memberCode;

  MemberCheckintModel({
    this.exists,
    this.action,
    this.message,
    this.memberId,
    this.memberName,
    this.memberCode,
  });

  factory MemberCheckintModel.fromJson(Map<String, dynamic> json) =>
      _$MemberCheckintModelFromJson(json);

  Map<String, dynamic> toJson() => _$MemberCheckintModelToJson(this);
}
