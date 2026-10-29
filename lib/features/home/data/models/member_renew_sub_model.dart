import 'package:json_annotation/json_annotation.dart';

part 'member_renew_sub_model.g.dart';

@JsonSerializable()
class MemberRenewSubModel {
  final int memberId;

  MemberRenewSubModel({required this.memberId});

  factory MemberRenewSubModel.fromJson(Map<String, dynamic> json) =>
      _$MemberRenewSubModelFromJson(json);

  Map<String, dynamic> toJson() => _$MemberRenewSubModelToJson(this);
}
