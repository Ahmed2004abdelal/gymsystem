// import 'package:flutter/material.dart';
// import 'package:gymsystem/core/networking/api_error_handler.dart';
// import 'package:gymsystem/core/networking/api_result.dart';
// import 'package:gymsystem/core/networking/api_service.dart';
// import 'package:gymsystem/features/register%20screen/data/models/activities_model.dart';
// import 'package:gymsystem/features/register%20screen/data/models/create_member_model.dart';
// import 'package:gymsystem/features/register%20screen/data/models/gym_subscription_model.dart';
// import 'package:gymsystem/features/register%20screen/data/models/gym_subscription_response_model.dart';
// import 'package:gymsystem/features/register%20screen/data/models/member_details_model.dart';
// import 'package:gymsystem/features/register%20screen/data/models/package_model.dart';
// import 'package:gymsystem/features/register%20screen/data/models/trainers_model.dart';

// class RegisterRepo {
//   final ApiService _apiService;
//   RegisterRepo(this._apiService);

//   Future<ApiResult<List<TrainersModel>>> getAvailableTrainers(int gymId) async {
//     try {
//       final response = await _apiService.getAvailableTrainers(gymId);
//       return ApiResult.success(response);
//     } catch (error, st) {
//       debugPrint('getAvailableTrainers: $error\n$st');
//       return ApiResult.failure(ErrorHandler.handle(error));
//     }
//   }

//   Future<ApiResult<List<PackageModel>>> getAvailablePackages(int gymId) async {
//     try {
//       final response = await _apiService.getAvailablePackages(gymId);
//       return ApiResult.success(response);
//     } catch (error, st) {
//       debugPrint('getAvailablePackages: $error\n$st');
//       return ApiResult.failure(ErrorHandler.handle(error));
//     }
//   }

//   Future<ApiResult<GymSubscriptionResponseModel>> createNewSubscription(
//     GymSubscriptionModel gymSubscriptionModel,
//   ) async {
//     try {
//       final response = await _apiService.createNewSubscription(
//         gymSubscriptionModel,
//       );
//       return ApiResult.success(response);
//     } catch (error) {
//       return ApiResult.failure(ErrorHandler.handle(error));
//     }
//   }

//   Future<ApiResult<MemberDetailsModel>> createNewMember(
//     CreateMemberModel createMemberModel,
//   ) async {
//     try {
//       final response = await _apiService.createNewMember(createMemberModel);
//       return ApiResult.success(response);
//     } catch (error) {
//       return ApiResult.failure(ErrorHandler.handle(error));
//     }
//   }
// }

import 'package:flutter/material.dart';
import 'package:gymsystem/core/networking/api_error_handler.dart';
import 'package:gymsystem/core/networking/api_result.dart';
import 'package:gymsystem/core/networking/api_service.dart';
import 'package:gymsystem/features/activities/data/models/make_activity_sub_request_model.dart';
import 'package:gymsystem/features/activities/data/models/make_activity_sub_response_model.dart';
import 'package:gymsystem/features/register%20screen/data/models/activities_model.dart';
import 'package:gymsystem/features/register%20screen/data/models/create_member_model.dart';
import 'package:gymsystem/features/register%20screen/data/models/gym_subscription_model.dart';
import 'package:gymsystem/features/register%20screen/data/models/gym_subscription_response_model.dart';
import 'package:gymsystem/features/register%20screen/data/models/member_details_model.dart';
import 'package:gymsystem/features/register%20screen/data/models/package_model.dart';
import 'package:gymsystem/features/register%20screen/data/models/trainers_model.dart';

class RegisterRepo {
  final ApiService _apiService;
  RegisterRepo(this._apiService);

  Future<ApiResult<List<TrainersModel>>> getAvailableTrainers(int gymId) async {
    try {
      final response = await _apiService.getAvailableTrainers(gymId);
      return ApiResult.success(response);
    } catch (error, st) {
      debugPrint('getAvailableTrainers: $error\n$st');
      return ApiResult.failure(ErrorHandler.handle(error));
    }
  }

  Future<ApiResult<List<PackageModel>>> getAvailablePackages(int gymId) async {
    try {
      final response = await _apiService.getAvailablePackages(gymId);
      return ApiResult.success(response);
    } catch (error, st) {
      debugPrint('getAvailablePackages: $error\n$st');
      return ApiResult.failure(ErrorHandler.handle(error));
    }
  }

  /// نفس الاستدعاء اللي في ActivitiesRepo.
  /// لو الـ endpoint بياخد gender في الـ ApiService عندك مرّره هنا: getAvailableActivities(gender).
  Future<ApiResult<List<ActivitiesModel>>> getAvailableActivities(
    int gender,
  ) async {
    try {
      final response = await _apiService.getAvailableActivities();
      return ApiResult.success(response);
    } catch (error, st) {
      debugPrint('getAvailableActivities: $error\n$st');
      return ApiResult.failure(ErrorHandler.handle(error));
    }
  }

  Future<ApiResult<GymSubscriptionResponseModel>> createNewSubscription(
    GymSubscriptionModel gymSubscriptionModel,
  ) async {
    try {
      final response = await _apiService.createNewSubscription(
        gymSubscriptionModel,
      );
      return ApiResult.success(response);
    } catch (error) {
      return ApiResult.failure(ErrorHandler.handle(error));
    }
  }

  Future<ApiResult<MakeActivitySubResponseModel>> createActivitySubscription(
    MakeActivitySubRequestModel model,
  ) async {
    try {
      final response = await _apiService.activitiesSubscriptions(model);
      return ApiResult.success(response);
    } catch (error, st) {
      debugPrint('createActivitySubscription: $error\n$st');
      return ApiResult.failure(ErrorHandler.handle(error));
    }
  }

  Future<ApiResult<MemberDetailsModel>> createNewMember(
    CreateMemberModel createMemberModel,
  ) async {
    try {
      final response = await _apiService.createNewMember(createMemberModel);
      return ApiResult.success(response);
    } catch (error) {
      return ApiResult.failure(ErrorHandler.handle(error));
    }
  }
}
