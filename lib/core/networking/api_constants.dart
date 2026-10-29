class ApiConstants {
  //auth
  static const String login = 'Auth/login';

  //members
  static const String memberShowCard = 'Members/by-code/';
  static const String membersCheckinByCode = 'Members/scan-check/';
  static const String createMember = 'Members';
  static const String liveAttendance = 'Attendance/Live';
  static const String memberLogedin = 'Attendance/check-in';
  static const String sessionCheckIn = 'DailyVisitors/check-in';
  static const String attendanceTable = 'Attendance/filtered';

  //register member
  static const String packages = 'Subscriptions/available-packages';
  static const String trainers = 'Subscriptions/available-trainers';
  static const String activities = 'Subscriptions/available-activities';
  static const String newSubscriptions = 'Subscriptions/gym';
  static const String renewSubscriptions = 'Subscriptions/gym/renew';
  static const String dailyVisitorsCheckIn = 'DailyVisitors/check-in';

  //member info
  static const String memberAttendance = 'Attendance/member/';
  static const String memberSubscriptions = 'Subscriptions/member/';
  static const String gym = 'gym';

  //activities
  static const String activityCheckIn = 'ActivityAttendance/check-in';
  static const String activitiesSubscriptions = 'Subscriptions/activity';
  static const String memberActivitiesAttendance =
      'ActivityAttendance/member-active/';
}

class ApiErrors {
  static const String badRequestError = "badRequestError";
  static const String noContent = "noContent";
  static const String forbiddenError = "forbiddenError";
  static const String unauthorizedError = "unauthorizedError";
  static const String notFoundError = "notFoundError";
  static const String conflictError = "conflictError";
  static const String internalServerError = "internalServerError";
  static const String unknownError = "unknownError";
  static const String timeoutError = "timeoutError";
  static const String defaultError = "defaultError";
  static const String cacheError = "cacheError";
  static const String noInternetError = "noInternetError";
  static const String loadingMessage = "loading_message";
  static const String retryAgainMessage = "retry_again_message";
  static const String ok = "Ok";
}
