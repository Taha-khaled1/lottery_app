import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:free_lottery/data_layer/models/notf_model.dart';
import 'package:free_lottery/presentation_layer/components/appbar.dart';
import 'package:free_lottery/presentation_layer/resources/color_manager.dart';
import 'package:free_lottery/presentation_layer/resources/font_manager.dart';
import 'package:free_lottery/presentation_layer/resources/styles_manager.dart';
import 'package:free_lottery/presentation_layer/utils/responsive_design/ui_components/info_widget.dart';

import 'widget/NotificationCard.dart';

// assets/json/no-notfication.json
class NotificationScreen extends StatelessWidget {
  const NotificationScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.background,
      appBar: appbarProfile(title: 'Notifications'),
      body: InfoWidget(
        builder: (context, deviceInfo) {
          return notfModelList == null || notfModelList.isEmpty
              ? Center(
                  child: Align(
                    alignment: Alignment.center,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'There are no notifications at this time',
                          style: MangeStyles().getBoldStyle(
                            color: ColorManager.black,
                            fontSize: FontSize.s18,
                          ),
                          textAlign: TextAlign.left,
                        ),
                        Lottie.asset(
                          'assets/json/empnotf.json',
                          height: 400,
                          width: 400,
                        ),
                      ],
                    ),
                  ),
                )
              : ListView.builder(
                  itemCount: notfModelList.length,
                  itemBuilder: (BuildContext context, int index) {
                    return NotificationCard(
                      notfModel: notfModelList[index],
                    );
                  },
                );
        },
      ),
    );
  }
}
