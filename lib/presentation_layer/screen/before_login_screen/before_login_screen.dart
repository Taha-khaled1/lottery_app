import 'package:flutter/material.dart';
import 'package:free_lottery/presentation_layer/components/appbar.dart';
import 'package:free_lottery/presentation_layer/components/custom_butten.dart';
import 'package:free_lottery/presentation_layer/resources/color_manager.dart';
import 'package:free_lottery/presentation_layer/screen/auth/LoginScreen/login_screen.dart';
import 'package:free_lottery/presentation_layer/src/get_packge.dart';
import 'package:free_lottery/presentation_layer/utils/responsive_design/ui_components/info_widget.dart';
import 'package:lottie/lottie.dart';

class BeforeLoginScreen extends StatelessWidget {
  const BeforeLoginScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appbar(title: "Login", isBack: false),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Lottie.asset("assets/json/login.json"),
              SizedBox(
                height: 20,
              ),
              InfoWidget(
                builder: (context, deviceInfo) {
                  return CustomButton(
                    width: deviceInfo.localWidth * 0.8,
                    height: 55,
                    color: ColorManager.kPrimary,
                    text: "You must log in",
                    fontSize: 18,
                    press: () {
                      Get.to(() => LoginScreen());
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
