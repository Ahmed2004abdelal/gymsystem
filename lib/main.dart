import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gymsystem/core/di/dependency_injection.dart';
import 'package:gymsystem/core/helper/constants.dart';
import 'package:gymsystem/core/helper/shared_pref_helper.dart';
import 'package:gymsystem/core/routing/app_routing.dart';
import 'package:gymsystem/core/routing/routes.dart';
import 'package:gymsystem/core/theme/app_colors.dart';
import 'package:timezone/data/latest.dart' as tzdata;
import 'package:window_manager/window_manager.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await checkIfLoggedInUser();
  await setupGetIt();
  tzdata.initializeTimeZones();

  await windowManager.waitUntilReadyToShow(
    const WindowOptions(
      size: Size(1440, 900),
      minimumSize: Size(1100, 700),
      center: true,
    ),
    () async {
      await windowManager.show();
      await windowManager.focus();
    },
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      locale: const Locale('ar'),
      supportedLocales: const [Locale('ar')],
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      builder: (context, child) =>
          Directionality(textDirection: TextDirection.rtl, child: child!),
      theme: ThemeData(
        scaffoldBackgroundColor: AppColors.background,
        textTheme: GoogleFonts.cairoTextTheme(ThemeData.dark().textTheme),
      ),
      debugShowCheckedModeBanner: false,
      title: 'GymSystem',
      // home: MemberProfileScreen(),
      initialRoute: isLoggedInUser ? Routes.sideBarMenu : Routes.login,
      onGenerateRoute: AppRouting.getRouting,
    );
  }
}

Future<void> checkIfLoggedInUser() async {
  String? userToken = await SharedPrefHelper.getSecuredString(
    SharedPrefKeys.userToken,
  );
  if (userToken.isNotEmpty) {
    isLoggedInUser = true;
  } else {
    isLoggedInUser = false;
  }
}
