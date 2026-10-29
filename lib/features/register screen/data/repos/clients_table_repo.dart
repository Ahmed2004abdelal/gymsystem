import 'package:gymsystem/core/networking/api_error_handler.dart';
import 'package:gymsystem/core/networking/api_result.dart';
import 'package:gymsystem/core/networking/api_service.dart';
import 'package:gymsystem/features/register%20screen/data/models/clients%20table/clients_table_model.dart';

class ClientsTableRepo {
  final ApiService _apiService;

  ClientsTableRepo(this._apiService);

  Future<ApiResult<ClientsTableModel>> getClientsTable(
    int pageNumber,
    int pageSize, {
    String? searchTerm,
  }) async {
    try {
      final response = await _apiService.getClientsTable(
        pageNumber,
        pageSize,
        (searchTerm == null || searchTerm.isEmpty) ? null : searchTerm,
      );
      return ApiResult.success(response);
    } catch (error) {
      return ApiResult.failure(ErrorHandler.handle(error));
    }
  }
}
