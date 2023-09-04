import 'package:flutter/material.dart';
import 'package:free_lottery/presentation_layer/components/custom_butten.dart';
import 'package:free_lottery/presentation_layer/components/custom_text_field.dart';
import 'package:free_lottery/presentation_layer/resources/color_manager.dart';

class WithdrawDialog extends StatelessWidget {
  final TextEditingController amountController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("Withdraw Money"),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CustomTextfield(
            valid: (p0) {},
            onsaved: (p0) {},
            titel: "Enter the value you want to withdraw",
            width: 400,
            height: 60,
          ),
        ],
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
          text: "Withdraw",
          fontSize: 16,
          press: () {
            // Handle withdrawal logic here
            double withdrawalAmount =
                double.tryParse(amountController.text) ?? 0.0;
            // Implement your withdrawal logic using the amount
            Navigator.of(context).pop();
          },
        )
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
