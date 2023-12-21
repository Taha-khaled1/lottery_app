import 'package:flutter/material.dart';
import 'package:free_lottery/main.dart';
import 'package:free_lottery/presentation_layer/components/appbar.dart';
import 'package:free_lottery/presentation_layer/components/custom_butten.dart';
import 'package:free_lottery/presentation_layer/components/custom_text_field.dart';
import 'package:free_lottery/presentation_layer/resources/color_manager.dart';
import 'package:free_lottery/presentation_layer/screen/dashboard/choice_screen.dart';
import 'package:free_lottery/presentation_layer/src/get_packge.dart';
import 'package:free_lottery/presentation_layer/src/show_toast.dart';
import 'package:free_lottery/presentation_layer/utils/responsive_design/ui_components/info_widget.dart';

String? pass = "";

class LoginDashboardScreen extends StatelessWidget {
  const LoginDashboardScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appbar(title: "Dashboard"),
      backgroundColor: ColorManager.background,
      body: InfoWidget(
        builder: (context, deviceInfo) {
          return Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Enter the password",
                  style: TextStyle(
                    color: Color(0xFF212121),
                    fontSize: 24,
                    fontFamily: 'Urbanist',
                    fontWeight: FontWeight.w700,
                    height: 1.20,
                  ),
                ),
                SizedBox(
                  height: 25,
                ),
                CustomTextfield(
                  valid: (p0) {
                    return null;
                  },
                  onsaved: (p0) {
                    return null;
                  },
                  onChanged: (password) {
                    pass = password.toString();
                  },
                  obsecuer: true,
                  titel: "Enter the password",
                  width: deviceInfo.localWidth * 0.85,
                  height: 60,
                ),
                SizedBox(
                  height: 25,
                ),
                CustomButton(
                  width: deviceInfo.localWidth * 0.85,
                  height: 60,
                  color: ColorManager.kPrimary,
                  text: "Next",
                  press: () {
                    if (pass == sharedPreferences.getString("dash_password")) {
                      Get.off(() => ChoiceScreen());
                      pass = '';
                    } else {
                      showToast("The password is incorrect");
                      pass = '';
                    }
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
