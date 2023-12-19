import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:free_lottery/main.dart';
import 'package:free_lottery/presentation_layer/components/custom_text_field.dart';
import 'package:free_lottery/presentation_layer/screen/home_screen/home_screen.dart';
import 'package:free_lottery/presentation_layer/components/custom_butten.dart';
import 'package:free_lottery/presentation_layer/resources/color_manager.dart';
import 'package:free_lottery/presentation_layer/resources/font_manager.dart';
import 'package:free_lottery/presentation_layer/resources/styles_manager.dart';
import 'package:free_lottery/presentation_layer/utils/responsive_design/ui_components/info_widget.dart';

changePasswordhowBottomSheet(BuildContext context) {
  final TextEditingController? _currentPasswordController =
      TextEditingController();
  final TextEditingController _newPasswordController = TextEditingController();
  void changePassword(
      {required String currentPassword, required String newPassword}) async {
    User? user = FirebaseAuth.instance.currentUser;

// Check if the user is signed in
    if (user != null) {
      try {
        // Reauthenticate the user with their current password
        AuthCredential credential = EmailAuthProvider.credential(
          email: user.email!,
          password: currentPassword,
        );
        await user.reauthenticateWithCredential(credential);

        // Change the user's password to the new password
        await user.updatePassword(newPassword);

        // Password changed successfully
        print('Password changed successfully');
      } on FirebaseAuthException catch (e) {
        if (e.code == 'wrong-password') {
          print('The current password provided is incorrect');
        } else {
          print('Error changing password: $e');
        }
      } catch (e) {
        print('Error changing password: $e');
      }
    }
  }

  showModalBottomSheet(
    backgroundColor: ColorManager.background,
    isScrollControlled: true,
    context: context,
    shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
      topLeft: Radius.circular(25),
      topRight: Radius.circular(25),
    )),
    builder: (BuildContext context) {
      return Container(
        // height: 400,
        padding: EdgeInsets.all(16.0),
        child: InfoWidget(
          builder: (context, deviceInfo) {
            return SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Align(
                    alignment: Alignment.center,
                    child: Text(
                      'Logout',
                      style: MangeStyles().getBoldStyle(
                        color: ColorManager.kPrimary,
                        fontSize: FontSize.s18,
                      ),
                      textAlign: TextAlign.left,
                    ),
                  ),
                  SizedBox(height: 10),
                  if (sharedPreferences.getString("login_type") != "id")
                    CustomTextfield(
                      textController: _currentPasswordController,
                      valid: (value) {
                        return null;
                      },
                      onsaved: (value) {
                        return null;
                      },
                      titel: "old password",
                      width: deviceInfo.localWidth * 0.85,
                      height: 55,
                      onChanged: (value) {
                        _currentPasswordController?.text = value.toString();
                      },
                    ),
                  SizedBox(height: 10),
                  CustomTextfield(
                    textController: _newPasswordController,
                    valid: (value) {
                      return null;
                    },
                    onsaved: (value) {
                      return null;
                    },
                    titel: "new password",
                    width: deviceInfo.localWidth * 0.85,
                    height: 55,
                    onChanged: (value) {
                      _newPasswordController.text = value.toString();
                    },
                  ),
                  SizedBox(height: 10),
                  CustomButton(
                    width: deviceInfo.localWidth * 0.42,
                    rectangel: 25,
                    height: 60,
                    color: ColorManager.kPrimaryButton,
                    text: "confairmtion",
                    press: () async {
                      changePassword(
                        currentPassword: _currentPasswordController?.text ??
                            await getDeviceIdentifier(),
                        newPassword: _newPasswordController.text,
                      );
                    },
                  ),
                ],
              ),
            );
          },
        ),
      );
    },
  );
}
