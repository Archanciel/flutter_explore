// Code source: https://github.com/AseemWangoo/dynamism

import 'package:app_theme/app_theme.dart' show AppTheme;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_mvvm_simple_app/fringilla/repository/fringilla_repo.dart';
import 'package:flutter_mvvm_simple_app/fringilla/view_models/fringilla.viewmodel.dart';
import 'package:flutter_mvvm_simple_app/home/repository/home_repo.dart';
import 'package:flutter_mvvm_simple_app/pellen/repository/pellen_repo.dart';
import 'package:flutter_mvvm_simple_app/pellen/view_models/pellen.viewmodel.dart';

import 'home/view_models/home.viewmodel.dart';
import 'locator.dart';
import 'shared/routes/routes.dart';
import 'shared/services/navigation.service.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // INIT SERVICE LOCATOR
  setupLocator();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => HomeViewModel(repo: locator<HomeRepo>()),
        ),
        ChangeNotifierProvider.value(
          value: PellenViewModel(repo: locator<PellenRepo>()),
        ),
        ChangeNotifierProvider(
          create: (_) => FringillaViewModel(repo: locator<FringillaRepo>()),
        ),
      ],
      child: const MainApp(),
    ),
  );
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  _MainAppState createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  final navigatorService = locator<NavigationService>();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      navigatorKey: navigatorService.rootNavKey,
      title: 'Screener',
      onGenerateRoute: AppRoutes.generateRoute,
      theme: AppTheme.theme,
    );
  }
}
