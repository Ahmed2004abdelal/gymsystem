import 'package:dio/dio.dart';
import 'package:gymsystem/core/networking/api_constants.dart';
import 'package:gymsystem/features/activities/data/models/activity_checkin_request_model.dart';
import 'package:gymsystem/features/activities/data/models/activity_checkin_response_model.dart';
import 'package:gymsystem/features/activities/data/models/make_activity_sub_request_model.dart';
import 'package:gymsystem/features/activities/data/models/make_activity_sub_response_model.dart';
import 'package:gymsystem/features/activities/data/models/member_activity_logedin_model.dart';
import 'package:gymsystem/features/home/data/models/attendance_table_model.dart';
import 'package:gymsystem/features/home/data/models/daily_visitiror_model.dart';
import 'package:gymsystem/features/home/data/models/member_checkin_model.dart';
import 'package:gymsystem/features/home/data/models/member_logedin_request_model.dart';
import 'package:gymsystem/features/home/data/models/member_logedin_response_model.dart';
import 'package:gymsystem/features/home/data/models/member_renew_sub_model.dart';
import 'package:gymsystem/features/home/data/models/member_show_card_model.dart';
import 'package:gymsystem/features/home/data/models/session_response_model.dart';
import 'package:gymsystem/features/login/data/models/login_request_model.dart';
import 'package:gymsystem/features/login/data/models/login_response_model.dart';
import 'package:gymsystem/features/register%20screen/data/models/activities_model.dart';
import 'package:gymsystem/features/register%20screen/data/models/clients%20table/clients_table_model.dart';
import 'package:gymsystem/features/register%20screen/data/models/create_member_model.dart';
import 'package:gymsystem/features/register%20screen/data/models/gym_subscription_model.dart';
import 'package:gymsystem/features/register%20screen/data/models/gym_subscription_response_model.dart';
import 'package:gymsystem/features/register%20screen/data/models/member_details_model.dart';
import 'package:gymsystem/features/register%20screen/data/models/package_model.dart';
import 'package:gymsystem/features/register%20screen/data/models/trainers_model.dart';
import 'package:retrofit/retrofit.dart';

part 'api_service.g.dart';

// @RestApi(baseUrl: ApiConstants.apiBaseUrl)
@RestApi()
abstract class ApiService {
  factory ApiService(Dio dio, {String baseUrl}) = _ApiService;

  @POST(ApiConstants.login)
  Future<LoginResponseModel> login(@Body() LoginRequestModel loginRequestModel);

  @POST(ApiConstants.refreshToken)
  Future<LoginResponseModel> refreshToken(
    @Body() RefreshTokenModel refreshTokenModel,
  );

  @GET('${ApiConstants.membersCheckinByCode}/{memberCode}')
  Future<MemberCheckintModel> membersCheckinByCode(
    @Path("memberCode") String memberCode,
  );

  @GET('${ApiConstants.memberShowCard}/{memberCode}')
  Future<MemberShowCardModel> memberShowCard(
    @Path("memberCode") String memberCode,
  );

  //member attendance
  @GET('${ApiConstants.memberAttendance}/{memberId}')
  Future<List<MemberLogedinResponseModel>> memberAttendance(
    @Path("memberId") int memberId,
  );

  @GET('${ApiConstants.memberSubscriptions}/{memberId}/${ApiConstants.gym}')
  Future<List<GymSubscriptionResponseModel>> memberSubscriptions(
    @Path("memberId") int memberId,
  );

  @PUT('Members/{id}') // تأكد من الـ method والمسار من Swagger
  Future<CreateMemberModel> updateMember(
    @Path('id') int id,
    @Body() CreateMemberModel body,
  );
  @DELETE('${ApiConstants.createMember}/{memberId}')
  Future<void> deleteMember(@Path("memberId") int memberId);

  @GET(ApiConstants.packages)
  Future<List<PackageModel>> getAvailablePackages(@Query("gender") int gender);

  @GET(ApiConstants.activities)
  Future<List<ActivitiesModel>> getAvailableActivities(
    // @Query("gender") int gender,
  );

  @GET(ApiConstants.trainers)
  Future<List<TrainersModel>> getAvailableTrainers(@Query("gender") int gender);

  @POST(ApiConstants.newSubscriptions)
  Future<GymSubscriptionResponseModel> createNewSubscription(
    @Body() GymSubscriptionModel gymSubscriptionModel,
  );

  @POST(ApiConstants.createMember)
  Future<MemberDetailsModel> createNewMember(
    @Body() CreateMemberModel createMemberModel,
  );

  @POST(ApiConstants.renewSubscriptions)
  Future<GymSubscriptionResponseModel> renewSubscription(
    @Body() MemberRenewSubModel memberRenewSubModel,
  );

  //get clients table
  @GET(ApiConstants.createMember)
  Future<ClientsTableModel> getClientsTable(
    @Query("PageNumber") int pageNumber,
    @Query("PageSize") int pageSize,
    @Query('SearchTerm') String? searchTerm,
  );

  //Daily visitors check-in
  @POST(ApiConstants.memberLogedin)
  Future<MemberLogedinResponseModel> memberLogedin(
    @Body() MemberLogedinRequestModel defaultRequest,
  );

  //list of members logedin
  @GET(ApiConstants.liveAttendance)
  Future<List<MemberLogedinResponseModel>> liveAttendance();

  //Session CheckIn
  @POST(ApiConstants.sessionCheckIn)
  Future<SessionResponseModel> sessionsCheckIn();

  //Attendance Table
  @GET(ApiConstants.attendanceTable)
  Future<AttendanceTableModel> getAttendanceTable(
    @Query("PageNumber") int pageNumber,
    @Query("PageSize") int pageSize,
    @Query('Period') int? period, // Today=0, ThisWeek=1, ThisMonth=2
    @Query('Gender') int? gender, // Male=0, Female=1
    @Query('HasTrainer') bool? hasTrainer,
    @Query('TrainerName') String? trainerName,
  );

  @POST(ApiConstants.activitiesSubscriptions)
  Future<MakeActivitySubResponseModel> activitiesSubscriptions(
    @Body() MakeActivitySubRequestModel makeActivitySubRequestModel,
  );

  @POST(ApiConstants.activityCheckIn)
  Future<ActivityCheckinResponseModel> activitiesCheckin(
    @Body() ActivityCheckinRequestModel activityCheckinRequestModel,
  );

  @GET('${ApiConstants.memberActivitiesAttendance}{memberCode}')
  Future<List<MemberActivityLogedinModel>> memberActivitiesAttendance(
    @Path("memberCode") String memberCode,
  );

  @GET(ApiConstants.dailyVisitorsToday)
  Future<DailyVisitirorModel> dailyVisitorsToday();
}
