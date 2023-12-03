import 'package:flutter/material.dart';
import 'package:free_lottery/presentation_layer/components/appbar.dart';
import 'package:free_lottery/presentation_layer/components/custom_butten.dart';
import 'package:free_lottery/presentation_layer/components/custom_text_field.dart';
import 'package:free_lottery/presentation_layer/resources/color_manager.dart';
import 'package:free_lottery/presentation_layer/resources/font_manager.dart';
import 'package:free_lottery/presentation_layer/resources/styles_manager.dart';
import 'package:free_lottery/presentation_layer/screen/auth/LoginScreen/login_screen.dart';
import 'package:free_lottery/presentation_layer/screen/auth/LoginScreen/widget/StandSocialLogin.dart';
import 'package:free_lottery/presentation_layer/screen/auth/siginUp_screen/siginUp_controller/siginUp_controller.dart';
import 'package:free_lottery/presentation_layer/screen/auth/social_login/widget/EndAuthPage.dart';
import 'package:free_lottery/presentation_layer/screen/auth/social_login/widget/custom_dvider.dart';
import 'package:free_lottery/presentation_layer/src/get_packge.dart';
import 'package:free_lottery/presentation_layer/utils/responsive_design/ui_components/info_widget.dart';

class SiginUpScreen extends StatelessWidget {
  const SiginUpScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    SiginUpController siginUpController = Get.put(SiginUpController());
    return Scaffold(
      backgroundColor: ColorManager.background,
      appBar: appbar(),
      body: InfoWidget(
        builder: (context, deviceInfo) {
          return SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: deviceInfo.localHeight * 0.05,
                ),
                // Spacer(),
                Padding(
                  padding: EdgeInsets.only(left: deviceInfo.localWidth * 0.07),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Create your\nAccount',
                      style: MangeStyles().getBoldStyle(
                        color: ColorManager.black,
                        fontSize: FontSize.s40 + 8,
                      ),
                      textAlign: TextAlign.left,
                    ),
                  ),
                ),
                SizedBox(
                  height: deviceInfo.localHeight * 0.05,
                ),
                // Spacer(),
                Form(
                  key: siginUpController.formKey,
                  child: Column(
                    children: [
                      CustomTextfield(
                        valid: (p0) {
                          return validInput(p0.toString(), 3, 100, 'email');
                        },
                        onsaved: (p0) {
                          siginUpController.emailAddress = p0.toString();
                        },
                        titel: 'Email',
                        width: deviceInfo.localWidth * 0.8,
                        icon: Icons.email,
                        height: 60,
                      ),
                      SizedBox(height: 20),
                      CustomTextfield(
                        valid: (p0) {
                          return validInput(p0.toString(), 3, 100, 'password');
                        },
                        onsaved: (p0) {
                          siginUpController.password = p0.toString();
                        },
                        titel: 'Password',
                        width: deviceInfo.localWidth * 0.8,
                        icon: Icons.lock,
                        obsecuer: true,
                        height: 60,
                      ),
                      SizedBox(height: 10),
                      GetBuilder<SiginUpController>(
                        builder: (controller) {
                          return SizedBox(
                            width: 200,
                            child: Directionality(
                              textDirection: TextDirection.rtl,
                              child: CheckboxListTile(
                                activeColor: ColorManager.kPrimary,
                                checkColor: ColorManager.white,
                                fillColor: MaterialStateProperty.all(
                                  ColorManager.kPrimary,
                                ),
                                autofocus: true,
                                checkboxShape: RoundedRectangleBorder(
                                  side: BorderSide(
                                    width: 1,
                                    color: ColorManager.kPrimary,
                                  ),
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                splashRadius: 0,
                                title: Transform.translate(
                                  offset: Offset(-20, 0),
                                  child: Text(
                                    'Remember me',
                                    style: TextStyle(
                                      color: Color(0xFF212121),
                                      fontSize: 14,
                                      fontFamily: 'Urbanist',
                                      fontWeight: FontWeight.w600,
                                      height: 1.40,
                                      letterSpacing: 0.20,
                                    ),
                                  ),
                                ),
                                value: siginUpController.isCheckBox,
                                onChanged: (value) {
                                  siginUpController.updateCheckBox(value!);
                                },
                              ),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
                GetBuilder<SiginUpController>(
                  builder: (controller) {
                    return controller.isload == false
                        ? CustomButton(
                            width: deviceInfo.localWidth * 0.8,
                            rectangel: 18,
                            height: 60,
                            color: ColorManager.kPrimaryButton,
                            text: "Sign up",
                            press: () {
                              if (controller.formKey.currentState!.validate()) {
                                controller.formKey.currentState!.save();
                                siginUpController.createAccount(context);
                              }
                            },
                          )
                        : Align(
                            alignment: Alignment.center,
                            child: CircularProgressIndicator(
                              color: ColorManager.kPrimary,
                            ),
                          );
                  },
                ),
                // Spacer(),
                CustomDvider(title: 'or continue with'), SizedBox(height: 20),
                StandSocialLogin(),
                SizedBox(height: 20),
                SizedBox(height: 20),
                EndAuthPage(
                  title: 'Already have an account?',
                  title2: 'Sign in',
                  onTap: () {
                    Get.off(() => LoginScreen());
                  },
                ),
                // Spacer(),
              ],
            ),
          );
        },
      ),
    );
  }
}
