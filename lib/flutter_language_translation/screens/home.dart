import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:provider/provider.dart';

import '../controller/language_controller.dart';
import '../widget/cheetah_button.dart';
import 'languages.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    context.watch<LanguageController>();

    return Scaffold(
      appBar: AppBar(
        leading: Image.asset('assets/images/logo.png'),
        title: const Text('Easy Localizations'),
      ),
      body: Container(
        padding: const EdgeInsets.all(24),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Text(
                'Cheetah Coding',
                style: TextStyle(fontSize: 40),
              ),
              const SizedBox(height: 24),
              Text(
                'home_description'.tr(),
                style: const TextStyle(
                  fontSize: 24,
                ),
              ),
              const SizedBox(height: 24),
              CheetahButton(
                text: 'home_btn_text'.tr(),
                color: Colors.black87,
                textColor: Colors.white,
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Languages(),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
