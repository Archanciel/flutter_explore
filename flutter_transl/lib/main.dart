import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localization/dashboard.dart';
import 'package:flutter_localization/app_localizations_delegate.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
          [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown])
      .then((_) => runApp(const MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();

  /// This static method enables to access to the State statefull
  /// widget instance.
  static void setLocale(BuildContext context, Locale newLocale) async {
    _MyAppState state = context.findAncestorStateOfType<_MyAppState>()!;
    state.changeLanguage(newLocale);
  }

  /// This static method enables to access to the State statefull
  /// widget instance.
  static Locale getLocale(BuildContext context) {
    _MyAppState state = context.findAncestorStateOfType<_MyAppState>()!;

    return state._locale;
  }
}

class _MyAppState extends State<MyApp> {
  Locale _locale = const Locale('en');

  changeLanguage(Locale locale) {
    setState(() {
      _locale = locale;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        localizationsDelegates: const [
          AppLocalizationsDelegate(),
          GlobalMaterialLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
        ],
        supportedLocales: const [
          Locale('en', ''),
          Locale('es', ''),
        ],
        locale: _locale,
        localeResolutionCallback: (locale, supportedLocales) {
          if (locale != null) {
            for (var supportedLocale in supportedLocales) {
              if (supportedLocale.languageCode == locale.languageCode &&
                  supportedLocale.countryCode == locale.countryCode) {
                return supportedLocale;
              }
            }
          }
          return supportedLocales.first;
        },
        debugShowCheckedModeBanner: false,
        home: Dashboard());
  }
}
