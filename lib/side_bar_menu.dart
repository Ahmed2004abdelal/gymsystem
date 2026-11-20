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

  /// أي عرض أقل من الرقم ده (موبايل / تابلت) بيستخدم Bottom Nav Bar.
  static const double _mobileBreakpoint = 900;

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

  /// اختيار صفحة من الـ Bottom Nav (بنزامن الـ controller عشان
  /// الـ Side Menu يفضل متزامن لو الشاشة اتكبّرت).
  void _selectPage(int i) {
    if (i == _index) return;
    setState(() {
      _index = i;
      _visited.add(i);
    });
    _controller.goTo(i);
  }

  void _logout() {
    SharedPrefHelper.clearAllSecuredData().then(
      (val) => context.pushNamedAndRemoveUntil(
        Routes.login,
        predicate: (r) => false,
      ),
    );
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

  /// الصفحات: اللي لسه مفتحتهاش = SizedBox.shrink (مفيش Bloc ولا API).
  /// اللي اتفتحت بتفضل محفوظة بالـ state بتاعها.
  Widget _buildBody() {
    return IndexedStack(
      index: _index,
      children: [
        for (var i = 0; i < _pagesCount; i++)
          _visited.contains(i) ? _buildPage(i) : const SizedBox.shrink(),
      ],
    );
  }

  // ───────────────────────── Mobile / Tablet ─────────────────────────
  Widget _buildMobileLayout() {
    // الصفحات الظاهرة في الـ Bottom Nav (بدون الصفحة الرابعة الفاضية).
    const destinations = <BottomNavigationBarItem>[
      BottomNavigationBarItem(
        icon: Icon(Icons.assignment_ind_outlined),
        label: 'الاستقبال',
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.people_alt_rounded),
        label: 'المشتركون',
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.sports_gymnastics_rounded),
        label: 'الحصص التدريبيه',
      ),
    ];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.surfaceContainerLow,
        automaticallyImplyLeading: false,
        title: Text(
          destinations[_index.clamp(0, destinations.length - 1)].label ?? '',
          style: TextStyle(
            color: AppColors.onBackground,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            tooltip: 'تسجيل الخروج',
            icon: Icon(Icons.logout_rounded, color: AppColors.onBackground),
            onPressed: _logout,
          ),
        ],
      ),
      body: SafeArea(top: false, child: _buildBody()),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _index.clamp(0, destinations.length - 1),
        onTap: _selectPage,
        backgroundColor: AppColors.surfaceContainerLow,
        selectedItemColor: AppColors.secondary,
        unselectedItemColor: AppColors.onBackground,
        items: destinations,
      ),
    );
  }

  // ───────────────────────── Desktop ─────────────────────────
  Widget _buildDesktopLayout() {
    return Scaffold(
      body: Row(
        children: [
          SideMenu(
            theme: SideMenuThemeData(
              displayMode: SideMenuDisplayMode.auto,
              hoverColor: AppColors.secondary,
              selectedColor: AppColors.primary,
              backgroundColor: AppColors.surfaceContainerLow,
              selectedIconColor: AppColors.secondary,
            ),
            controller: _controller,
            footer: GestureDetector(
              onTap: _logout,
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
          Expanded(child: _buildBody()),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: LayoutBuilder(
        builder: (context, constraints) {
          final isMobile = constraints.maxWidth < _mobileBreakpoint;
          return isMobile ? _buildMobileLayout() : _buildDesktopLayout();
        },
      ),
    );
  }
}
