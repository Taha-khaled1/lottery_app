import 'package:flutter/material.dart';
import 'package:free_lottery/presentation_layer/components/custom_butten.dart';
import 'package:free_lottery/presentation_layer/components/custom_text_field.dart';
import 'package:free_lottery/presentation_layer/resources/color_manager.dart';
import 'package:free_lottery/presentation_layer/resources/font_manager.dart';
import 'package:free_lottery/presentation_layer/resources/styles_manager.dart';
import 'package:free_lottery/presentation_layer/screen/wallet_screen/wallet_controller/wallet_controller.dart';
import 'package:free_lottery/presentation_layer/src/get_packge.dart';
import 'package:free_lottery/presentation_layer/src/show_toast.dart';

class WithdrawDialog extends StatelessWidget {
  // final TextEditingController amountController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final WalletController _controller = Get.find();
    return AlertDialog(
      title: Text("The minimum Prize value is \$10"),
      content: Form(
        key: _controller.formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Align(
              alignment: Alignment.topLeft,
              child: Text(
                "Enter value",
                style: MangeStyles().getBoldStyle(
                  color: ColorManager.black,
                  fontSize: FontSize.s16,
                ),
              ),
            ),
            CustomTextfield(
              onChanged: (value) {},
              valid: (value) {
                return validInput(value.toString(), 1, 1000, "number");
              },
              onsaved: (value) {
                _controller.money = double.parse(value.toString());
                return null;
              },
              titel: "Enter the Prize you want to get",
              width: 400,
              height: 60,
            ),
            SizedBox(
              height: 10,
            ),
            Align(
              alignment: Alignment.topLeft,
              child: Text(
                "PayPal email",
                style: MangeStyles().getBoldStyle(
                  color: ColorManager.black,
                  fontSize: FontSize.s16,
                ),
              ),
            ),
            CustomTextfield(
              onChanged: (value) {},
              valid: (value) {
                return validInput(value.toString(), 5, 100, "email");
              },
              onsaved: (value) {
                _controller.email = value.toString();
                return null;
              },
              titel: "Enter your PayPal email",
              width: 400,
              height: 60,
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text("Cancel"),
        ),
        CustomButton(
          width: 110,
          height: 45,
          color: ColorManager.kPrimary,
          text: "Get Prize",
          fontSize: 16,
          press: () async {
            if (_controller.formKey.currentState!.validate()) {
              _controller.formKey.currentState!.save();
              if (_controller.money! < 10) {
                showToast("You must withdraw a value greater than \$10");
                return;
              }
              await _controller.createwithdrawalsForUser(
                _controller.money!,
                _controller.email!,
              );
              // loginController.signInWithEmailAndPassword();
              Navigator.of(context).pop();
            }
          },
        ),
      ],
    );
  }
}

void showWithdrawDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return WithdrawDialog();
    },
  );
}
