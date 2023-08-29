import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:template/app_binding.dart';
import 'package:template/localization/app_localization.dart';
import 'package:template/routes/app_pages.dart';
import 'package:template/routes/app_routes.dart';
import 'package:template/theme/app_theme.dart';
import 'package:template/utils/app_constants.dart' as app_constants;

import 'di_container.dart' as di;
import 'notification/my_notification.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // init dependence injection
  await di.init();

  EasyLoading.instance
    ..displayDuration = const Duration(milliseconds: 2000)
    ..indicatorType = EasyLoadingIndicatorType.fadingCircle
    ..loadingStyle = EasyLoadingStyle.dark
    ..indicatorSize = 45.0
    ..radius = 10.0
    ..progressColor = Colors.yellow
    ..backgroundColor = Colors.green
    ..indicatorColor = Colors.yellow
    ..textColor = Colors.yellow
    ..maskColor = Colors.blue.withOpacity(0.5)
    ..userInteractions = true
    ..dismissOnTap = false;

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp();

  static final navigatorKey = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    final List<Locale> _locals = [];

    // add all LanguageModel from app_constants
    for (int i = 0; i < app_constants.languages.length; i++) {
      _locals.add(Locale(app_constants.languages[i].languageCode.toString(),
          app_constants.languages[i].countryCode));
    }
    Locale localeResolutionCallback(
        Locale? locale, Iterable<Locale> supportedLocales) {
      if (locale == null) {
        return supportedLocales.first;
      }
      for (final supportedLocale in supportedLocales) {
        if (supportedLocale.languageCode == locale.languageCode) {
          return supportedLocale;
        }
      }
      return supportedLocales.first;
    }

    return GetMaterialApp(
      initialRoute: AppRoutes.SPLASH,
      initialBinding: AppBinding(),
      getPages: AppPages.list,
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      supportedLocales: _locals,
      localizationsDelegates: const [
        AppLocalization.delegate, // Load dư liệu trước
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      builder: EasyLoading.init(),
      localeResolutionCallback: localeResolutionCallback,
      // darkTheme: AppTheme.dark,
      // themeMode: ThemeMode.system,
      // locale: ,
      // supportedLocales: _locals,
    );
  }
}
