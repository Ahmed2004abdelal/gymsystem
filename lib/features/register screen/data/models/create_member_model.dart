import 'package:json_annotation/json_annotation.dart';

part 'create_member_model.g.dart';

@JsonSerializable()
class CreateMemberModel {
  final String code;
  final String name;
  final int gender;
  final String phone;
  final String? emergencyPhone;
  final String email;
  final String? dateOfBirth;

  CreateMemberModel({
    required this.code,
    required this.name,
    required this.gender,
    required this.phone,
    this.emergencyPhone,
    required this.email,
    this.dateOfBirth,
  });

  factory CreateMemberModel.fromJson(Map<String, dynamic> json) =>
      _$CreateMemberModelFromJson(json);

  Map<String, dynamic> toJson() => _$CreateMemberModelToJson(this);
}
