// import 'package:freezed_annotation/freezed_annotation.dart';
// import 'package:gymsystem/features/activities/data/models/activity_checkin_response_model.dart';
// import 'package:gymsystem/features/activities/data/models/make_activity_sub_response_model.dart';
// import 'package:gymsystem/features/register%20screen/data/models/activities_model.dart';

// part 'activities_state.freezed.dart';

// enum ActivitiesStatus { initial, loading, success, failure }

// @freezed
// abstract class ActivitiesState with _$ActivitiesState {
//   const factory ActivitiesState({
//     @Default(ActivitiesStatus.initial) ActivitiesStatus listStatus,
//     @Default([]) List<ActivitiesModel> activities,
//     @Default(ActivitiesStatus.initial) ActivitiesStatus checkinStatus,
//     ActivityCheckinResponseModel? checkinData,
//     @Default(ActivitiesStatus.initial) ActivitiesStatus subscribeStatus,
//     MakeActivitySubResponseModel? subscriptionData,
//     String? errorMessage,
//   }) = _ActivitiesState;
// }

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:gymsystem/features/activities/data/models/activity_checkin_response_model.dart';
import 'package:gymsystem/features/activities/data/models/make_activity_sub_response_model.dart';
import 'package:gymsystem/features/activities/data/models/member_activity_logedin_model.dart';
import 'package:gymsystem/features/home/data/models/member_show_card_model.dart';
import 'package:gymsystem/features/register%20screen/data/models/activities_model.dart';

part 'activities_state.freezed.dart';

enum ActivitiesStatus { initial, loading, success, failure }

@freezed
abstract class ActivitiesState with _$ActivitiesState {
  const factory ActivitiesState({
    @Default(ActivitiesStatus.initial) ActivitiesStatus listStatus,
    @Default([]) List<ActivitiesModel> activities,

    // ── البحث عن العضو بالكود (اشتراكاته في الأنشطة) ──
    @Default(ActivitiesStatus.initial) ActivitiesStatus lookupStatus,
    @Default(<MemberActivityLogedinModel>[])
    List<MemberActivityLogedinModel> memberActivities,
    String? lookupCode,

    /// بيانات العضو (بطاقة العضو) اللي اتجابت من ReceptionRepo.memberShowCard.
    MemberShowCardModel? memberCard,

    /// الكود مش متسجل على السيستم (404) -> الشاشة تحوّل لتسجيل عضو جديد.
    @Default(false) bool memberNotFound,

    // ── تسجيل الحضور (خصم حصة) ──
    @Default(ActivitiesStatus.initial) ActivitiesStatus checkinStatus,
    ActivityCheckinResponseModel? checkinData,

    /// النشاط اللي بيتسجّل له حضور حالياً (عشان الـ loading على زراره بس).
    int? checkinActivityId,

    @Default(ActivitiesStatus.initial) ActivitiesStatus subscribeStatus,
    MakeActivitySubResponseModel? subscriptionData,

    /// ملخص نتيجة التسجيل في أكتر من نشاط (نجاح/فشل كل نشاط).
    String? subscribeMessage,
    String? errorMessage,
  }) = _ActivitiesState;
}
