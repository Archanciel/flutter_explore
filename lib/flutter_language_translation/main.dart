import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'controller/language_controller.dart';
import 'screens/home.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => LanguageController()),
      ],
      child: EasyLocalization(
        supportedLocales: const [
          Locale('en', 'US'),
          Locale('hi', 'IN'),
          Locale('pt', 'BR'),
          Locale('vi', 'VN')
        ],
        path: 'assets/translations',
        fallbackLocale: const Locale('en', 'US'),
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          locale: const Locale('en', 'US'),
          // supportedLocales: context.supportedLocales,
          // localizationsDelegates: context.localizationDelegates,
          theme: ThemeData(
            appBarTheme: const AppBarTheme(color: Color(0xFF000000)),
          ),
          home: const Home(),
        ),
      ),
    );
  }
}
