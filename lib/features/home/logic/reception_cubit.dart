// import 'package:bloc/bloc.dart';
// import 'package:gymsystem/core/networking/api_result.dart';
// import 'package:gymsystem/features/home/data/repos/attendance_table_repo.dart';
// import 'package:gymsystem/features/home/data/repos/reception_repo.dart';
// import 'package:gymsystem/features/home/logic/reception_state.dart';

// class ReceptionCubit extends Cubit<ReceptionState> {
//   final ReceptionRepo _receptionRepo;
//   final AttendanceTableRepo _attendanceTableRepo;
//   ReceptionCubit(this._receptionRepo, this._attendanceTableRepo)
//     : super(const ReceptionState()) {
//     liveAttendance();
//     firstFiveAttendances();
//   }

//   Future<void> memberCheckin(String memberCode) async {
//     if (state.memberCheckinStatus == ReceptionStatus.loading) return;

//     // نفضّي البطاقة القديمة قبل أي فحص جديد
//     emit(
//       state.copyWith(
//         memberCheckinStatus: ReceptionStatus.loading,
//         memberShowCardStatus: ReceptionStatus.initial,
//         memberLogedinStatus: ReceptionStatus.initial,
//         memberShowCardData: null,
//         errorMessage: null,
//       ),
//     );

//     final result = await _receptionRepo.membersCheckinByCode(memberCode);
//     if (isClosed) return;

//     await result.when(
//       success: (data) async {
//         final exists = data.exists == true;
//         emit(
//           state.copyWith(
//             memberCheckinStatus: ReceptionStatus.success,
//             memberCheckinData: data,
//             memberShowCardStatus: exists
//                 ? ReceptionStatus.loading
//                 : ReceptionStatus.initial,
//           ),
//         );
//         if (exists) await memberShowCard(data.memberCode ?? memberCode);
//       },
//       failure: (error) async {
//         emit(
//           state.copyWith(
//             memberCheckinStatus: ReceptionStatus.failure,
//             errorMessage: error.apiErrorModel.getAllErrorMessages(),
//           ),
//         );
//       },
//     );
//   }

//   Future<void> memberShowCard(String memberCode) async {
//     emit(state.copyWith(memberShowCardStatus: ReceptionStatus.loading));
//     final result = await _receptionRepo.memberShowCard(memberCode);
//     if (isClosed) return;

//     result.when(
//       success: (data) => emit(
//         state.copyWith(
//           memberShowCardStatus: ReceptionStatus.success,
//           memberShowCardData: data,
//         ),
//       ),
//       failure: (error) => emit(
//         state.copyWith(
//           memberShowCardStatus: ReceptionStatus.failure,
//           errorMessage: error.apiErrorModel.getAllErrorMessages(),
//         ),
//       ),
//     );
//   }

//   Future<void> memberLogedin() async {
//     emit(state.copyWith(memberLogedinStatus: ReceptionStatus.loading));
//     final m = state.memberShowCardData;
//     if (m != null &&
//         (m.totalSessions ?? 0) > 0 &&
//         (m.remainingSessions ?? 0) <= 0) {
//       emit(
//         state.copyWith(
//           memberLogedinStatus: ReceptionStatus.failure,
//           errorMessage: 'تم نفاد الحصص المتاحة',
//         ),
//       );
//       return;
//     }
//     final member = state.memberShowCardData;
//     if (member == null) {
//       emit(
//         state.copyWith(
//           memberLogedinStatus: ReceptionStatus.failure,
//           errorMessage: "Member code is null",
//         ),
//       );
//       return;
//     }
//     final result = await _receptionRepo.memberLogedin(member.code);

//     if (isClosed) return;
//     result.when(
//       success: (data) {
//         final sessions = member.remainingSessions;
//         emit(
//           state.copyWith(
//             memberLogedinStatus: ReceptionStatus.success,
//             memberShowCardData: member.copyWith(
//               remainingSessions: sessions == null
//                   ? null
//                   : (sessions - 1).clamp(0, sessions),
//               lastAttendanceTime: DateTime.now().toUtc(),
//             ),
//           ),
//         );
//       },
//       failure: (message) {
//         emit(
//           state.copyWith(
//             memberLogedinStatus: ReceptionStatus.failure,
//             errorMessage: message.apiErrorModel.getAllErrorMessages(),
//           ),
//         );
//       },
//     );
//   }

//   Future<void> liveAttendance() async {
//     emit(state.copyWith(liveAttendanceStatus: ReceptionStatus.loading));
//     final result = await _receptionRepo.liveAttendance();
//     if (isClosed) return;

//     result.when(
//       success: (data) => emit(
//         state.copyWith(
//           liveAttendanceStatus: ReceptionStatus.success,
//           liveAttendanceData: data,
//         ),
//       ),
//       failure: (error) => emit(
//         state.copyWith(
//           liveAttendanceStatus: ReceptionStatus.failure,
//           errorMessage: error.apiErrorModel.getAllErrorMessages(),
//         ),
//       ),
//     );
//   }

//   Future<void> sessionCheckIn() async {
//     emit(state.copyWith(sessionsCheckInStatus: ReceptionStatus.loading));
//     final result = await _receptionRepo.sessionsCheckIn();
//     if (isClosed) return;

//     result.when(
//       success: (data) =>
//           emit(state.copyWith(sessionsCheckInStatus: ReceptionStatus.success)),
//       failure: (error) => emit(
//         state.copyWith(
//           sessionsCheckInStatus: ReceptionStatus.failure,
//           errorMessage: error.apiErrorModel.getAllErrorMessages(),
//         ),
//       ),
//     );
//   }

//   Future<void> renewSubscription() async {
//     emit(state.copyWith(renewSubscriptionStatus: ReceptionStatus.loading));
//     final member = state.memberShowCardData;
//     if (member == null) {
//       emit(
//         state.copyWith(
//           renewSubscriptionStatus: ReceptionStatus.failure,
//           errorMessage: "Member code is null",
//         ),
//       );
//       return;
//     }
//     final result = await _receptionRepo.renewSubscription(member.id);

//     if (isClosed) return;
//     result.when(
//       success: (data) {
//         memberShowCard(member.code);
//         emit(state.copyWith(renewSubscriptionStatus: ReceptionStatus.success));
//       },
//       failure: (message) {
//         emit(
//           state.copyWith(
//             renewSubscriptionStatus: ReceptionStatus.failure,
//             errorMessage: message.apiErrorModel.getAllErrorMessages(),
//           ),
//         );
//       },
//     );
//   }

//   Future<void> firstFiveAttendances() async {
//     emit(state.copyWith(firstFiveAttendancesStatus: ReceptionStatus.loading));
//     final result = await _attendanceTableRepo.getAttendanceTable();
//     if (isClosed) return;

//     result.when(
//       success: (data) => emit(
//         state.copyWith(
//           firstFiveAttendancesStatus: ReceptionStatus.success,
//           fiveAttendancesData: data.items,
//         ),
//       ),
//       failure: (error) => emit(
//         state.copyWith(
//           firstFiveAttendancesStatus: ReceptionStatus.failure,
//           errorMessage: error.apiErrorModel.getAllErrorMessages(),
//         ),
//       ),
//     );
//   }
// }

import 'package:bloc/bloc.dart';
import 'package:gymsystem/core/helper/reverse_list.dart';
import 'package:gymsystem/core/networking/api_result.dart';
import 'package:gymsystem/features/home/data/repos/attendance_table_repo.dart';
import 'package:gymsystem/features/home/data/repos/reception_repo.dart';
import 'package:gymsystem/features/home/logic/reception_state.dart';

class ReceptionCubit extends Cubit<ReceptionState> {
  final ReceptionRepo _receptionRepo;
  final AttendanceTableRepo _attendanceTableRepo;
  ReceptionCubit(this._receptionRepo, this._attendanceTableRepo)
    : super(const ReceptionState()) {
    dailyVisitorsToday(); // سعر الحصة الفردية
    liveAttendance();
    firstFiveAttendances();
  }

  /// بيتنادى أول ما الـ app يفتح عشان نعرض سعر الحصة (feePerVisitor).
  Future<void> dailyVisitorsToday() async {
    emit(state.copyWith(dailyVisitorStatus: ReceptionStatus.loading));
    final result = await _receptionRepo.dailyVisitorsToday();
    if (isClosed) return;
    result.when(
      success: (data) => emit(
        state.copyWith(
          dailyVisitorStatus: ReceptionStatus.success,
          dailyVisitorData: data,
        ),
      ),
      failure: (error) => emit(
        state.copyWith(
          dailyVisitorStatus: ReceptionStatus.failure,
          errorMessage: error.apiErrorModel.getAllErrorMessages(),
        ),
      ),
    );
  }

  Future<void> memberCheckin(String memberCode) async {
    if (state.memberCheckinStatus == ReceptionStatus.loading) return;

    // نفضّي البطاقة القديمة قبل أي فحص جديد
    emit(
      state.copyWith(
        memberCheckinStatus: ReceptionStatus.loading,
        memberShowCardStatus: ReceptionStatus.initial,
        memberLogedinStatus: ReceptionStatus.initial,
        memberShowCardData: null,
        errorMessage: null,
      ),
    );

    final result = await _receptionRepo.membersCheckinByCode(memberCode);
    if (isClosed) return;

    await result.when(
      success: (data) async {
        final exists = data.exists == true;
        emit(
          state.copyWith(
            memberCheckinStatus: ReceptionStatus.success,
            memberCheckinData: data,
            memberShowCardStatus: exists
                ? ReceptionStatus.loading
                : ReceptionStatus.initial,
          ),
        );
        if (exists) await memberShowCard(data.memberCode ?? memberCode);
      },
      failure: (error) async {
        emit(
          state.copyWith(
            memberCheckinStatus: ReceptionStatus.failure,
            errorMessage: error.apiErrorModel.getAllErrorMessages(),
          ),
        );
      },
    );
  }

  Future<void> memberShowCard(String memberCode) async {
    emit(state.copyWith(memberShowCardStatus: ReceptionStatus.loading));
    final result = await _receptionRepo.memberShowCard(memberCode);
    if (isClosed) return;

    result.when(
      success: (data) => emit(
        state.copyWith(
          memberShowCardStatus: ReceptionStatus.success,
          memberShowCardData: data,
        ),
      ),
      failure: (error) => emit(
        state.copyWith(
          memberShowCardStatus: ReceptionStatus.failure,
          errorMessage: error.apiErrorModel.getAllErrorMessages(),
        ),
      ),
    );
  }

  Future<void> memberLogedin() async {
    emit(state.copyWith(memberLogedinStatus: ReceptionStatus.loading));
    final m = state.memberShowCardData;
    if (m != null &&
        (m.totalSessions ?? 0) > 0 &&
        (m.remainingSessions ?? 0) <= 0) {
      emit(
        state.copyWith(
          memberLogedinStatus: ReceptionStatus.failure,
          errorMessage: 'تم نفاد الحصص المتاحة',
        ),
      );
      return;
    }
    final member = state.memberShowCardData;
    if (member == null) {
      emit(
        state.copyWith(
          memberLogedinStatus: ReceptionStatus.failure,
          errorMessage: "Member code is null",
        ),
      );
      return;
    }
    final result = await _receptionRepo.memberLogedin(member.code);

    if (isClosed) return;
    result.when(
      success: (data) {
        final sessions = member.remainingSessions;
        emit(
          state.copyWith(
            memberLogedinStatus: ReceptionStatus.success,
            memberShowCardData: member.copyWith(
              remainingSessions: sessions == null
                  ? null
                  : (sessions - 1).clamp(0, sessions),
              lastAttendanceTime: DateTime.now().toUtc(),
            ),
          ),
        );
        // تسجيل الدخول نجح -> حدّث "داخل الصالة الآن" وسجل الدخول المباشر
        liveAttendance(silent: true);
        firstFiveAttendances(silent: true);
      },
      failure: (message) {
        emit(
          state.copyWith(
            memberLogedinStatus: ReceptionStatus.failure,
            errorMessage: message.apiErrorModel.getAllErrorMessages(),
          ),
        );
      },
    );
  }

  Future<void> liveAttendance({bool silent = false}) async {
    if (!silent) {
      emit(state.copyWith(liveAttendanceStatus: ReceptionStatus.loading));
    }
    final result = await _receptionRepo.liveAttendance();
    if (isClosed) return;

    result.when(
      success: (data) => emit(
        state.copyWith(
          liveAttendanceStatus: ReceptionStatus.success,
          liveAttendanceData: data,
        ),
      ),
      failure: (error) => emit(
        state.copyWith(
          liveAttendanceStatus: ReceptionStatus.failure,
          errorMessage: error.apiErrorModel.getAllErrorMessages(),
        ),
      ),
    );
  }

  Future<void> sessionCheckIn() async {
    emit(state.copyWith(sessionsCheckInStatus: ReceptionStatus.loading));
    final result = await _receptionRepo.sessionsCheckIn();
    if (isClosed) return;

    result.when(
      success: (data) =>
          emit(state.copyWith(sessionsCheckInStatus: ReceptionStatus.success)),
      failure: (error) => emit(
        state.copyWith(
          sessionsCheckInStatus: ReceptionStatus.failure,
          errorMessage: error.apiErrorModel.getAllErrorMessages(),
        ),
      ),
    );
  }

  Future<void> renewSubscription() async {
    emit(state.copyWith(renewSubscriptionStatus: ReceptionStatus.loading));
    final member = state.memberShowCardData;
    if (member == null) {
      emit(
        state.copyWith(
          renewSubscriptionStatus: ReceptionStatus.failure,
          errorMessage: "Member code is null",
        ),
      );
      return;
    }
    final result = await _receptionRepo.renewSubscription(member.id);

    if (isClosed) return;
    result.when(
      success: (data) {
        memberShowCard(member.code);
        emit(state.copyWith(renewSubscriptionStatus: ReceptionStatus.success));
      },
      failure: (message) {
        emit(
          state.copyWith(
            renewSubscriptionStatus: ReceptionStatus.failure,
            errorMessage: message.apiErrorModel.getAllErrorMessages(),
          ),
        );
      },
    );
  }

  /// آخر 5 حضور (الأحدث أولاً).
  Future<void> firstFiveAttendances({bool silent = false}) async {
    if (!silent) {
      emit(state.copyWith(firstFiveAttendancesStatus: ReceptionStatus.loading));
    }
    try {
      final res = await fetchNewestFirst(
        page: 1,
        size: 5,
        sortKey: (e) => e.checkInTime,
        fetch: (p) async {
          final r = await _attendanceTableRepo.getAttendanceTable(
            pageNumber: p,
            pageSize: 5,
          );
          return r.when(
            success: (d) => (items: d.items, total: d.totalCount),
            failure: (e) =>
                throw PageFetchError(e.apiErrorModel.getAllErrorMessages()),
          );
        },
      );
      if (isClosed) return;
      emit(
        state.copyWith(
          firstFiveAttendancesStatus: ReceptionStatus.success,
          fiveAttendancesData: res.items,
        ),
      );
    } on PageFetchError catch (e) {
      if (isClosed) return;
      emit(
        state.copyWith(
          firstFiveAttendancesStatus: ReceptionStatus.failure,
          errorMessage: e.message,
        ),
      );
    }
  }
}
