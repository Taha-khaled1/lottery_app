import 'package:free_lottery/presentation_layer/components/appbar.dart';
import 'package:free_lottery/presentation_layer/components/custom_butten.dart';
import 'package:free_lottery/presentation_layer/screen/dashboard/main_dashboard.dart';
import 'package:free_lottery/presentation_layer/screen/dashboard/management.dart';
import 'package:free_lottery/presentation_layer/src/style_packge.dart';
import 'package:free_lottery/presentation_layer/utils/responsive_design/ui_components/info_widget.dart';
import 'package:get/get.dart';

class ChoiceScreen extends StatelessWidget {
  const ChoiceScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appbar(title: "Dashboard"),
      body: InfoWidget(
        builder: (context, deviceInfo) {
          return Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomButton(
                  width: deviceInfo.localWidth * 0.85,
                  height: 60,
                  color: ColorManager.kPrimary,
                  text: "Main settings",
                  press: () {
                    Get.to(() => Dashboard());
                  },
                ),
                CustomButton(
                  width: deviceInfo.localWidth * 0.85,
                  height: 60,
                  color: ColorManager.kPrimary,
                  text: "Withdrawal requests",
                  press: () {
                    Get.to(() => ManagementScreen());
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
