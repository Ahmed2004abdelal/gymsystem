import 'package:json_annotation/json_annotation.dart';

part 'api_error_model.g.dart';

// api_error_model.dart
@JsonSerializable()
class ApiErrorModel {
  final String? title;
  final String? message;
  final int? status;
  final Map<String, List<String>>? errors;

  ApiErrorModel({this.title, this.message, this.status, this.errors});

  factory ApiErrorModel.fromJson(Map<String, dynamic> json) =>
      _$ApiErrorModelFromJson(json);

  Map<String, dynamic> toJson() => _$ApiErrorModelToJson(this);

  String getAllErrorMessages() {
    final all = errors?.values.expand((m) => m).toList() ?? [];
    if (all.isNotEmpty) return all.join('\n');
    return message ?? title ?? 'حدث خطأ غير معروف';
  }
}
