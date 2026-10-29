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
import 'package:gymsystem/core/networking/api_result.dart';
import 'package:gymsystem/features/home/data/repos/attendance_table_repo.dart';
import 'package:gymsystem/features/home/data/repos/reception_repo.dart';
import 'package:gymsystem/features/home/logic/reception_state.dart';

class ReceptionCubit extends Cubit<ReceptionState> {
  final ReceptionRepo _receptionRepo;
  final AttendanceTableRepo _attendanceTableRepo;
  ReceptionCubit(this._receptionRepo, this._attendanceTableRepo)
    : super(const ReceptionState()) {
    liveAttendance();
    firstFiveAttendances();
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

  Future<void> liveAttendance() async {
    emit(state.copyWith(liveAttendanceStatus: ReceptionStatus.loading));
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

  Future<void> firstFiveAttendances() async {
    emit(state.copyWith(firstFiveAttendancesStatus: ReceptionStatus.loading));
    final result = await _attendanceTableRepo.getAttendanceTable();
    if (isClosed) return;

    result.when(
      success: (data) => emit(
        state.copyWith(
          firstFiveAttendancesStatus: ReceptionStatus.success,
          fiveAttendancesData: data.items,
        ),
      ),
      failure: (error) => emit(
        state.copyWith(
          firstFiveAttendancesStatus: ReceptionStatus.failure,
          errorMessage: error.apiErrorModel.getAllErrorMessages(),
        ),
      ),
    );
  }
}
