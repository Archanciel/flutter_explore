import 'package:flutter/material.dart';
import 'package:flutter_localization/localizations.dart';

class DashboardPage2 extends StatelessWidget {
  const DashboardPage2({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        AppLocalizations.instance.text('page_two'),
        style: const TextStyle(
          fontSize: 22.00,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}