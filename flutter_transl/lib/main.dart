import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localization/dashboard.dart';
import 'package:flutter_localization/localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
          [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown])
      .then((_) => runApp(MyApp()));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        localizationsDelegates: const [
          AppLocalizationsDelegate(),
          GlobalMaterialLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
        ],
        // supportedLocales: const [
        //   Locale('en', ''),
        //   Locale('es', ''),
        // ],
        localeResolutionCallback:
            (Locale? locale, Iterable<Locale> supportedLocales) {
          return const Locale('es', '');
        },
        debugShowCheckedModeBanner: false,
        home: Dashboard());
  }
}
