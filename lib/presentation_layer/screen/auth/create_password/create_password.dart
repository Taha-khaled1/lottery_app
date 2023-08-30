import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:free_lottery/presentation_layer/components/appbar.dart';
import 'package:free_lottery/presentation_layer/components/custom_butten.dart';
import 'package:free_lottery/presentation_layer/components/custom_text_field.dart';
import 'package:free_lottery/presentation_layer/components/nav_bar.dart';
import 'package:free_lottery/presentation_layer/resources/color_manager.dart';
import 'package:free_lottery/presentation_layer/resources/font_manager.dart';
import 'package:free_lottery/presentation_layer/resources/styles_manager.dart';
import 'package:free_lottery/presentation_layer/screen/auth/LoginScreen/widget/RemperCHeckBox.dart';
import 'package:free_lottery/presentation_layer/screen/auth/forget_password/widget/CenterImage.dart';
// import 'package:free_lottery/presentation_layer/screen/auth/otp_screeen/otp_screeen.dart';
import 'package:free_lottery/presentation_layer/utils/responsive_design/ui_components/info_widget.dart';

class CreatePassword extends StatelessWidget {
  const CreatePassword({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.background,
      appBar: appbar(title: 'Create New Password'),
      body: InfoWidget(
        builder: (context, deviceInfo) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Spacer(),
              CenterImage(
                height: 250,
                image: 'assets/images/LOCKiMAGE.png',
                width: 300,
              ),
              Spacer(),
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.only(left: 45),
                  child: Text(
                    'Create Your New Password',
                    style: MangeStyles().getBoldStyle(
                      color: ColorManager.kTextlightgray,
                      fontSize: FontSize.s16,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20),
              CustomTextfield(
                valid: (p0) {},
                onsaved: (p0) {},
                titel: 'Password',
                width: deviceInfo.localWidth * 0.8,
                icon: Icons.lock,
                obsecuer: true,
                height: 60,
              ),
              SizedBox(height: 20),
              CustomTextfield(
                valid: (p0) {},
                onsaved: (p0) {},
                titel: 'Password',
                width: deviceInfo.localWidth * 0.8,
                icon: Icons.lock,
                obsecuer: true,
                height: 60,
              ),
              RemperCHeckBox(),
              Spacer(),
              CustomButton(
                width: deviceInfo.localWidth * 0.85,
                haigh: 55,
                color: ColorManager.kPrimary,
                text: 'Continue',
                press: () {
                  Get.to(() => MainScreen());
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
