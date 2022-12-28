import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_localization/dashboard_page1.dart';
import 'package:flutter_localization/dashboard_page2.dart';
import 'package:flutter_localization/dashboard_page3.dart';
import 'package:flutter_localization/app_localizations_delegate.dart';
import 'package:flutter_localization/main.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _DashboardState();
  }
}

class _DashboardState extends State<Dashboard> {
  int _currentIndex = 0;

  final List<Widget> _children = [
    DashboardPage1(),
    DashboardPage2(),
    DashboardPage3()
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      locale: const Locale.fromSubtags(languageCode: 'es'),
      title: AppLocalizations.instance.text('title'),
      home: Scaffold(
        appBar: AppBar(
          title: Text(
            AppLocalizations.instance.text('title'),
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.language),
              tooltip: 'Open shopping cart',
              onPressed: () {
                Locale currentLocale = MyApp.getLocale(context);

                if (currentLocale == const Locale('en', '')) {
                  MyApp.setLocale(context, const Locale('es', ''));
                } else {
                  MyApp.setLocale(context, const Locale('en', ''));
                }
              },
            ),
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _currentIndex,
          type: BottomNavigationBarType.fixed,
          onTap: onTabTapped,
          items: [
            BottomNavigationBarItem(
              icon: const Icon(Icons.dashboard),
              label: AppLocalizations.instance.text('page_one'),
            ),
            BottomNavigationBarItem(
              icon: const Icon(Icons.gesture),
              label: AppLocalizations.instance.text('page_two'),
            ),
            BottomNavigationBarItem(
              icon: const Icon(Icons.timelapse),
              label: AppLocalizations.instance.text('page_three'),
            )
          ],
        ),
        body: _children[_currentIndex],
      ),
    );
  }

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }
}
