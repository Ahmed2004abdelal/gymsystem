import 'package:gymsystem/core/utils/utc_datetime_converter.dart';
import 'package:json_annotation/json_annotation.dart';

part 'session_response_model.g.dart';

@JsonSerializable()
class SessionResponseModel {
  final int id;
  @UtcDateTimeRequiredConverter()
  final DateTime date;
  final double feePerVisitor;
  final int visitorCount;
  final double totalRevenue;

  SessionResponseModel({
    required this.id,
    required this.date,
    required this.feePerVisitor,
    required this.visitorCount,
    required this.totalRevenue,
  });

  factory SessionResponseModel.fromJson(Map<String, dynamic> json) =>
      _$SessionResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$SessionResponseModelToJson(this);
}
