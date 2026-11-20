import 'package:gymsystem/core/utils/utc_datetime_converter.dart';
import 'package:json_annotation/json_annotation.dart';

part 'daily_visitiror_model.g.dart';

@JsonSerializable()
class DailyVisitirorModel {
  final int? id;
  @UtcDateTimeConverter()
  final DateTime? date;
  final double feePerVisitor;
  final int? visitorCount;
  final double? totalRevenue;

  DailyVisitirorModel({
    this.id,
    this.date,
    required this.feePerVisitor,
    this.visitorCount,
    this.totalRevenue,
  });

  factory DailyVisitirorModel.fromJson(Map<String, dynamic> json) =>
      _$DailyVisitirorModelFromJson(json);

  Map<String, dynamic> toJson() => _$DailyVisitirorModelToJson(this);
}
