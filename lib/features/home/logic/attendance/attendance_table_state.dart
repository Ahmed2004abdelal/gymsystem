import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:gymsystem/features/home/data/models/member_logedin_response_model.dart';

part 'attendance_table_state.freezed.dart';

enum AttendanceTableStatus { initial, loading, success, failure }

enum AttendancePeriod {
  today(0),
  thisWeek(1),
  thisMonth(2);

  final int apiValue;
  const AttendancePeriod(this.apiValue);
}

enum AttendanceGender {
  male(1),
  female(2);

  final int apiValue;
  const AttendanceGender(this.apiValue);
}

@freezed
abstract class AttendanceTableState with _$AttendanceTableState {
  const AttendanceTableState._();

  const factory AttendanceTableState({
    @Default(AttendanceTableStatus.initial) AttendanceTableStatus status,
    @Default([]) List<MemberLogedinResponseModel> items,
    @Default(1) int pageNumber,
    @Default(5) int pageSize,
    @Default(1) int totalPages,
    @Default(0) int totalCount,

    // Filters
    AttendancePeriod? period,
    AttendanceGender? gender,
    bool? hasTrainer,
    String? trainerName,

    String? errorMessage,
  }) = _AttendanceTableState;

  bool get isLoading => status == AttendanceTableStatus.loading;
  bool get hasNext => pageNumber < totalPages;
  bool get hasPrevious => pageNumber > 1;
}
