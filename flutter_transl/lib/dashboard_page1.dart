import 'package:flutter/material.dart';
import 'package:flutter_localization/localizations.dart';

import 'localizations.dart';

class DashboardPage1 extends StatelessWidget {
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