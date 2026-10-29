import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:gymsystem/features/activities/data/models/member_activity_logedin_model.dart';
import 'package:gymsystem/features/home/data/models/member_logedin_response_model.dart';
import 'package:gymsystem/features/home/data/models/member_show_card_model.dart';
import 'package:gymsystem/features/register%20screen/data/models/gym_subscription_response_model.dart';

part 'member_info_state.freezed.dart';

enum InfoStatus { initial, loading, success, failure }

@freezed
abstract class MemberInfoState with _$MemberInfoState {
  const factory MemberInfoState({
    @Default(InfoStatus.initial) InfoStatus memberStatus,
    @Default(InfoStatus.initial) InfoStatus subscriptionsStatus,
    @Default(InfoStatus.initial) InfoStatus attendanceStatus,
    @Default(InfoStatus.initial) InfoStatus activitiesStatus,

    // ── إجراءات ──
    @Default(InfoStatus.initial) InfoStatus updateStatus,
    @Default(InfoStatus.initial) InfoStatus deleteStatus,

    MemberShowCardModel? member,
    @Default(<GymSubscriptionResponseModel>[])
    List<GymSubscriptionResponseModel> subscriptions,
    @Default(<MemberLogedinResponseModel>[])
    List<MemberLogedinResponseModel> attendance,

    /// الأنشطة المشترك فيها العضو (memberActivitiesAttendance).
    @Default(<MemberActivityLogedinModel>[])
    List<MemberActivityLogedinModel> activities,

    String? memberError,
    String? subscriptionsError,
    String? attendanceError,
    String? activitiesError,
    String? actionError,
  }) = _MemberInfoState;
}
