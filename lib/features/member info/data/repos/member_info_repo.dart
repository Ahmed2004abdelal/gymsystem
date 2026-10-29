import 'package:gymsystem/core/networking/api_error_handler.dart';
import 'package:gymsystem/core/networking/api_result.dart';
import 'package:gymsystem/core/networking/api_service.dart';
import 'package:gymsystem/features/home/data/models/member_logedin_response_model.dart';
import 'package:gymsystem/features/home/data/models/member_show_card_model.dart';
import 'package:gymsystem/features/register%20screen/data/models/create_member_model.dart';
import 'package:gymsystem/features/register%20screen/data/models/gym_subscription_response_model.dart';

class MemberInfoRepo {
  final ApiService _apiService;

  MemberInfoRepo(this._apiService);

  //member info
  Future<ApiResult<MemberShowCardModel>> memberinfo(String memberCode) async {
    try {
      final response = await _apiService.memberShowCard(memberCode);
      return ApiResult.success(response);
    } catch (error) {
      return ApiResult.failure(ErrorHandler.handle(error));
    }
  }

  //member subscriptions
  Future<ApiResult<List<GymSubscriptionResponseModel>>> memberSubscriptions(
    int memberId,
  ) async {
    try {
      final response = await _apiService.memberSubscriptions(memberId);
      return ApiResult.success(response);
    } catch (error) {
      return ApiResult.failure(ErrorHandler.handle(error));
    }
  }

  //member attendance
  Future<ApiResult<List<MemberLogedinResponseModel>>> memberAttendance(
    int memberId,
  ) async {
    try {
      final response = await _apiService.memberAttendance(memberId);
      return ApiResult.success(response);
    } catch (error) {
      return ApiResult.failure(ErrorHandler.handle(error));
    }
  }

  //update member
  Future<ApiResult<CreateMemberModel>> updateMember(
    int memberId,
    CreateMemberModel model,
  ) async {
    try {
      final response = await _apiService.updateMember(memberId, model);
      return ApiResult.success(response);
    } catch (error) {
      return ApiResult.failure(ErrorHandler.handle(error));
    }
  }

  //delete member
  Future<ApiResult<void>> deleteMember(int memberId) async {
    try {
      await _apiService.deleteMember(memberId);
      return ApiResult.success(null);
    } catch (error) {
      return ApiResult.failure(ErrorHandler.handle(error));
    }
  }
}
