import 'package:free_lottery/presentation_layer/screen/auth/LoginScreen/login_screen.dart';
import 'package:free_lottery/presentation_layer/src/get_packge.dart';
// import 'package:free_lottery/presentation_layer/screen/notification_screen/notification_screen.dart';
// import 'package:free_lottery/presentation_layer/screen/profile_screen/profile_screen.dart';
import 'package:free_lottery/presentation_layer/src/style_packge.dart';
import 'package:free_lottery/presentation_layer/utils/is_login/is_login.dart';

PreferredSizeWidget appbar({String? title, bool isBack = true}) {
  return AppBar(
    elevation: 0,
    backgroundColor: ColorManager.background,
    leading: isBack == true
        ? BackButton(
            color: ColorManager.black,
          )
        : SizedBox(),
    centerTitle: false,
    title: Transform.translate(
      offset: Offset(isBack == false ? -38 : 0, 0),
      child: Text(
        title ?? '',
        style: TextStyle(
          color: Color(0xFF212121),
          fontSize: 24,
          fontFamily: 'Cairo',
          fontWeight: FontWeight.w700,
          height: 1.20,
        ),
      ),
    ),
    actions: [
      if (!isLogin())
        Row(
          children: [
            Transform.translate(
              offset: Offset(0, -3),
              child: Text(
                "login",
                style: MangeStyles().getBoldStyle(
                  color: ColorManager.black,
                  fontSize: FontSize.s18,
                ),
              ),
            ),
            IconButton(
              onPressed: () {
                Get.to(() => LoginScreen());
              },
              icon: Icon(Icons.login, color: ColorManager.black),
            ),
          ],
        ),
    ],
  );
}
