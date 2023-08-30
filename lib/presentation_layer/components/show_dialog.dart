import 'package:free_lottery/presentation_layer/resources/strings_manager.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';

void showDilog(BuildContext context, String massg,
    {QuickAlertType? type,
    void Function()? onConfirmBtnTap,
    bool? barrierDismissible}) {
  QuickAlert.show(
    title: '',
    context: context,
    barrierDismissible: barrierDismissible ?? true,
    type: type ?? QuickAlertType.success,
    text: massg,
    confirmBtnText: AppStrings.agree.tr,
    cancelBtnText: AppStrings.cancel.tr,
    onConfirmBtnTap: onConfirmBtnTap ??
        () {
          Get.back();
        },
    confirmBtnColor: Colors.green,
  );
}
