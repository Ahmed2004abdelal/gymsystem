import 'package:gymsystem/core/networking/api_error_handler.dart';
import 'package:gymsystem/core/networking/api_result.dart';
import 'package:gymsystem/core/networking/api_service.dart';
import 'package:gymsystem/features/home/data/models/member_checkin_model.dart';
import 'package:gymsystem/features/home/data/models/member_logedin_request_model.dart';
import 'package:gymsystem/features/home/data/models/member_logedin_response_model.dart';
import 'package:gymsystem/features/home/data/models/member_renew_sub_model.dart';
import 'package:gymsystem/features/home/data/models/member_show_card_model.dart';
import 'package:gymsystem/features/home/data/models/session_response_model.dart';
import 'package:gymsystem/features/register%20screen/data/models/gym_subscription_response_model.dart';

class ReceptionRepo {
  final ApiService _apiService;

  ReceptionRepo(this._apiService);

  Future<ApiResult<MemberCheckintModel>> membersCheckinByCode(
    String memberCode,
  ) async {
    try {
      final response = await _apiService.membersCheckinByCode(memberCode);
      return ApiResult.success(response);
    } catch (error) {
      return ApiResult.failure(ErrorHandler.handle(error));
    }
  }

  Future<ApiResult<MemberShowCardModel>> memberShowCard(
    String memberCode,
  ) async {
    try {
      final response = await _apiService.memberShowCard(memberCode);
      return ApiResult.success(response);
    } catch (error) {
      return ApiResult.failure(ErrorHandler.handle(error));
    }
  }

  Future<ApiResult<MemberLogedinResponseModel>> memberLogedin(
    String memberCode,
  ) async {
    try {
      final response = await _apiService.memberLogedin(
        MemberLogedinRequestModel(memberCode: memberCode),
      );
      return ApiResult.success(response);
    } catch (error) {
      return ApiResult.failure(ErrorHandler.handle(error));
    }
  }

  Future<ApiResult<List<MemberLogedinResponseModel>>> liveAttendance() async {
    try {
      final response = await _apiService.liveAttendance();
      return ApiResult.success(response);
    } catch (error) {
      return ApiResult.failure(ErrorHandler.handle(error));
    }
  }

  Future<ApiResult<SessionResponseModel>> sessionsCheckIn() async {
    try {
      final response = await _apiService.sessionsCheckIn();
      return ApiResult.success(response);
    } catch (error) {
      return ApiResult.failure(ErrorHandler.handle(error));
    }
  }

  Future<ApiResult<GymSubscriptionResponseModel>> renewSubscription(
    int memberId,
  ) async {
    try {
      final response = await _apiService.renewSubscription(
        MemberRenewSubModel(memberId: memberId),
      );
      return ApiResult.success(response);
    } catch (error) {
      return ApiResult.failure(ErrorHandler.handle(error));
    }
  }
}
