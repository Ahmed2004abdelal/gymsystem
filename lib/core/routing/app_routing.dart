import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gymsystem/core/di/dependency_injection.dart';
import 'package:gymsystem/core/routing/routes.dart';
import 'package:gymsystem/features/activities/data/repos/activities_repo.dart';
import 'package:gymsystem/features/home/data/models/member_show_card_model.dart';
import 'package:gymsystem/features/home/data/repos/attendance_table_repo.dart';
import 'package:gymsystem/features/home/logic/attendance/attendance_table_cubit.dart';
import 'package:gymsystem/features/home/logic/reception_cubit.dart';
import 'package:gymsystem/features/home/ui/attendance_table_screen.dart';
import 'package:gymsystem/features/member%20info/data/repos/member_info_repo.dart';
import 'package:gymsystem/features/member%20info/logic/member_info_cubit.dart';
import 'package:gymsystem/features/member%20info/ui/member_info_screen.dart';
import 'package:gymsystem/features/register%20screen/data/models/member_details_model.dart';
import 'package:gymsystem/features/register%20screen/data/repos/register_repo.dart';
import 'package:gymsystem/features/register%20screen/logic/register/register_member_cubit.dart';
import 'package:gymsystem/features/register%20screen/ui/register_member_screen.dart';
import 'package:gymsystem/features/login/data/repos/login_repo.dart';
import 'package:gymsystem/features/login/logic/login_cubit.dart';
import 'package:gymsystem/features/login/ui/login_screen.dart';
import 'package:gymsystem/features/register%20screen/ui/renew_subscription_screen.dart';
import 'package:gymsystem/side_bar_menu.dart';

class AppRouting {
  static Route<dynamic> getRouting(RouteSettings settings) {
    switch (settings.name) {
      case Routes.login:
        return MaterialPageRoute(
          builder: (_) => BlocProvider<LoginCubit>(
            create: (context) => LoginCubit(getIt<LoginRepo>()),
            child: LoginScreen(),
          ),
        );
      case Routes.sideBarMenu:
        return MaterialPageRoute(builder: (_) => SideBarMenu());
      case Routes.registerMember:
        final memberCode = settings.arguments as String?;
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => RegisterMemberCubit(getIt<RegisterRepo>()),
            child: RegisterMemberScreen(memberCode: memberCode),
          ),
        );
      case Routes.attendanceTableScreen:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) =>
                AttendanceTableCubit(getIt<AttendanceTableRepo>()),
            child: AttendanceTableScreen(),
          ),
        );
      case Routes.memberInfoScreen:
        final code = settings.arguments as String;
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (_) => MemberInfoCubit(
              getIt<MemberInfoRepo>(),
              getIt<ActivitiesRepo>(),
              memberCode: code,
            )..load(),
            child: const MemberInfoScreen(),
          ),
        );
      case Routes.renewSubscriptionScreen:
        final arguments = settings.arguments as Map<String, dynamic>;
        final member = arguments['member'] as MemberShowCardModel;
        final reception = arguments['receptionCubit'] as ReceptionCubit;
        return MaterialPageRoute(
          builder: (_) => MultiBlocProvider(
            providers: [
              BlocProvider.value(value: reception),
              BlocProvider(
                create: (_) =>
                    RegisterMemberCubit(getIt<RegisterRepo>())..loadForRenewal(
                      gender: member.gender.toLowerCase() == 'female' ? 2 : 1,
                      currentPackage: member.packageName,
                      currentTrainer: member.trainerName,
                    ),
              ),
            ],
            child: RenewSubscriptionScreen(member: member),
          ),
        );
      default:
        return MaterialPageRoute(builder: (_) => ErrorRoute());
    }
  }
}

class ErrorRoute extends StatelessWidget {
  const ErrorRoute({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          'Error Route',
          style: Theme.of(context).textTheme.headlineMedium,
        ),
      ),
    );
  }
}
