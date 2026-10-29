import 'package:gymsystem/core/networking/api_error_handler.dart';
import 'package:gymsystem/core/networking/api_result.dart';
import 'package:gymsystem/core/networking/api_service.dart';
import 'package:gymsystem/features/activities/data/models/activity_checkin_request_model.dart';
import 'package:gymsystem/features/activities/data/models/activity_checkin_response_model.dart';
import 'package:gymsystem/features/activities/data/models/make_activity_sub_request_model.dart';
import 'package:gymsystem/features/activities/data/models/make_activity_sub_response_model.dart';
import 'package:gymsystem/features/activities/data/models/member_activity_logedin_model.dart';
import 'package:gymsystem/features/register%20screen/data/models/activities_model.dart';

class ActivitiesRepo {
  final ApiService _apiService;

  ActivitiesRepo(this._apiService);

  Future<ApiResult<List<ActivitiesModel>>> getAvailableActivities() async {
    try {
      final response = await _apiService.getAvailableActivities();
      return ApiResult.success(response);
    } catch (error) {
      return ApiResult.failure(ErrorHandler.handle(error));
    }
  }

  Future<ApiResult<ActivityCheckinResponseModel>> activitiesCheckin(
    ActivityCheckinRequestModel activityCheckinRequestModel,
  ) async {
    try {
      final response = await _apiService.activitiesCheckin(
        activityCheckinRequestModel,
      );
      return ApiResult.success(response);
    } catch (error) {
      return ApiResult.failure(ErrorHandler.handle(error));
    }
  }

  Future<ApiResult<MakeActivitySubResponseModel>> makeActivitySubscription(
    MakeActivitySubRequestModel makeActivitySubRequestModel,
  ) async {
    try {
      final response = await _apiService.activitiesSubscriptions(
        makeActivitySubRequestModel,
      );
      return ApiResult.success(response);
    } catch (error) {
      return ApiResult.failure(ErrorHandler.handle(error));
    }
  }

  Future<ApiResult<List<MemberActivityLogedinModel>>>
  memberActivitiesAttendance(String memberCode) async {
    try {
      final response = await _apiService.memberActivitiesAttendance(memberCode);
      return ApiResult.success(response);
    } catch (error) {
      return ApiResult.failure(ErrorHandler.handle(error));
    }
  }
}
