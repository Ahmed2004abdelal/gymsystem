// import 'package:bloc/bloc.dart';
// import 'package:gymsystem/core/networking/api_result.dart';
// import 'package:gymsystem/features/activities/data/repos/activities_repo.dart';
// import 'package:gymsystem/features/home/data/models/member_show_card_model.dart';
// import 'package:gymsystem/features/member%20info/data/repos/member_info_repo.dart';
// import 'package:gymsystem/features/member%20info/logic/member_info_state.dart';
// import 'package:gymsystem/features/register%20screen/data/models/create_member_model.dart';

// /// الاستخدام:
// /// BlocProvider(
// ///   create: (_) => MemberInfoCubit(
// ///     getIt<MemberInfoRepo>(),
// ///     getIt<ActivitiesRepo>(),
// ///     memberCode: code,
// ///     initialMember: member, // اختياري: لو معاك الداتا تظهر فوراً
// ///   )..load(),
// /// )
// class MemberInfoCubit extends Cubit<MemberInfoState> {
//   final MemberInfoRepo _repo;
//   final ActivitiesRepo _activitiesRepo;
//   final String memberCode;

//   MemberInfoCubit(
//     this._repo,
//     this._activitiesRepo, {
//     required this.memberCode,
//     MemberShowCardModel? initialMember,
//   }) : super(
//          MemberInfoState(
//            member: initialMember,
//            memberStatus: initialMember == null
//                ? InfoStatus.initial
//                : InfoStatus.success,
//          ),
//        );

//   // ───────────────────────── Load ─────────────────────────

//   /// بيحمّل كل حاجة. لو الداتا الأساسية موجودة بنعرضها فوراً ونجيب
//   /// الاشتراكات والحضور والأنشطة بالتوازي من غير ما ننتظر.
//   Future<void> load() async {
//     final existing = state.member;
//     if (existing != null) {
//       await Future.wait([
//         _loadMember(silent: true),
//         _loadSubscriptions(existing.id),
//         _loadAttendance(existing.id),
//         _loadActivities(),
//       ]);
//       return;
//     }

//     final member = await _loadMember();
//     if (member == null || isClosed) return;
//     await Future.wait([
//       _loadSubscriptions(member.id),
//       _loadAttendance(member.id),
//       _loadActivities(),
//     ]);
//   }

//   Future<MemberShowCardModel?> _loadMember({bool silent = false}) async {
//     if (!silent || state.member == null) {
//       emit(state.copyWith(memberStatus: InfoStatus.loading, memberError: null));
//     }
//     final result = await _repo.memberinfo(memberCode);
//     if (isClosed) return null;

//     MemberShowCardModel? loaded;
//     result.when(
//       success: (data) {
//         loaded = data;
//         emit(
//           state.copyWith(
//             memberStatus: InfoStatus.success,
//             member: data,
//             memberError: null,
//           ),
//         );
//       },
//       failure: (error) {
//         // لو عندنا داتا قديمة منقلبش الشاشة لخطأ في التحديث الصامت.
//         if (silent && state.member != null) return;
//         emit(
//           state.copyWith(
//             memberStatus: InfoStatus.failure,
//             memberError: error.apiErrorModel.getAllErrorMessages(),
//           ),
//         );
//       },
//     );
//     return loaded;
//   }

//   Future<void> _loadSubscriptions(int memberId) async {
//     if (state.subscriptions.isEmpty) {
//       emit(
//         state.copyWith(
//           subscriptionsStatus: InfoStatus.loading,
//           subscriptionsError: null,
//         ),
//       );
//     }
//     final result = await _repo.memberSubscriptions(memberId);
//     if (isClosed) return;
//     result.when(
//       success: (data) => emit(
//         state.copyWith(
//           subscriptionsStatus: InfoStatus.success,
//           subscriptions: data,
//           subscriptionsError: null,
//         ),
//       ),
//       failure: (error) => emit(
//         state.copyWith(
//           subscriptionsStatus: InfoStatus.failure,
//           subscriptionsError: error.apiErrorModel.getAllErrorMessages(),
//         ),
//       ),
//     );
//   }

//   Future<void> _loadAttendance(int memberId) async {
//     if (state.attendance.isEmpty) {
//       emit(
//         state.copyWith(
//           attendanceStatus: InfoStatus.loading,
//           attendanceError: null,
//         ),
//       );
//     }
//     final result = await _repo.memberAttendance(memberId);
//     if (isClosed) return;
//     result.when(
//       success: (data) => emit(
//         state.copyWith(
//           attendanceStatus: InfoStatus.success,
//           attendance: data,
//           attendanceError: null,
//         ),
//       ),
//       failure: (error) => emit(
//         state.copyWith(
//           attendanceStatus: InfoStatus.failure,
//           attendanceError: error.apiErrorModel.getAllErrorMessages(),
//         ),
//       ),
//     );
//   }

//   /// الأنشطة المشترك فيها العضو (بالكود).
//   Future<void> _loadActivities() async {
//     if (state.activities.isEmpty) {
//       emit(
//         state.copyWith(
//           activitiesStatus: InfoStatus.loading,
//           activitiesError: null,
//         ),
//       );
//     }
//     final result = await _activitiesRepo.memberActivitiesAttendance(memberCode);
//     if (isClosed) return;
//     result.when(
//       success: (data) => emit(
//         state.copyWith(
//           activitiesStatus: InfoStatus.success,
//           activities: data,
//           activitiesError: null,
//         ),
//       ),
//       failure: (error) => emit(
//         state.copyWith(
//           activitiesStatus: InfoStatus.failure,
//           activitiesError: error.apiErrorModel.getAllErrorMessages(),
//         ),
//       ),
//     );
//   }

//   /// إعادة محاولة قسم واحد بس من غير ما نلمس الباقي.
//   Future<void> retrySubscriptions() async {
//     final id = state.member?.id;
//     if (id != null) await _loadSubscriptions(id);
//   }

//   Future<void> retryAttendance() async {
//     final id = state.member?.id;
//     if (id != null) await _loadAttendance(id);
//   }

//   Future<void> retryActivities() => _loadActivities();

//   Future<void> retryMember() async {
//     final member = await _loadMember();
//     if (member == null || isClosed) return;
//     await Future.wait([
//       _loadSubscriptions(member.id),
//       _loadAttendance(member.id),
//       _loadActivities(),
//     ]);
//   }

//   // ───────────────────────── Update ─────────────────────────

//   Future<void> updateMember(CreateMemberModel model) async {
//     final member = state.member;
//     if (member == null || state.updateStatus == InfoStatus.loading) return;

//     emit(state.copyWith(updateStatus: InfoStatus.loading, actionError: null));
//     final result = await _repo.updateMember(member.id, model);
//     if (isClosed) return;

//     var ok = false;
//     result.when(
//       success: (_) => ok = true,
//       failure: (error) => emit(
//         state.copyWith(
//           updateStatus: InfoStatus.failure,
//           actionError: error.apiErrorModel.getAllErrorMessages(),
//         ),
//       ),
//     );
//     if (!ok) return;

//     emit(state.copyWith(updateStatus: InfoStatus.success));
//     await _loadMember(silent: true); // نحدّث بيانات العضو بالقيم الجديدة
//   }

//   // ───────────────────────── Delete ─────────────────────────

//   Future<void> deleteMember() async {
//     final member = state.member;
//     if (member == null || state.deleteStatus == InfoStatus.loading) return;

//     emit(state.copyWith(deleteStatus: InfoStatus.loading, actionError: null));
//     final result = await _repo.deleteMember(member.id);
//     if (isClosed) return;

//     result.when(
//       success: (_) => emit(state.copyWith(deleteStatus: InfoStatus.success)),
//       failure: (error) => emit(
//         state.copyWith(
//           deleteStatus: InfoStatus.failure,
//           actionError: error.apiErrorModel.getAllErrorMessages(),
//         ),
//       ),
//     );
//   }
// }

import 'package:bloc/bloc.dart';
import 'package:gymsystem/core/networking/api_result.dart';
import 'package:gymsystem/features/activities/data/repos/activities_repo.dart';
import 'package:gymsystem/features/home/data/models/member_show_card_model.dart';
import 'package:gymsystem/features/member%20info/data/repos/member_info_repo.dart';
import 'package:gymsystem/features/member%20info/logic/member_info_state.dart';
import 'package:gymsystem/features/register%20screen/data/models/create_member_model.dart';

/// الاستخدام:
/// BlocProvider(
///   create: (_) => MemberInfoCubit(
///     getIt<MemberInfoRepo>(),
///     getIt<ActivitiesRepo>(),
///     memberCode: code,
///     initialMember: member, // اختياري: لو معاك الداتا تظهر فوراً
///   )..load(),
/// )
class MemberInfoCubit extends Cubit<MemberInfoState> {
  final MemberInfoRepo _repo;
  final ActivitiesRepo _activitiesRepo;
  final String memberCode;

  MemberInfoCubit(
    this._repo,
    this._activitiesRepo, {
    required this.memberCode,
    MemberShowCardModel? initialMember,
  }) : super(
         MemberInfoState(
           member: initialMember,
           memberStatus: initialMember == null
               ? InfoStatus.initial
               : InfoStatus.success,
         ),
       );

  // ───────────────────────── Load ─────────────────────────

  /// بيحمّل كل حاجة. لو الداتا الأساسية موجودة بنعرضها فوراً ونجيب
  /// الاشتراكات والحضور والأنشطة بالتوازي من غير ما ننتظر.
  Future<void> load() async {
    final existing = state.member;
    if (existing != null) {
      await Future.wait([
        _loadMember(silent: true),
        _loadSubscriptions(existing.id),
        _loadAttendance(existing.id),
        _loadActivities(),
      ]);
      return;
    }

    final member = await _loadMember();
    if (member == null || isClosed) return;
    await Future.wait([
      _loadSubscriptions(member.id),
      _loadAttendance(member.id),
      _loadActivities(),
    ]);
  }

  Future<MemberShowCardModel?> _loadMember({bool silent = false}) async {
    if (!silent || state.member == null) {
      emit(state.copyWith(memberStatus: InfoStatus.loading, memberError: null));
    }
    final result = await _repo.memberinfo(memberCode);
    if (isClosed) return null;

    MemberShowCardModel? loaded;
    result.when(
      success: (data) {
        loaded = data;
        emit(
          state.copyWith(
            memberStatus: InfoStatus.success,
            member: data,
            memberError: null,
          ),
        );
      },
      failure: (error) {
        // لو عندنا داتا قديمة منقلبش الشاشة لخطأ في التحديث الصامت.
        if (silent && state.member != null) return;
        emit(
          state.copyWith(
            memberStatus: InfoStatus.failure,
            memberError: error.apiErrorModel.getAllErrorMessages(),
          ),
        );
      },
    );
    return loaded;
  }

  Future<void> _loadSubscriptions(int memberId) async {
    if (state.subscriptions.isEmpty) {
      emit(
        state.copyWith(
          subscriptionsStatus: InfoStatus.loading,
          subscriptionsError: null,
        ),
      );
    }
    final result = await _repo.memberSubscriptions(memberId);
    if (isClosed) return;
    result.when(
      success: (data) => emit(
        state.copyWith(
          subscriptionsStatus: InfoStatus.success,
          // الأحدث أولاً
          subscriptions: [...data]
            ..sort((a, b) => b.startDate.compareTo(a.startDate)),
          subscriptionsError: null,
        ),
      ),
      failure: (error) => emit(
        state.copyWith(
          subscriptionsStatus: InfoStatus.failure,
          subscriptionsError: error.apiErrorModel.getAllErrorMessages(),
        ),
      ),
    );
  }

  Future<void> _loadAttendance(int memberId) async {
    if (state.attendance.isEmpty) {
      emit(
        state.copyWith(
          attendanceStatus: InfoStatus.loading,
          attendanceError: null,
        ),
      );
    }
    final result = await _repo.memberAttendance(memberId);
    if (isClosed) return;
    result.when(
      success: (data) => emit(
        state.copyWith(
          attendanceStatus: InfoStatus.success,
          // الأحدث أولاً
          attendance: [...data]
            ..sort((a, b) => b.checkInTime.compareTo(a.checkInTime)),
          attendanceError: null,
        ),
      ),
      failure: (error) => emit(
        state.copyWith(
          attendanceStatus: InfoStatus.failure,
          attendanceError: error.apiErrorModel.getAllErrorMessages(),
        ),
      ),
    );
  }

  /// الأنشطة المشترك فيها العضو (بالكود).
  Future<void> _loadActivities() async {
    if (state.activities.isEmpty) {
      emit(
        state.copyWith(
          activitiesStatus: InfoStatus.loading,
          activitiesError: null,
        ),
      );
    }
    final result = await _activitiesRepo.memberActivitiesAttendance(memberCode);
    if (isClosed) return;
    result.when(
      success: (data) => emit(
        state.copyWith(
          activitiesStatus: InfoStatus.success,
          // الأحدث أولاً (بتاريخ الانتهاء)
          activities: [...data]..sort((a, b) => b.endDate.compareTo(a.endDate)),
          activitiesError: null,
        ),
      ),
      failure: (error) => emit(
        state.copyWith(
          activitiesStatus: InfoStatus.failure,
          activitiesError: error.apiErrorModel.getAllErrorMessages(),
        ),
      ),
    );
  }

  /// إعادة محاولة قسم واحد بس من غير ما نلمس الباقي.
  Future<void> retrySubscriptions() async {
    final id = state.member?.id;
    if (id != null) await _loadSubscriptions(id);
  }

  Future<void> retryAttendance() async {
    final id = state.member?.id;
    if (id != null) await _loadAttendance(id);
  }

  Future<void> retryActivities() => _loadActivities();

  Future<void> retryMember() async {
    final member = await _loadMember();
    if (member == null || isClosed) return;
    await Future.wait([
      _loadSubscriptions(member.id),
      _loadAttendance(member.id),
      _loadActivities(),
    ]);
  }

  // ───────────────────────── Update ─────────────────────────

  Future<void> updateMember(CreateMemberModel model) async {
    final member = state.member;
    if (member == null || state.updateStatus == InfoStatus.loading) return;

    emit(state.copyWith(updateStatus: InfoStatus.loading, actionError: null));
    final result = await _repo.updateMember(member.id, model);
    if (isClosed) return;

    var ok = false;
    result.when(
      success: (_) => ok = true,
      failure: (error) => emit(
        state.copyWith(
          updateStatus: InfoStatus.failure,
          actionError: error.apiErrorModel.getAllErrorMessages(),
        ),
      ),
    );
    if (!ok) return;

    emit(state.copyWith(updateStatus: InfoStatus.success));
    await _loadMember(silent: true); // نحدّث بيانات العضو بالقيم الجديدة
  }

  // ───────────────────────── Delete ─────────────────────────

  Future<void> deleteMember() async {
    final member = state.member;
    if (member == null || state.deleteStatus == InfoStatus.loading) return;

    emit(state.copyWith(deleteStatus: InfoStatus.loading, actionError: null));
    final result = await _repo.deleteMember(member.id);
    if (isClosed) return;

    result.when(
      success: (_) => emit(state.copyWith(deleteStatus: InfoStatus.success)),
      failure: (error) => emit(
        state.copyWith(
          deleteStatus: InfoStatus.failure,
          actionError: error.apiErrorModel.getAllErrorMessages(),
        ),
      ),
    );
  }
}
