// import 'dart:async';

// import 'package:bloc/bloc.dart';
// import 'package:gymsystem/core/networking/api_result.dart';
// import 'package:gymsystem/features/register%20screen/data/repos/clients_table_repo.dart';
// import 'package:gymsystem/features/register%20screen/logic/clients/clients_table_state.dart';

// class ClientsTableCubit extends Cubit<ClientsTableState> {
//   final ClientsTableRepo _repo;
//   ClientsTableCubit(this._repo) : super(const ClientsTableState());

//   Timer? _debounce;

//   int _requestId = 0;

//   Future<void> loadPage([int? pageNumber]) async {
//     final page = pageNumber ?? state.pageNumber;
//     final id = ++_requestId;

//     emit(
//       state.copyWith(
//         status: ClientsStatus.loading,
//         pageNumber: page,
//         errorMessage: null,
//       ),
//     );

//     final result = await _repo.getClientsTable(
//       page,
//       state.pageSize,
//       searchTerm: state.searchTerm,
//     );
//     if (isClosed || id != _requestId) return; // رد قديم

//     result.when(
//       success: (data) => emit(
//         state.copyWith(
//           status: ClientsStatus.success,
//           items: data.items,
//           totalCount: data.totalCount,
//           totalPages: data.totalPages,
//           pageNumber: data.pageNumber,
//         ),
//       ),
//       failure: (error) => emit(
//         state.copyWith(
//           status: ClientsStatus.failure,
//           errorMessage: error.apiErrorModel.getAllErrorMessages(),
//         ),
//       ),
//     );
//   }

//   Future<void> refresh() => loadPage(state.pageNumber);

//   /// تغيير عدد الصفوف في الصفحة -> بيرجع للصفحة الأولى.
//   Future<void> changePageSize(int size) async {
//     if (size == state.pageSize) return;
//     emit(state.copyWith(pageSize: size, pageNumber: 1));
//     await loadPage(1);
//   }

//   /// بحث بالاسم أو الكود (بعد توقف الكتابة 400ms) -> بيرجع للصفحة الأولى.
//   void search(String term) {
//     _debounce?.cancel();
//     _debounce = Timer(const Duration(milliseconds: 400), () {
//       final t = term.trim();
//       if (t == state.searchTerm) return;
//       emit(state.copyWith(searchTerm: t, pageNumber: 1));
//       loadPage(1);
//     });
//   }

//   @override
//   Future<void> close() {
//     _debounce?.cancel();
//     return super.close();
//   }
// }

import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:gymsystem/core/helper/reverse_list.dart';
import 'package:gymsystem/core/networking/api_result.dart';
import 'package:gymsystem/features/register%20screen/data/repos/clients_table_repo.dart';
import 'package:gymsystem/features/register%20screen/logic/clients/clients_table_state.dart';

class ClientsTableCubit extends Cubit<ClientsTableState> {
  final ClientsTableRepo _repo;
  ClientsTableCubit(this._repo) : super(const ClientsTableState());

  Timer? _debounce;

  int _requestId = 0;

  /// الصفحة 1 = أحدث المشتركين (راجع newest_first_pager.dart).
  Future<void> loadPage([int? pageNumber]) async {
    final page = pageNumber ?? state.pageNumber;
    final size = state.pageSize;
    final term = state.searchTerm;
    final id = ++_requestId;

    emit(
      state.copyWith(
        status: ClientsStatus.loading,
        pageNumber: page,
        errorMessage: null,
      ),
    );

    try {
      final res = await fetchNewestFirst(
        page: page,
        size: size,
        fetch: (p) async {
          final r = await _repo.getClientsTable(p, size, searchTerm: term);
          return r.when(
            success: (d) => (items: d.items, total: d.totalCount),
            failure: (e) =>
                throw PageFetchError(e.apiErrorModel.getAllErrorMessages()),
          );
        },
      );
      if (isClosed || id != _requestId) return; // رد قديم

      emit(
        state.copyWith(
          status: ClientsStatus.success,
          items: res.items,
          totalCount: res.total,
          totalPages: res.totalPages(size),
          pageNumber: page,
        ),
      );
    } on PageFetchError catch (e) {
      if (isClosed || id != _requestId) return;
      emit(
        state.copyWith(status: ClientsStatus.failure, errorMessage: e.message),
      );
    }
  }

  Future<void> refresh() => loadPage(state.pageNumber);

  /// تغيير عدد الصفوف في الصفحة -> بيرجع للصفحة الأولى.
  Future<void> changePageSize(int size) async {
    if (size == state.pageSize) return;
    emit(state.copyWith(pageSize: size, pageNumber: 1));
    await loadPage(1);
  }

  /// بحث بالاسم أو الكود (بعد توقف الكتابة 400ms) -> بيرجع للصفحة الأولى.
  void search(String term) {
    _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 400), () {
      final t = term.trim();
      if (t == state.searchTerm) return;
      emit(state.copyWith(searchTerm: t, pageNumber: 1));
      loadPage(1);
    });
  }

  @override
  Future<void> close() {
    _debounce?.cancel();
    return super.close();
  }
}
