// import 'dart:async';

// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:gymsystem/core/networking/api_result.dart';
// import 'package:gymsystem/features/home/data/repos/attendance_table_repo.dart';

// import 'attendance_table_state.dart';

// class AttendanceTableCubit extends Cubit<AttendanceTableState> {
//   final AttendanceTableRepo _repo;

//   Timer? _debounce;
//   int _requestId = 0; // عشان نتجاهل الردود القديمة (race condition)

//   AttendanceTableCubit(this._repo) : super(const AttendanceTableState());

//   Future<void> loadPage([int? page]) async {
//     final targetPage = page ?? state.pageNumber;
//     final currentRequest = ++_requestId;

//     emit(
//       state.copyWith(
//         status: AttendanceTableStatus.loading,
//         pageNumber: targetPage,
//         errorMessage: null,
//       ),
//     );

//     final trainer = state.trainerName?.trim();

//     final result = await _repo.getAttendanceTable(
//       pageNumber: targetPage,
//       pageSize: state.pageSize,
//       period: state.period?.apiValue,
//       gender: state.gender?.apiValue,
//       hasTrainer: state.hasTrainer,
//       trainerName: (trainer == null || trainer.isEmpty) ? null : trainer,
//     );

//     // لو في request أحدث اتبعت، تجاهل ده
//     if (currentRequest != _requestId || isClosed) return;

//     result.when(
//       success: (data) {
//         emit(
//           state.copyWith(
//             status: AttendanceTableStatus.success,
//             items: data.items,
//             totalPages: data.totalPages,
//             totalCount: data.totalCount,
//           ),
//         );
//       },
//       failure: (error) {
//         emit(
//           state.copyWith(
//             status: AttendanceTableStatus.failure,
//             errorMessage: error.apiErrorModel.getAllErrorMessages(),
//           ),
//         );
//       },
//     );
//   }

//   // --- Pagination ---
//   void nextPage() {
//     if (state.hasNext && !state.isLoading) loadPage(state.pageNumber + 1);
//   }

//   void previousPage() {
//     if (state.hasPrevious && !state.isLoading) loadPage(state.pageNumber - 1);
//   }

//   void goToPage(int page) {
//     if (page < 1 || page > state.totalPages || page == state.pageNumber) return;
//     loadPage(page);
//   }

//   void changePageSize(int size) {
//     emit(state.copyWith(pageSize: size));
//     loadPage(1);
//   }

//   Future<void> refresh() => loadPage(state.pageNumber);

//   // --- Filters (أي تغيير فلتر بيرجّع لأول صفحة) ---
//   void setPeriod(AttendancePeriod? period) {
//     emit(state.copyWith(period: period));
//     loadPage(1);
//   }

//   void setGender(AttendanceGender? gender) {
//     emit(state.copyWith(gender: gender));
//     loadPage(1);
//   }

//   void setHasTrainer(bool? hasTrainer) {
//     emit(
//       state.copyWith(
//         hasTrainer: hasTrainer,
//         trainerName: hasTrainer == true ? state.trainerName : null,
//       ),
//     );
//     loadPage(1);
//   }

//   /// استخدمها في onChanged بتاع الـ TextField (فيها debounce)
//   void setTrainerName(String? name) {
//     emit(state.copyWith(trainerName: name));
//     _debounce?.cancel();
//     _debounce = Timer(const Duration(milliseconds: 500), () => loadPage(1));
//   }

//   void clearFilters() {
//     _debounce?.cancel();
//     emit(
//       state.copyWith(
//         period: null,
//         gender: null,
//         hasTrainer: null,
//         trainerName: null,
//       ),
//     );
//     loadPage(1);
//   }

//   @override
//   Future<void> close() {
//     _debounce?.cancel();
//     return super.close();
//   }
// }

import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gymsystem/core/helper/reverse_list.dart';
import 'package:gymsystem/core/networking/api_result.dart';
import 'package:gymsystem/features/home/data/repos/attendance_table_repo.dart';

import 'attendance_table_state.dart';

class AttendanceTableCubit extends Cubit<AttendanceTableState> {
  final AttendanceTableRepo _repo;

  Timer? _debounce;
  int _requestId = 0; // عشان نتجاهل الردود القديمة (race condition)

  AttendanceTableCubit(this._repo) : super(const AttendanceTableState());

  /// الصفحة 1 = أحدث حضور (راجع newest_first_pager.dart).
  Future<void> loadPage([int? page]) async {
    final targetPage = page ?? state.pageNumber;
    final currentRequest = ++_requestId;

    emit(
      state.copyWith(
        status: AttendanceTableStatus.loading,
        pageNumber: targetPage,
        errorMessage: null,
      ),
    );

    final size = state.pageSize;
    final period = state.period?.apiValue;
    final gender = state.gender?.apiValue;
    final hasTrainer = state.hasTrainer;
    final trainer = state.trainerName?.trim();
    final trainerName = (trainer == null || trainer.isEmpty) ? null : trainer;

    try {
      final res = await fetchNewestFirst(
        page: targetPage,
        size: size,
        sortKey: (e) => e.checkInTime,
        fetch: (p) async {
          final r = await _repo.getAttendanceTable(
            pageNumber: p,
            pageSize: size,
            period: period,
            gender: gender,
            hasTrainer: hasTrainer,
            trainerName: trainerName,
          );
          return r.when(
            success: (d) => (items: d.items, total: d.totalCount),
            failure: (e) =>
                throw PageFetchError(e.apiErrorModel.getAllErrorMessages()),
          );
        },
      );

      // لو في request أحدث اتبعت، تجاهل ده
      if (currentRequest != _requestId || isClosed) return;

      emit(
        state.copyWith(
          status: AttendanceTableStatus.success,
          items: res.items,
          totalPages: res.totalPages(size),
          totalCount: res.total,
        ),
      );
    } on PageFetchError catch (e) {
      if (currentRequest != _requestId || isClosed) return;
      emit(
        state.copyWith(
          status: AttendanceTableStatus.failure,
          errorMessage: e.message,
        ),
      );
    }
  }

  // --- Pagination ---
  void nextPage() {
    if (state.hasNext && !state.isLoading) loadPage(state.pageNumber + 1);
  }

  void previousPage() {
    if (state.hasPrevious && !state.isLoading) loadPage(state.pageNumber - 1);
  }

  void goToPage(int page) {
    if (page < 1 || page > state.totalPages || page == state.pageNumber) return;
    loadPage(page);
  }

  void changePageSize(int size) {
    emit(state.copyWith(pageSize: size));
    loadPage(1);
  }

  Future<void> refresh() => loadPage(state.pageNumber);

  // --- Filters (أي تغيير فلتر بيرجّع لأول صفحة) ---
  void setPeriod(AttendancePeriod? period) {
    emit(state.copyWith(period: period));
    loadPage(1);
  }

  void setGender(AttendanceGender? gender) {
    emit(state.copyWith(gender: gender));
    loadPage(1);
  }

  void setHasTrainer(bool? hasTrainer) {
    emit(
      state.copyWith(
        hasTrainer: hasTrainer,
        trainerName: hasTrainer == true ? state.trainerName : null,
      ),
    );
    loadPage(1);
  }

  /// استخدمها في onChanged بتاع الـ TextField (فيها debounce)
  void setTrainerName(String? name) {
    emit(state.copyWith(trainerName: name));
    _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () => loadPage(1));
  }

  void clearFilters() {
    _debounce?.cancel();
    emit(
      state.copyWith(
        period: null,
        gender: null,
        hasTrainer: null,
        trainerName: null,
      ),
    );
    loadPage(1);
  }

  @override
  Future<void> close() {
    _debounce?.cancel();
    return super.close();
  }
}
