import 'package:flutter/material.dart';
import 'package:free_lottery/main.dart';
import 'package:free_lottery/presentation_layer/components/appbar.dart';
import 'package:free_lottery/presentation_layer/components/custom_listtile.dart';
import 'package:free_lottery/presentation_layer/resources/color_manager.dart';
import 'package:free_lottery/presentation_layer/resources/font_manager.dart';
import 'package:free_lottery/presentation_layer/resources/styles_manager.dart';
import 'package:free_lottery/presentation_layer/screen/Pomo_Setting_screen/Pomo_Setting_screen.dart';
import 'package:free_lottery/presentation_layer/screen/auth/info_account_screen/widget/custom_circle_Image.dart';
import 'package:free_lottery/presentation_layer/screen/before_login_screen/before_login_screen.dart';
import 'package:free_lottery/presentation_layer/screen/dashboard/login_dashboard.dart';
import 'package:free_lottery/presentation_layer/screen/edit_screen/edit_screen.dart';
import 'package:free_lottery/presentation_layer/screen/notification_screen/notification_screen.dart';
import 'package:free_lottery/presentation_layer/screen/profile_screen/widget/change_password.dart';
import 'package:free_lottery/presentation_layer/screen/profile_screen/widget/profie_showBottomSheet.dart';
import 'package:free_lottery/presentation_layer/screen/screenseting/privecy_screen.dart';
import 'package:free_lottery/presentation_layer/screen/screenseting/sharescreen.dart';
import 'package:free_lottery/presentation_layer/screen/screenseting/terms_screen.dart';
import 'package:free_lottery/presentation_layer/src/get_packge.dart';
import 'package:free_lottery/presentation_layer/utils/is_login/is_login.dart';
import 'package:free_lottery/presentation_layer/utils/responsive_design/ui_components/info_widget.dart';
import 'package:free_lottery/presentation_layer/utils/shard_function/image_checker.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';

import '../../resources/strings_manager.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return isLogin()
        ? Scaffold(
            backgroundColor: ColorManager.background,
            appBar: appbar(title: 'Profile', isBack: false),
            body: InfoWidget(
              builder: (context, deviceInfo) {
                return SingleChildScrollView(
                  child: Column(
                    children: [
                      CustomCircleImage(
                        radius: 70,
                        image: imageNetworkCheck(
                          sharedPreferences.getString("image"),
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        sharedPreferences.getString('name') ?? "non-name",
                        style: MangeStyles().getBoldStyle(
                          color: ColorManager.black,
                          fontSize: FontSize.s25 - 1,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 10),
                      Text(
                        sharedPreferences.getString('email')!,
                        style: MangeStyles().getRegularStyle(
                          color: ColorManager.black,
                          fontSize: FontSize.s14,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 30),
                      CustomListtile(
                        onTap: () {
                          Get.to(() => EditScreen());
                        },
                        titel: 'Edit Profile',
                        image: 'assets/icons/Profile.svg',
                      ),
                      CustomListtile(
                        onTap: () {
                          Get.to(() => NotificationScreen());
                        },
                        titel: 'Notifications',
                        image: 'assets/icons/notfiction.svg',
                      ),
                      CustomListtile(
                        onTap: () {
                          Get.to(() => PomoSettingScreen());
                        },
                        titel: 'app Settings',
                        image: 'assets/icons/star.svg',
                      ),
                      CustomListtile(
                        onTap: () {
                          changePasswordhowBottomSheet(context);
                        },
                        titel: 'change password',
                        // image: 'assets/icons/star.svg',
                        widget: Icon(Icons.password),
                      ),
                      CustomListtile(
                        onTap: () {
                          Get.to(() => ShareApp());
                        },
                        titel: 'Share App',
                        widget: Icon(
                          Icons.share_outlined,
                          color: ColorManager.kTextlightgray,
                        ),
                      ),
                      CustomListtile(
                        onTap: () {
                          Get.to(() => PrivacyScreen());
                        },
                        titel: 'Privacy Policy',
                        widget: Icon(
                          Icons.help_outline_rounded,
                          color: ColorManager.kTextlightgray,
                        ),
                      ),
                      CustomListtile(
                        onTap: () {
                          Get.to(() => TermsAndConditionsPage());
                        },
                        titel: 'Terms and Conditions',
                        image: 'assets/icons/Security.svg',
                      ),
                      if (userApp?.type == "admin")
                        CustomListtile(
                          onTap: () {
                            Get.to(() => LoginDashboardScreen());
                          },
                          titel: 'Dashboard',
                          image: 'assets/icons/Profile.svg',
                        ),
                      CustomListtile(
                        onTap: () {
                          customLogoutShowBottomSheet(context);
                        },
                        titel: 'Logout',
                        image: 'assets/icons/Logout.svg',
                      ),
                      CustomListtile(
                        onTap: () {
                          QuickAlert.show(
                            showCancelBtn: true,
                            context: context,
                            type: QuickAlertType.warning,
                            text: AppStrings.deleteAccountMessage.tr,
                            title: AppStrings.deleteAccountConfirmation.tr,
                            cancelBtnText: AppStrings.cancel.tr,
                            confirmBtnText: AppStrings.yes.tr,
                            confirmBtnColor: ColorManager.error,
                            onCancelBtnTap: () {
                              Get.back();
                            },
                            onConfirmBtnTap: () {
                              QuickAlert.show(
                                context: context,
                                type: QuickAlertType.warning,
                                text: AppStrings.deleteAccountWarning.tr,
                                title: AppStrings.status.tr,
                                onConfirmBtnTap: () {
                                  Get.back();
                                  Get.back();
                                },
                              );
                            },
                          );
                        },
                        titel: AppStrings.deleteAccount.tr,
                        widget: Icon(
                          Icons.dangerous_outlined,
                          color: Colors.redAccent,
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          )
        : BeforeLoginScreen();
  }
}
