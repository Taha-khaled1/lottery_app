import 'package:flutter/material.dart';
import 'package:free_lottery/presentation_layer/components/appbar.dart';
import 'package:free_lottery/presentation_layer/components/custom_butten.dart';
import 'package:free_lottery/presentation_layer/resources/color_manager.dart';
import 'package:free_lottery/presentation_layer/resources/font_manager.dart';
import 'package:free_lottery/presentation_layer/resources/styles_manager.dart';
import 'package:free_lottery/presentation_layer/screen/auth/forget_password/widget/CenterImage.dart';
import 'package:free_lottery/presentation_layer/screen/auth/forget_password/widget/custom_box.dart';

import 'package:free_lottery/presentation_layer/utils/responsive_design/ui_components/info_widget.dart';

class ForgetPasswordScreen extends StatelessWidget {
  const ForgetPasswordScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.background,
      appBar: appbar(title: 'Forgot Password'),
      body: InfoWidget(
        builder: (context, deviceInfo) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            // mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Spacer(),
              CenterImage(
                height: 200,
                image: 'assets/images/pass.png',
                width: 300,
              ),
              Spacer(),
              SizedBox(
                width: 380,
                child: Text(
                  'Select which contact details should we use to reset your password',
                  style: MangeStyles().getBoldStyle(
                    color: ColorManager.kTextlightgray,
                    fontSize: FontSize.s16,
                  ),
                ),
              ),
              // Spacer(),
              // CustomBox(
              //   image: 'assets/icons/chat.png',
              //   text: '+1 111 ******99',
              //   titlt: 'via SMS :\n ',
              // ),
              SizedBox(
                height: 15,
              ),
              CustomBox(
                image: 'assets/icons/massge.png',
                text: 'chr***ey@yourdomain.com',
                titlt: 'via Email : \n',
              ),
              Spacer(),
              CustomButton(
                width: deviceInfo.localWidth * 0.85,
                haigh: 55,
                color: ColorManager.kPrimary,
                text: 'Continue',
                press: () {
                  // Get.to(() => OtpScreen());
                },
              ),
              Spacer(),
            ],
          );
        },
      ),
    );
  }
}
