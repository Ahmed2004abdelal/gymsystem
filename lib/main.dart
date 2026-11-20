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

import 'dart:async';
import 'dart:io';

// Future<void> main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await checkIfLoggedInUser();
//   await setupGetIt();
//   tzdata.initializeTimeZones();

//   await windowManager.waitUntilReadyToShow(
//     const WindowOptions(
//       size: Size(1440, 900),
//       minimumSize: Size(1100, 700),
//       center: true,
//     ),
//     () async {
//       await windowManager.show();
//       await windowManager.focus();
//     },
//   );

//   runApp(const MyApp());
// }

/// window_manager works on desktop only; calling it on Android/iOS throws.
bool get _isDesktop =>
    Platform.isWindows || Platform.isLinux || Platform.isMacOS;

void _log(String msg) {
  try {
    final base =
        Platform.environment['LOCALAPPDATA'] ?? Directory.systemTemp.path;
    File('$base\\bootcamp_log.txt')
        .writeAsStringSync('${DateTime.now()} $msg\n', mode: FileMode.append);
  } catch (_) {}
}

Future<void> main() async {
  await runZonedGuarded(() async {
    WidgetsFlutterBinding.ensureInitialized();
    FlutterError.onError = (d) =>
        _log('FlutterError: ${d.exception}\n${d.stack}');

    try {
      _log('1 checkIfLoggedInUser');
      await checkIfLoggedInUser();

      _log('2 setupGetIt');
      await setupGetIt();

      _log('3 timezones');
      tzdata.initializeTimeZones();

      if (_isDesktop) {
        _log('4 window');
        await windowManager.ensureInitialized();
        await windowManager.waitUntilReadyToShow(
          const WindowOptions(
            size: Size(1440, 900),
            minimumSize: Size(1440, 900), // window can't shrink below this
            center: true,
          ),
          () async {
            await windowManager.show();
            await windowManager.focus();
          },
        );
      }

      _log('5 runApp');
      runApp(const MyApp());
    } catch (e, s) {
      _log('STARTUP ERROR: $e\n$s');
      runApp(
        MaterialApp(
          home: Scaffold(
            body: Padding(
              padding: const EdgeInsets.all(24),
              child: SelectableText('Startup error:\n$e\n\n$s'),
            ),
          ),
        ),
      );
    }
  }, (e, s) => _log('UNCAUGHT: $e\n$s'));
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
        colorScheme: ColorScheme.dark(
          primary: AppColors.primary,
          onPrimary: AppColors.onPrimary,
          secondary: AppColors.secondary,
          onSecondary: AppColors.onSecondary,
          error: AppColors.error,
          onError: AppColors.onError,
          surface: AppColors.surface,
          onSurface: AppColors.onSurface,
          brightness: Brightness.dark,
        ),
        scaffoldBackgroundColor: AppColors.background,
        textTheme: GoogleFonts.cairoTextTheme(ThemeData.dark().textTheme),
      ),
      debugShowCheckedModeBanner: false,
      title: 'Heavy',
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
