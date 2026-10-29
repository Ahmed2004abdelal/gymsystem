import 'package:easy_sidemenu/easy_sidemenu.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gymsystem/core/di/dependency_injection.dart';
import 'package:gymsystem/core/helper/extensions.dart';
import 'package:gymsystem/core/helper/shared_pref_helper.dart';
import 'package:gymsystem/core/routing/routes.dart';
import 'package:gymsystem/core/theme/app_colors.dart';
import 'package:gymsystem/features/activities/data/repos/activities_repo.dart';
import 'package:gymsystem/features/activities/logic/activities_cubit.dart';
import 'package:gymsystem/features/activities/ui/activities_screen.dart';
import 'package:gymsystem/features/home/data/repos/attendance_table_repo.dart';
import 'package:gymsystem/features/register%20screen/data/repos/clients_table_repo.dart';
import 'package:gymsystem/features/register%20screen/logic/clients/clients_table_cubit.dart';
import 'package:gymsystem/features/register%20screen/ui/clients_screen.dart';
import 'package:gymsystem/features/home/data/repos/reception_repo.dart';
import 'package:gymsystem/features/home/logic/reception_cubit.dart';
import 'package:gymsystem/features/home/ui/reception_screen.dart';

class SideBarMenu extends StatefulWidget {
  const SideBarMenu({super.key});

  @override
  State<SideBarMenu> createState() => _SideBarMenuState();
}

class _SideBarMenuState extends State<SideBarMenu> {
  static const _pagesCount = 4;

  final _controller = SideMenuController();
  int _index = 0;

  /// الصفحات اللي اتفتحت قبل كده (الاستقبال مفتوحة من البداية).
  final Set<int> _visited = {0};

  @override
  void initState() {
    super.initState();
    _controller.addListener(() {
      final i = _controller.currentIndex;
      if (i != _index) {
        setState(() {
          _index = i;
          _visited.add(i);
        });
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Widget _buildPage(int index) {
    switch (index) {
      case 0:
        return BlocProvider<ReceptionCubit>(
          create: (_) => ReceptionCubit(
            getIt<ReceptionRepo>(),
            getIt<AttendanceTableRepo>(),
          ),
          child: const ReceptionScreen(),
        );
      case 1:
        return BlocProvider<ClientsTableCubit>(
          create: (_) => ClientsTableCubit(getIt<ClientsTableRepo>()),
          child: const ClientsScreen(),
        );
      case 2:
        return BlocProvider<ActivitiesCubit>(
          create: (context) =>
              ActivitiesCubit(getIt<ActivitiesRepo>(), getIt<ReceptionRepo>()),
          child: ActivitiesScreen(),
        );
      default:
        return Center(
          child: Text('biiio', style: TextStyle(color: AppColors.onBackground)),
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        body: Row(
          children: [
            SideMenu(
              theme: SideMenuThemeData(
                displayMode: SideMenuDisplayMode.auto,
                hoverColor: AppColors.secondary,
                selectedColor: AppColors.primary,
                backgroundColor: AppColors.surfaceContainerLow,
                selectedIconColor: Colors.grey[600],
              ),
              controller: _controller,
              footer: GestureDetector(
                onTap: () {
                  SharedPrefHelper.clearAllSecuredData().then(
                    (val) => context.pushNamedAndRemoveUntil(
                      Routes.login,
                      predicate: (r) => false,
                    ),
                  );
                },
                child: Container(
                  width: double.infinity,
                  color: AppColors.surfaceTint,
                  padding: const EdgeInsets.all(16),
                  child: Text(
                    'تسجيل الخروج',
                    style: TextStyle(
                      color: AppColors.divider,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              items: [
                SideMenuItem(
                  title: 'الاستقبال',
                  icon: const Icon(Icons.assignment_ind_outlined),
                  onTap: (index, controller) => controller.goTo(index),
                ),
                SideMenuItem(
                  title: 'المشتركون',
                  icon: const Icon(Icons.people_alt_rounded),
                  onTap: (index, controller) => controller.goTo(index),
                ),
                SideMenuItem(
                  title: 'الحصص التدريبيه',
                  icon: const Icon(Icons.sports_gymnastics_rounded),
                  onTap: (index, controller) => controller.goTo(index),
                ),
                // SideMenuItem(
                //   title: 'اشتراك برايفت',
                //   icon: const Icon(Icons.fitness_center_rounded),
                //   onTap: (index, controller) => controller.goTo(index),
                // ),
              ],
            ),
            Expanded(
              // الصفحة اللي لسه مفتحتهاش = SizedBox.shrink (مفيش Bloc ولا API).
              // اللي اتفتحت بتفضل محفوظة بالـ state بتاعها.
              child: IndexedStack(
                index: _index,
                children: [
                  for (var i = 0; i < _pagesCount; i++)
                    _visited.contains(i)
                        ? _buildPage(i)
                        : const SizedBox.shrink(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
