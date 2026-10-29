// // import 'package:flutter_bloc/flutter_bloc.dart';
// // import 'package:gymsystem/core/networking/api_result.dart';
// // import 'package:gymsystem/features/activities/data/models/activity_checkin_request_model.dart';
// // import 'package:gymsystem/features/activities/data/models/make_activity_sub_request_model.dart';
// // import 'package:gymsystem/features/activities/data/repos/activities_repo.dart';
// // import 'package:gymsystem/features/activities/logic/activities_state.dart';

// // class ActivitiesCubit extends Cubit<ActivitiesState> {
// //   final ActivitiesRepo _repo;

// //   ActivitiesCubit(this._repo) : super(const ActivitiesState());
// //   // ملحوظة: ActivitiesState بقت freezed، و copyWith بتقبل null صراحةً.

// //   Future<void> loadActivities() async {
// //     emit(
// //       state.copyWith(listStatus: ActivitiesStatus.loading, errorMessage: null),
// //     );
// //     final result = await _repo.getAvailableActivities();
// //     result.when(
// //       success: (data) => emit(
// //         state.copyWith(listStatus: ActivitiesStatus.success, activities: data),
// //       ),
// //       failure: (error) => emit(
// //         state.copyWith(
// //           listStatus: ActivitiesStatus.failure,
// //           errorMessage: error.apiErrorModel.getAllErrorMessages(),
// //         ),
// //       ),
// //     );
// //   }

// //   /// تسجيل حضور في نشاط (بيخصم حصة من اشتراك العضو).
// //   Future<void> checkin({
// //     required String memberCode,
// //     required int activityId,
// //   }) async {
// //     emit(
// //       state.copyWith(
// //         checkinStatus: ActivitiesStatus.loading,
// //         errorMessage: null,
// //       ),
// //     );
// //     final result = await _repo.activitiesCheckin(
// //       ActivityCheckinRequestModel(
// //         memberCode: memberCode,
// //         activityId: activityId,
// //       ),
// //     );
// //     result.when(
// //       success: (data) => emit(
// //         state.copyWith(
// //           checkinStatus: ActivitiesStatus.success,
// //           checkinData: data,
// //         ),
// //       ),
// //       failure: (error) => emit(
// //         state.copyWith(
// //           checkinStatus: ActivitiesStatus.failure,
// //           errorMessage: error.apiErrorModel.getAllErrorMessages(),
// //         ),
// //       ),
// //     );
// //   }

// //   /// تسجيل مشترك جديد في نشاط.
// //   Future<void> subscribe({
// //     required int memberId,
// //     required int activityId,
// //   }) async {
// //     emit(
// //       state.copyWith(
// //         subscribeStatus: ActivitiesStatus.loading,
// //         errorMessage: null,
// //       ),
// //     );
// //     final result = await _repo.makeActivitySubscription(
// //       MakeActivitySubRequestModel(memberId: memberId, activityId: activityId),
// //     );
// //     result.when(
// //       success: (data) => emit(
// //         state.copyWith(
// //           subscribeStatus: ActivitiesStatus.success,
// //           subscriptionData: data,
// //         ),
// //       ),
// //       failure: (error) => emit(
// //         state.copyWith(
// //           subscribeStatus: ActivitiesStatus.failure,
// //           errorMessage: error.apiErrorModel.getAllErrorMessages(),
// //         ),
// //       ),
// //     );
// //   }

// //   void resetSubscribe() =>
// //       emit(state.copyWith(subscribeStatus: ActivitiesStatus.initial));

// //   void resetCheckin() =>
// //       emit(state.copyWith(checkinStatus: ActivitiesStatus.initial));
// // }

// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:gymsystem/core/networking/api_result.dart';
// import 'package:gymsystem/features/activities/data/models/activity_checkin_request_model.dart';
// import 'package:gymsystem/features/activities/data/models/make_activity_sub_request_model.dart';
// import 'package:gymsystem/features/activities/data/repos/activities_repo.dart';
// import 'package:gymsystem/features/home/data/models/member_show_card_model.dart';
// import 'package:gymsystem/features/home/data/repos/reception_repo.dart';
// import 'package:gymsystem/features/activities/logic/activities_state.dart';

// class ActivitiesCubit extends Cubit<ActivitiesState> {
//   final ActivitiesRepo _repo;
//   final ReceptionRepo _receptionRepo;

//   ActivitiesCubit(this._repo, this._receptionRepo)
//     : super(const ActivitiesState());
//   // ملحوظة: ActivitiesState freezed، و copyWith بتقبل null صراحةً.

//   Future<void> loadActivities() async {
//     emit(
//       state.copyWith(listStatus: ActivitiesStatus.loading, errorMessage: null),
//     );
//     final result = await _repo.getAvailableActivities();
//     if (isClosed) return;
//     result.when(
//       success: (data) => emit(
//         state.copyWith(listStatus: ActivitiesStatus.success, activities: data),
//       ),
//       failure: (error) => emit(
//         state.copyWith(
//           listStatus: ActivitiesStatus.failure,
//           errorMessage: error.apiErrorModel.getAllErrorMessages(),
//         ),
//       ),
//     );
//   }

//   // ───────────────────────── Lookup by member code ─────────────────────────

//   /// 1) بيجيب بطاقة العضو (ReceptionRepo.memberShowCard)
//   ///      • مش موجود (404) → memberNotFound = true والشاشة بتحوّل لـ register
//   /// 2) لو موجود بيجيب اشتراكاته في الأنشطة (ممكن تكون فاضية).
//   Future<void> lookupMember(String code) async {
//     if (state.lookupStatus == ActivitiesStatus.loading) return;
//     emit(
//       state.copyWith(
//         lookupStatus: ActivitiesStatus.loading,
//         lookupCode: code,
//         memberCard: null,
//         memberActivities: const [],
//         memberNotFound: false,
//         errorMessage: null,
//       ),
//     );

//     final cardResult = await _receptionRepo.memberShowCard(code);
//     if (isClosed) return;

//     MemberShowCardModel? card;
//     String? cardError;
//     var notFound = false;
//     cardResult.when(
//       success: (data) {
//         card = data;
//       },
//       failure: (error) {
//         cardError = error.apiErrorModel.getAllErrorMessages();
//         notFound = _isNotFound(error.apiErrorModel.status, cardError);
//       },
//     );

//     if (card == null) {
//       emit(
//         state.copyWith(
//           lookupStatus: ActivitiesStatus.failure,
//           memberNotFound: notFound,
//           errorMessage: notFound ? null : cardError,
//         ),
//       );
//       return;
//     }

//     final actsResult = await _repo.memberActivitiesAttendance(code);
//     if (isClosed) return;
//     actsResult.when(
//       success: (data) => emit(
//         state.copyWith(
//           lookupStatus: ActivitiesStatus.success,
//           memberCard: card,
//           memberActivities: data,
//         ),
//       ),
//       // البطاقة تتعرض حتى لو اشتراكات الأنشطة فشلت
//       failure: (error) => emit(
//         state.copyWith(
//           lookupStatus: ActivitiesStatus.failure,
//           memberCard: card,
//           errorMessage: error.apiErrorModel.getAllErrorMessages(),
//         ),
//       ),
//     );
//   }

//   /// الكود مش متسجل: 404، أو رسالة السيرفر بتقول "غير موجود" / "not found"
//   /// (السيرفر ممكن يرجّع 400 أو 200 برسالة بدل 404).
//   bool _isNotFound(int? status, String? message) {
//     if (status == 404) return true;
//     final m = (message ?? '').toLowerCase();
//     return m.contains('غير موجود') ||
//         m.contains('لا يوجد') ||
//         m.contains('not found') ||
//         m.contains('notfound') ||
//         m.contains('does not exist');
//   }

//   /// بيفضّي نتيجة البحث (البطاقة والقائمة).
//   void clearLookup() => emit(
//     state.copyWith(
//       lookupStatus: ActivitiesStatus.initial,
//       lookupCode: null,
//       memberCard: null,
//       memberActivities: const [],
//       memberNotFound: false,
//     ),
//   );

//   /// تحديث الحصص المتبقية بعد الحضور من غير ما القائمة تفضى وترجع.
//   Future<void> _silentReload() async {
//     final code = state.lookupCode;
//     if (code == null) return;
//     final result = await _repo.memberActivitiesAttendance(code);
//     if (isClosed) return;
//     result.when(
//       success: (data) => emit(state.copyWith(memberActivities: data)),
//       failure: (_) {},
//     );
//   }

//   // ───────────────────────── Check-in ─────────────────────────

//   /// تسجيل حضور في نشاط (بيخصم حصة من اشتراك العضو).
//   Future<void> checkin({
//     required String memberCode,
//     required int activityId,
//   }) async {
//     if (state.checkinStatus == ActivitiesStatus.loading) return;
//     emit(
//       state.copyWith(
//         checkinStatus: ActivitiesStatus.loading,
//         checkinActivityId: activityId,
//         errorMessage: null,
//       ),
//     );
//     final result = await _repo.activitiesCheckin(
//       ActivityCheckinRequestModel(
//         memberCode: memberCode,
//         activityId: activityId,
//       ),
//     );
//     if (isClosed) return;
//     await result.when(
//       success: (data) async {
//         emit(
//           state.copyWith(
//             checkinStatus: ActivitiesStatus.success,
//             checkinData: data,
//           ),
//         );
//         await _silentReload(); // الحصص المتبقية تتحدّث
//       },
//       failure: (error) async => emit(
//         state.copyWith(
//           checkinStatus: ActivitiesStatus.failure,
//           errorMessage: error.apiErrorModel.getAllErrorMessages(),
//         ),
//       ),
//     );
//   }

//   /// تسجيل مشترك جديد في نشاط.
//   Future<void> subscribe({
//     required int memberId,
//     required int activityId,
//   }) async {
//     emit(
//       state.copyWith(
//         subscribeStatus: ActivitiesStatus.loading,
//         errorMessage: null,
//       ),
//     );
//     final result = await _repo.makeActivitySubscription(
//       MakeActivitySubRequestModel(memberId: memberId, activityId: activityId),
//     );
//     if (isClosed) return;
//     await result.when(
//       success: (data) async {
//         emit(
//           state.copyWith(
//             subscribeStatus: ActivitiesStatus.success,
//             subscriptionData: data,
//           ),
//         );
//         // لو ده العضو المعروض (تجديد) نحدّث اشتراكاته وحصصه
//         if (memberId == state.memberCard?.id) await _silentReload();
//       },
//       failure: (error) async => emit(
//         state.copyWith(
//           subscribeStatus: ActivitiesStatus.failure,
//           errorMessage: error.apiErrorModel.getAllErrorMessages(),
//         ),
//       ),
//     );
//   }

//   /// تسجيل العضو في أكتر من نشاط مرة واحدة (واحد ورا التاني).
//   /// لو نجح واحد على الأقل = success، والرسالة بتلخّص اللي نجح واللي فشل.
//   Future<void> subscribeMany({
//     required int memberId,
//     required List<int> activityIds,
//   }) async {
//     if (state.subscribeStatus == ActivitiesStatus.loading ||
//         activityIds.isEmpty) {
//       return;
//     }
//     emit(
//       state.copyWith(
//         subscribeStatus: ActivitiesStatus.loading,
//         subscribeMessage: null,
//         errorMessage: null,
//       ),
//     );

//     String nameOf(int id) {
//       for (final a in state.activities) {
//         if (a.id == id) return a.name;
//       }
//       return '#$id';
//     }

//     final done = <String>[];
//     final failed = <String>[];
//     var memberName = '';

//     for (final id in activityIds) {
//       final result = await _repo.makeActivitySubscription(
//         MakeActivitySubRequestModel(memberId: memberId, activityId: id),
//       );
//       if (isClosed) return;
//       result.when(
//         success: (data) {
//           memberName = data.memberName;
//           done.add(data.activityName);
//         },
//         failure: (error) {
//           failed.add(
//             '${nameOf(id)}: ${error.apiErrorModel.getAllErrorMessages()}',
//           );
//         },
//       );
//     }

//     if (done.isEmpty) {
//       emit(
//         state.copyWith(
//           subscribeStatus: ActivitiesStatus.failure,
//           errorMessage: failed.join('\n'),
//         ),
//       );
//       return;
//     }

//     final buffer = StringBuffer('تم تسجيل $memberName في: ${done.join('، ')}');
//     if (failed.isNotEmpty) {
//       buffer.write('\nتعذر: ${failed.join('، ')}');
//     }
//     emit(
//       state.copyWith(
//         subscribeStatus: ActivitiesStatus.success,
//         subscribeMessage: buffer.toString(),
//       ),
//     );
//     if (memberId == state.memberCard?.id) await _silentReload();
//   }

//   void resetSubscribe() =>
//       emit(state.copyWith(subscribeStatus: ActivitiesStatus.initial));

//   void resetCheckin() => emit(
//     state.copyWith(
//       checkinStatus: ActivitiesStatus.initial,
//       checkinActivityId: null,
//     ),
//   );
// }

// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:gymsystem/core/networking/api_result.dart';
// import 'package:gymsystem/features/activities/data/models/activity_checkin_request_model.dart';
// import 'package:gymsystem/features/activities/data/models/make_activity_sub_request_model.dart';
// import 'package:gymsystem/features/activities/data/repos/activities_repo.dart';
// import 'package:gymsystem/features/activities/logic/activities_state.dart';

// class ActivitiesCubit extends Cubit<ActivitiesState> {
//   final ActivitiesRepo _repo;

//   ActivitiesCubit(this._repo) : super(const ActivitiesState());
//   // ملحوظة: ActivitiesState بقت freezed، و copyWith بتقبل null صراحةً.

//   Future<void> loadActivities() async {
//     emit(
//       state.copyWith(listStatus: ActivitiesStatus.loading, errorMessage: null),
//     );
//     final result = await _repo.getAvailableActivities();
//     result.when(
//       success: (data) => emit(
//         state.copyWith(listStatus: ActivitiesStatus.success, activities: data),
//       ),
//       failure: (error) => emit(
//         state.copyWith(
//           listStatus: ActivitiesStatus.failure,
//           errorMessage: error.apiErrorModel.getAllErrorMessages(),
//         ),
//       ),
//     );
//   }

//   /// تسجيل حضور في نشاط (بيخصم حصة من اشتراك العضو).
//   Future<void> checkin({
//     required String memberCode,
//     required int activityId,
//   }) async {
//     emit(
//       state.copyWith(
//         checkinStatus: ActivitiesStatus.loading,
//         errorMessage: null,
//       ),
//     );
//     final result = await _repo.activitiesCheckin(
//       ActivityCheckinRequestModel(
//         memberCode: memberCode,
//         activityId: activityId,
//       ),
//     );
//     result.when(
//       success: (data) => emit(
//         state.copyWith(
//           checkinStatus: ActivitiesStatus.success,
//           checkinData: data,
//         ),
//       ),
//       failure: (error) => emit(
//         state.copyWith(
//           checkinStatus: ActivitiesStatus.failure,
//           errorMessage: error.apiErrorModel.getAllErrorMessages(),
//         ),
//       ),
//     );
//   }

//   /// تسجيل مشترك جديد في نشاط.
//   Future<void> subscribe({
//     required int memberId,
//     required int activityId,
//   }) async {
//     emit(
//       state.copyWith(
//         subscribeStatus: ActivitiesStatus.loading,
//         errorMessage: null,
//       ),
//     );
//     final result = await _repo.makeActivitySubscription(
//       MakeActivitySubRequestModel(memberId: memberId, activityId: activityId),
//     );
//     result.when(
//       success: (data) => emit(
//         state.copyWith(
//           subscribeStatus: ActivitiesStatus.success,
//           subscriptionData: data,
//         ),
//       ),
//       failure: (error) => emit(
//         state.copyWith(
//           subscribeStatus: ActivitiesStatus.failure,
//           errorMessage: error.apiErrorModel.getAllErrorMessages(),
//         ),
//       ),
//     );
//   }

//   void resetSubscribe() =>
//       emit(state.copyWith(subscribeStatus: ActivitiesStatus.initial));

//   void resetCheckin() =>
//       emit(state.copyWith(checkinStatus: ActivitiesStatus.initial));
// }

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gymsystem/core/networking/api_result.dart';
import 'package:gymsystem/features/activities/data/models/activity_checkin_request_model.dart';
import 'package:gymsystem/features/activities/data/models/make_activity_sub_request_model.dart';
import 'package:gymsystem/features/activities/data/repos/activities_repo.dart';
import 'package:gymsystem/features/home/data/models/member_show_card_model.dart';
import 'package:gymsystem/features/home/data/repos/reception_repo.dart';
import 'package:gymsystem/features/activities/logic/activities_state.dart';

class ActivitiesCubit extends Cubit<ActivitiesState> {
  final ActivitiesRepo _repo;
  final ReceptionRepo _receptionRepo;

  ActivitiesCubit(this._repo, this._receptionRepo)
    : super(const ActivitiesState());
  // ملحوظة: ActivitiesState freezed، و copyWith بتقبل null صراحةً.

  Future<void> loadActivities() async {
    emit(
      state.copyWith(listStatus: ActivitiesStatus.loading, errorMessage: null),
    );
    final result = await _repo.getAvailableActivities();
    if (isClosed) return;
    result.when(
      success: (data) => emit(
        state.copyWith(listStatus: ActivitiesStatus.success, activities: data),
      ),
      failure: (error) => emit(
        state.copyWith(
          listStatus: ActivitiesStatus.failure,
          errorMessage: error.apiErrorModel.getAllErrorMessages(),
        ),
      ),
    );
  }

  // ───────────────────────── Lookup by member code ─────────────────────────

  /// 1) بيجيب بطاقة العضو (ReceptionRepo.memberShowCard)
  ///      • مش موجود (404) → memberNotFound = true والشاشة بتحوّل لـ register
  /// 2) لو موجود بيجيب اشتراكاته في الأنشطة (ممكن تكون فاضية).
  Future<void> lookupMember(String code) async {
    if (state.lookupStatus == ActivitiesStatus.loading) return;
    emit(
      state.copyWith(
        lookupStatus: ActivitiesStatus.loading,
        lookupCode: code,
        memberCard: null,
        memberActivities: const [],
        memberNotFound: false,
        errorMessage: null,
      ),
    );

    final cardResult = await _receptionRepo.memberShowCard(code);
    if (isClosed) return;

    MemberShowCardModel? card;
    String? cardError;
    var notFound = false;
    cardResult.when(
      success: (data) {
        card = data;
      },
      failure: (error) {
        cardError = error.apiErrorModel.getAllErrorMessages();
        notFound = _isNotFound(error.apiErrorModel.status, cardError);
      },
    );

    if (card == null) {
      emit(
        state.copyWith(
          lookupStatus: ActivitiesStatus.failure,
          memberNotFound: notFound,
          errorMessage: notFound ? null : cardError,
        ),
      );
      return;
    }

    final actsResult = await _repo.memberActivitiesAttendance(code);
    if (isClosed) return;
    actsResult.when(
      success: (data) => emit(
        state.copyWith(
          lookupStatus: ActivitiesStatus.success,
          memberCard: card,
          memberActivities: data,
        ),
      ),
      // البطاقة تتعرض حتى لو اشتراكات الأنشطة فشلت
      failure: (error) => emit(
        state.copyWith(
          lookupStatus: ActivitiesStatus.failure,
          memberCard: card,
          errorMessage: error.apiErrorModel.getAllErrorMessages(),
        ),
      ),
    );
  }

  /// الكود مش متسجل: 404، أو رسالة السيرفر بتقول "غير موجود" / "not found"
  /// (السيرفر ممكن يرجّع 400 أو 200 برسالة بدل 404).
  bool _isNotFound(int? status, String? message) {
    if (status == 404) return true;
    final m = (message ?? '').toLowerCase();
    return m.contains('غير موجود') ||
        m.contains('لا يوجد') ||
        m.contains('not found') ||
        m.contains('notfound') ||
        m.contains('does not exist');
  }

  /// بيفضّي نتيجة البحث (البطاقة والقائمة).
  void clearLookup() => emit(
    state.copyWith(
      lookupStatus: ActivitiesStatus.initial,
      lookupCode: null,
      memberCard: null,
      memberActivities: const [],
      memberNotFound: false,
    ),
  );

  /// تحديث الحصص المتبقية بعد الحضور من غير ما القائمة تفضى وترجع.
  Future<void> _silentReload() async {
    final code = state.lookupCode;
    if (code == null) return;
    final result = await _repo.memberActivitiesAttendance(code);
    if (isClosed) return;
    result.when(
      success: (data) => emit(state.copyWith(memberActivities: data)),
      failure: (_) {},
    );
  }

  // ───────────────────────── Check-in ─────────────────────────

  /// تسجيل حضور في نشاط (بيخصم حصة من اشتراك العضو).
  Future<void> checkin({
    required String memberCode,
    required int activityId,
  }) async {
    if (state.checkinStatus == ActivitiesStatus.loading) return;
    emit(
      state.copyWith(
        checkinStatus: ActivitiesStatus.loading,
        checkinActivityId: activityId,
        errorMessage: null,
      ),
    );
    final result = await _repo.activitiesCheckin(
      ActivityCheckinRequestModel(
        memberCode: memberCode,
        activityId: activityId,
      ),
    );
    if (isClosed) return;
    await result.when(
      success: (data) async {
        emit(
          state.copyWith(
            checkinStatus: ActivitiesStatus.success,
            checkinData: data,
          ),
        );
        await _silentReload(); // الحصص المتبقية تتحدّث
      },
      failure: (error) async => emit(
        state.copyWith(
          checkinStatus: ActivitiesStatus.failure,
          errorMessage: error.apiErrorModel.getAllErrorMessages(),
        ),
      ),
    );
  }

  /// تسجيل مشترك جديد في نشاط.
  Future<void> subscribe({
    required int memberId,
    required int activityId,
  }) async {
    emit(
      state.copyWith(
        subscribeStatus: ActivitiesStatus.loading,
        errorMessage: null,
      ),
    );
    final result = await _repo.makeActivitySubscription(
      MakeActivitySubRequestModel(memberId: memberId, activityId: activityId),
    );
    if (isClosed) return;
    await result.when(
      success: (data) async {
        emit(
          state.copyWith(
            subscribeStatus: ActivitiesStatus.success,
            subscriptionData: data,
          ),
        );
        // لو ده العضو المعروض (تجديد) نحدّث اشتراكاته وحصصه
        if (memberId == state.memberCard?.id) await _silentReload();
      },
      failure: (error) async => emit(
        state.copyWith(
          subscribeStatus: ActivitiesStatus.failure,
          errorMessage: error.apiErrorModel.getAllErrorMessages(),
        ),
      ),
    );
  }

  /// تسجيل العضو في أكتر من نشاط مرة واحدة (واحد ورا التاني).
  /// لو نجح واحد على الأقل = success، والرسالة بتلخّص اللي نجح واللي فشل.
  Future<void> subscribeMany({
    required int memberId,
    required List<int> activityIds,
  }) async {
    if (state.subscribeStatus == ActivitiesStatus.loading ||
        activityIds.isEmpty) {
      return;
    }
    emit(
      state.copyWith(
        subscribeStatus: ActivitiesStatus.loading,
        subscribeMessage: null,
        errorMessage: null,
      ),
    );

    String nameOf(int id) {
      for (final a in state.activities) {
        if (a.id == id) return a.name;
      }
      return '#$id';
    }

    final done = <String>[];
    final failed = <String>[];
    var memberName = '';

    for (final id in activityIds) {
      final result = await _repo.makeActivitySubscription(
        MakeActivitySubRequestModel(memberId: memberId, activityId: id),
      );
      if (isClosed) return;
      result.when(
        success: (data) {
          memberName = data.memberName;
          done.add(data.activityName);
        },
        failure: (error) {
          failed.add(
            '${nameOf(id)}: ${error.apiErrorModel.getAllErrorMessages()}',
          );
        },
      );
    }

    if (done.isEmpty) {
      emit(
        state.copyWith(
          subscribeStatus: ActivitiesStatus.failure,
          errorMessage: failed.join('\n'),
        ),
      );
      return;
    }

    final buffer = StringBuffer('تم تسجيل $memberName في: ${done.join('، ')}');
    if (failed.isNotEmpty) {
      buffer.write('\nتعذر: ${failed.join('، ')}');
    }
    emit(
      state.copyWith(
        subscribeStatus: ActivitiesStatus.success,
        subscribeMessage: buffer.toString(),
      ),
    );
    if (memberId == state.memberCard?.id) await _silentReload();
  }

  void resetSubscribe() =>
      emit(state.copyWith(subscribeStatus: ActivitiesStatus.initial));

  void resetCheckin() => emit(
    state.copyWith(
      checkinStatus: ActivitiesStatus.initial,
      checkinActivityId: null,
    ),
  );
}
