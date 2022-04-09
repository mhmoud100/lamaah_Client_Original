import 'dart:io';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import 'Language/appLocalizations.dart';
import 'constance/constance.dart' as constance;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:my_cab/constance/themes.dart';
import 'package:my_cab/modules/home/home_screen.dart';
import 'package:my_cab/modules/splash/SplashScreen.dart';
import 'package:my_cab/modules/splash/introductionScreen.dart';
import 'package:my_cab/constance/global.dart' as globals;
import 'package:my_cab/constance/routes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]).then((_) => runApp(new MyApp()));
  configLoading();
}
void configLoading() {
  EasyLoading.instance
    ..displayDuration = const Duration(milliseconds: 1500)
    ..indicatorType = EasyLoadingIndicatorType.fadingCircle
    ..loadingStyle = EasyLoadingStyle.custom
    ..indicatorSize = 45.0
    ..radius = 10.0
    ..animationStyle = EasyLoadingAnimationStyle.scale
    ..animationDuration = const Duration(milliseconds: 500)
  // ..progressColor = Colors.yellow
    ..backgroundColor = Colors.black
    ..indicatorColor = Colors.blue
    ..textColor = Colors.yellow
    ..maskColor = Colors.blue.withOpacity(0.5)
    ..userInteractions = true
    ..dismissOnTap = false;
}

class MyApp extends StatefulWidget {
  static changeTheme(BuildContext context) {
    _MyAppState? state = context.findAncestorStateOfType<_MyAppState>();
    state!.changeTheme();
  }

  static setCustomeLanguage(BuildContext context, String languageCode) {
    final _MyAppState? state = context.findAncestorStateOfType<_MyAppState>();
    state!.setLanguage(languageCode);
  }

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Key key = new UniqueKey();

  void changeTheme() {
    this.setState(() {
      globals.isLight = !globals.isLight;
    });
  }

  String locale = "en";
  setLanguage(String languageCode) {
    setState(() {
      locale = languageCode;
      constance.locale = languageCode;
    });
  }

  @override
  Widget build(BuildContext context) {
    constance.locale = locale;
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: globals.isLight ? Brightness.dark : Brightness.light,
      statusBarBrightness: Platform.isAndroid ? Brightness.dark : Brightness.light,
      systemNavigationBarColor: CoustomTheme.getThemeData().cardColor,
      systemNavigationBarDividerColor: CoustomTheme.getThemeData().disabledColor,
      systemNavigationBarIconBrightness: globals.isLight ? Brightness.dark : Brightness.light,
    ));
    return Container(
      key: key,
      color: CoustomTheme.getThemeData().backgroundColor,
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              CoustomTheme.getThemeData().backgroundColor,
              CoustomTheme.getThemeData().backgroundColor,
              CoustomTheme.getThemeData().backgroundColor.withOpacity(0.8),
              CoustomTheme.getThemeData().backgroundColor.withOpacity(0.7)
            ],
          ),
        ),
        child: MaterialApp(
          localizationsDelegates: [
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: [
            const Locale('en'), // English
            const Locale('fr'), // French
            const Locale('ar'), // Arabic
          ],
          debugShowCheckedModeBanner: false,
          title: AppLocalizations.of('My Cab'),
          routes: routes,
          theme: CoustomTheme.getThemeData(),
          builder: (BuildContext context, Widget? child) {
            return Directionality(
              textDirection: TextDirection.ltr,
              child: Builder(
                builder: (BuildContext context) {
                  return MediaQuery(
                    data: MediaQuery.of(context).copyWith(
                      textScaleFactor: 1.0,
                    ),
                    child: child ?? Text(""),
                  );
                },
              ),
            );
          },
        ),
      ),
    );
  }

  var routes = <String, WidgetBuilder>{
    Routes.SPLASH: (BuildContext context) => SplashScreen(),
    Routes.INTRODUCTION: (BuildContext context) => IntroductionScreen(),
    Routes.HOME: (BuildContext context) => HomeScreen(),
  };
}
