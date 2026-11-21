import 'package:json_annotation/json_annotation.dart';

part 'login_response_model.g.dart';

@JsonSerializable()
class LoginResponseModel {
  final bool isSuccess;
  final String message;
  final String token;
  final String username;
  final String role;
  final String expiresOn;
  final String refreshToken;

  LoginResponseModel({
    required this.isSuccess,
    required this.message,
    required this.token,
    required this.username,
    required this.role,
    required this.expiresOn,
    required this.refreshToken,
  });
  factory LoginResponseModel.fromJson(Map<String, dynamic> json) =>
      _$LoginResponseModelFromJson(json);
  Map<String, dynamic> toJson() => _$LoginResponseModelToJson(this);
}

@JsonSerializable()
class RefreshTokenModel {
  final String refreshToken;

  RefreshTokenModel({required this.refreshToken});

  factory RefreshTokenModel.fromJson(Map<String, dynamic> json) =>
      _$RefreshTokenModelFromJson(json);

  Map<String, dynamic> toJson() => _$RefreshTokenModelToJson(this);
}
