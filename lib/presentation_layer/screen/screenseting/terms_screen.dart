import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:free_lottery/presentation_layer/components/appbar.dart';
import 'package:free_lottery/presentation_layer/resources/color_manager.dart';

import '../../../main.dart';

class TermsAndConditionsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appbar(),
      backgroundColor: ColorManager.background,
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Html(data: sharedPreferences.getString('terms')),
            ],
          ),
        ),
      ),
    );
  }
}
