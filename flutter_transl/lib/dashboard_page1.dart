import 'package:flutter/material.dart';
import 'package:flutter_localization/localizations.dart';

class DashboardPage1 extends StatelessWidget {
  const DashboardPage1({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        AppLocalizations.instance.text('page_one'),
        style: const TextStyle(
          fontSize: 22.00,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}