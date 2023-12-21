import 'package:device_info_plus/device_info_plus.dart';
import 'package:free_lottery/main.dart';
import 'package:free_lottery/presentation_layer/screen/home_screen/home_screen.dart';
import 'package:free_lottery/presentation_layer/src/style_packge.dart';
import 'package:free_lottery/presentation_layer/utils/shard_function/printing_function_red.dart';
import 'package:get/get.dart';

class ProfileController extends GetxController {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
  bool isload = true;
  bool visibility = false;
  late String pass;
  void changeVisibility() {
    visibility = !visibility;
    update();
  }

  changeUpdate() {
    update();
  }

  @override
  void onInit() async {
    pass = await getPassword();
    printRedColor("$pass : ${sharedPreferences.getString('login_type')}");
    isload = false;
    update();
    super.onInit();
  }
}
