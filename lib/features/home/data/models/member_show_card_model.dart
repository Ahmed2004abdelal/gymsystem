import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:gymsystem/core/utils/utc_datetime_converter.dart';

part 'member_show_card_model.freezed.dart';
part 'member_show_card_model.g.dart';

@freezed
abstract class MemberShowCardModel with _$MemberShowCardModel {
  const factory MemberShowCardModel({
    required int id,
    required String code,
    required String name,
    required String phone,
    required String gender,
    String? packageName,
    @UtcDateTimeConverter() DateTime? subscriptionEndDate,
    String? subscriptionStatus,
    int? remainingDays,
    int? totalSessions,
    int? remainingSessions,
    List<String>? activityNames,
    String? trainerName,
    @UtcDateTimeConverter() DateTime? lastAttendanceTime,
  }) = _MemberShowCardModel;

  factory MemberShowCardModel.fromJson(Map<String, dynamic> json) =>
      _$MemberShowCardModelFromJson(json);
}
