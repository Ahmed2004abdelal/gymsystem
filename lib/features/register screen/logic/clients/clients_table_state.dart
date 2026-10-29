import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:gymsystem/features/register%20screen/data/models/member_details_model.dart';

part 'clients_table_state.freezed.dart';

enum ClientsStatus { initial, loading, success, failure }

@freezed
abstract class ClientsTableState with _$ClientsTableState {
  const factory ClientsTableState({
    @Default(ClientsStatus.initial) ClientsStatus status,

    @Default(<MemberDetailsModel>[]) List<MemberDetailsModel> items,
    @Default(0) int totalCount,
    @Default(0) int totalPages,
    @Default(1) int pageNumber,
    @Default(10) int pageSize,
    @Default('') String searchTerm,
    String? errorMessage,
  }) = _ClientsTableState;
}
