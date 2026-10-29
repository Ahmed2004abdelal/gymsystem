// import 'package:freezed_annotation/freezed_annotation.dart';
// import 'package:gymsystem/features/register%20screen/data/models/activities_model.dart';
// import 'package:gymsystem/features/register%20screen/data/models/gym_subscription_response_model.dart';
// import 'package:gymsystem/features/register%20screen/data/models/member_details_model.dart';
// import 'package:gymsystem/features/register%20screen/data/models/package_model.dart';
// import 'package:gymsystem/features/register%20screen/data/models/trainers_model.dart';

// part 'register_member_state.freezed.dart';

// enum RegisterStatus { initial, loading, success, failure }

// @freezed
// abstract class RegisterMemberState with _$RegisterMemberState {
//   const RegisterMemberState._();

//   const factory RegisterMemberState({
//     /// 1 = ذكر, 2 = أنثى (نفس قيم الـ API)
//     @Default(1) int gender,

//     // ── lookups (GET) ──
//     @Default(RegisterStatus.initial) RegisterStatus packagesStatus,
//     @Default(RegisterStatus.initial) RegisterStatus trainersStatus,
//     @Default(RegisterStatus.initial) RegisterStatus activitiesStatus,
//     @Default(<PackageModel>[]) List<PackageModel> packages,
//     @Default(<TrainersModel>[]) List<TrainersModel> trainers,
//     @Default(<ActivitiesModel>[]) List<ActivitiesModel> activities,
//     String? lookupsError,

//     // ── اختيارات المستخدم ──
//     PackageModel? selectedPackage,
//     TrainersModel? selectedTrainer,

//     // ── الخطوة 1: إنشاء العضو ──
//     @Default(RegisterStatus.initial) RegisterStatus createMemberStatus,
//     MemberDetailsModel? createdMember,

//     // ── الخطوة 2: الاشتراك ──
//     @Default(RegisterStatus.initial) RegisterStatus subscriptionStatus,
//     GymSubscriptionResponseModel? subscription,

//     String? errorMessage,
//   }) = _RegisterMemberState;

//   bool get isMemberCreated => createdMember != null;
//   bool get isSubscribed => subscription != null;
//   bool get canSubmitSubscription =>
//       isMemberCreated && selectedPackage != null && !isSubscribed;
// }

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:gymsystem/features/activities/data/models/make_activity_sub_response_model.dart';
import 'package:gymsystem/features/register%20screen/data/models/activities_model.dart';
import 'package:gymsystem/features/register%20screen/data/models/gym_subscription_response_model.dart';
import 'package:gymsystem/features/register%20screen/data/models/member_details_model.dart';
import 'package:gymsystem/features/register%20screen/data/models/package_model.dart';
import 'package:gymsystem/features/register%20screen/data/models/trainers_model.dart';

part 'register_member_state.freezed.dart';

enum RegisterStatus { initial, loading, success, failure }

@freezed
abstract class RegisterMemberState with _$RegisterMemberState {
  const RegisterMemberState._();

  const factory RegisterMemberState({
    /// 1 = ذكر, 2 = أنثى (نفس قيم الـ API)
    @Default(1) int gender,

    // ── lookups (GET) ──
    @Default(RegisterStatus.initial) RegisterStatus packagesStatus,
    @Default(RegisterStatus.initial) RegisterStatus trainersStatus,
    @Default(RegisterStatus.initial) RegisterStatus activitiesStatus,
    @Default(<PackageModel>[]) List<PackageModel> packages,
    @Default(<TrainersModel>[]) List<TrainersModel> trainers,
    @Default(<ActivitiesModel>[]) List<ActivitiesModel> activities,
    String? lookupsError,

    // ── اختيارات المستخدم (كلها اختيارية) ──
    PackageModel? selectedPackage,
    TrainersModel? selectedTrainer,
    ActivitiesModel? selectedActivity,

    // ── الخطوة 1: إنشاء العضو ──
    @Default(RegisterStatus.initial) RegisterStatus createMemberStatus,
    MemberDetailsModel? createdMember,

    // ── الخطوة 2: اشتراك الجيم (باقة + مدرب) ──
    @Default(RegisterStatus.initial) RegisterStatus subscriptionStatus,
    GymSubscriptionResponseModel? subscription,

    // ── الخطوة 2: اشتراك النشاط ──
    @Default(RegisterStatus.initial) RegisterStatus activitySubStatus,
    MakeActivitySubResponseModel? activitySubscription,
    String? activityError,

    String? errorMessage,
  }) = _RegisterMemberState;

  bool get isMemberCreated => createdMember != null;

  /// اشتراك الجيم / النشاط اتعمل فعلاً.
  bool get isGymDone => subscription != null;
  bool get isActivityDone => activitySubscription != null;

  bool get isSubmitting =>
      subscriptionStatus == RegisterStatus.loading ||
      activitySubStatus == RegisterStatus.loading;

  /// فيه حاجة مختارة لسه ما اتنفذتش.
  bool get hasPending =>
      (selectedPackage != null && !isGymDone) ||
      (selectedActivity != null && !isActivityDone);

  /// اتنفذ اشتراك واحد على الأقل ومفيش حاجة معلّقة.
  bool get isCompleted => !hasPending && (isGymDone || isActivityDone);

  bool get canSubmit => isMemberCreated && hasPending && !isSubmitting;
}
