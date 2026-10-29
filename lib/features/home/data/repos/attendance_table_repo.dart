import 'package:gymsystem/core/networking/api_error_handler.dart';
import 'package:gymsystem/core/networking/api_result.dart';
import 'package:gymsystem/core/networking/api_service.dart';
import 'package:gymsystem/features/home/data/models/attendance_table_model.dart';

class AttendanceTableRepo {
  final ApiService _apiService;

  AttendanceTableRepo(this._apiService);

  Future<ApiResult<AttendanceTableModel>> getAttendanceTable({
    int pageNumber = 1,
    int pageSize = 5,
    int? period,
    int? gender,
    bool? hasTrainer,
    String? trainerName,
  }) async {
    try {
      final response = await _apiService.getAttendanceTable(
        pageNumber,
        pageSize,
        period,
        gender,
        hasTrainer,
        trainerName,
      );
      return ApiResult.success(response);
    } catch (error) {
      return ApiResult.failure(ErrorHandler.handle(error));
    }
  }
}
