import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:free_lottery/presentation_layer/resources/color_manager.dart';
import 'package:free_lottery/presentation_layer/screen/auth/LoginScreen/login_controller/login_controller.dart';

class RemperCHeckBox extends StatelessWidget {
  const RemperCHeckBox({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    LoginController loginController = Get.put(LoginController());
    return GetBuilder<LoginController>(
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
              value: loginController.isCheckBox,
              onChanged: (value) {
                loginController.updateCheckBox(value!);
              },
            ),
          ),
        );
      },
    );
  }
}
