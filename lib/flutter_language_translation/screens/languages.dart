import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:provider/provider.dart';

import '../controller/language_controller.dart';
import '../widget/cheetah_button.dart';

class Languages extends StatelessWidget {
  static const double kBtnHeight = 22;

  @override
  Widget build(BuildContext context) {
    LanguageController controller = context.read<LanguageController>();

    return Scaffold(
      appBar: AppBar(title: const Text("Languages")),
      body: Container(
        padding: const EdgeInsets.all(24),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                child: Image.asset('assets/images/logo.png'),
                width: 200,
                height: 200,
              ),
              const Text(
                'Choose your language',
                style: TextStyle(fontSize: 30),
              ),
              const SizedBox(height: kBtnHeight),
              CheetahButton(
                text: 'languages_btn_english'.tr(),
                color: Colors.black87,
                textColor: Colors.white,
                onPressed: () {
                  context.setLocale(const Locale('en', 'US'));
                  controller.onLanguageChanged();
                },
              ),
              const SizedBox(height: kBtnHeight),
              CheetahButton(
                text: 'languages_btn_portuguese'.tr(),
                color: Colors.black87,
                textColor: Colors.white,
                onPressed: () {
                  context.setLocale(const Locale('pt', 'BR'));
                  controller.onLanguageChanged();
                },
              ),
              const SizedBox(height: kBtnHeight),
              CheetahButton(
                text: 'languages_btn_hindi'.tr(),
                color: Colors.black87,
                textColor: Colors.white,
                onPressed: () {
                  context.setLocale(const Locale('hi', 'IN'));
                  controller.onLanguageChanged();
                },
              ),
              const SizedBox(height: kBtnHeight),
              CheetahButton(
                text: 'languages_btn_vietnamese'.tr(),
                color: Colors.black87,
                textColor: Colors.white,
                onPressed: () {
                  context.setLocale(const Locale('vi', 'VN'));
                  controller.onLanguageChanged();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
