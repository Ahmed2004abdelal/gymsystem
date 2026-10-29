import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:gymsystem/core/networking/api_service.dart';
import 'package:gymsystem/core/networking/dio_factory.dart';
import 'package:gymsystem/features/activities/data/repos/activities_repo.dart';
import 'package:gymsystem/features/home/data/repos/attendance_table_repo.dart';
import 'package:gymsystem/features/home/data/repos/reception_repo.dart';
import 'package:gymsystem/features/login/data/repos/login_repo.dart';
import 'package:gymsystem/features/member%20info/data/repos/member_info_repo.dart';
import 'package:gymsystem/features/register%20screen/data/repos/clients_table_repo.dart';
import 'package:gymsystem/features/register%20screen/data/repos/register_repo.dart';

final getIt = GetIt.instance;

Future<void> setupGetIt() async {
  // Dio & ApiService
  Dio dio = DioFactory.getDio();
  getIt.registerLazySingleton<ApiService>(() => ApiService(dio));

  //login
  getIt.registerLazySingleton<LoginRepo>(() => LoginRepo(getIt<ApiService>()));

  //reception
  getIt.registerLazySingleton<ReceptionRepo>(
    () => ReceptionRepo(getIt<ApiService>()),
  );

  //subscription
  getIt.registerLazySingleton<RegisterRepo>(
    () => RegisterRepo(getIt<ApiService>()),
  );

  //clients table
  getIt.registerLazySingleton<ClientsTableRepo>(
    () => ClientsTableRepo(getIt<ApiService>()),
  );

  //attendance repo
  getIt.registerLazySingleton<AttendanceTableRepo>(
    () => AttendanceTableRepo(getIt<ApiService>()),
  );

  //member info repo
  getIt.registerLazySingleton<MemberInfoRepo>(
    () => MemberInfoRepo(getIt<ApiService>()),
  );

  //Activities Repo
  getIt.registerLazySingleton<ActivitiesRepo>(
    () => ActivitiesRepo(getIt<ApiService>()),
  );
}
