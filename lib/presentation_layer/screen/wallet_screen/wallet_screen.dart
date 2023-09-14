import 'package:flutter/material.dart';
import 'package:free_lottery/main.dart';
import 'package:free_lottery/presentation_layer/screen/before_login_screen/before_login_screen.dart';
import 'package:free_lottery/presentation_layer/screen/wallet_screen/TopSection.dart';
import 'package:free_lottery/presentation_layer/screen/wallet_screen/wallet_controller/wallet_controller.dart';
import 'package:free_lottery/presentation_layer/screen/wallet_screen/widget/TransactionWidget.dart';
import 'package:free_lottery/presentation_layer/screen/wallet_screen/widget/WithdrawalsList.dart';
import 'package:free_lottery/presentation_layer/utils/is_login/is_login.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:free_lottery/data_layer/models/task_model.dart';
import 'package:free_lottery/presentation_layer/components/appbar.dart';
import 'package:free_lottery/presentation_layer/resources/color_manager.dart';
import 'package:free_lottery/presentation_layer/resources/font_manager.dart';
import 'package:free_lottery/presentation_layer/resources/styles_manager.dart';
import 'package:free_lottery/presentation_layer/utils/responsive_design/ui_components/info_widget.dart';

class WalletScreen extends StatelessWidget {
  const WalletScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final WalletController _controller = Get.put(WalletController());
    return isLogin()
        ? Scaffold(
            backgroundColor: ColorManager.background,
            appBar: appbarProfile(title: 'Wallet', isBack: false),
            body: InfoWidget(
              builder: (context, deviceInfo) {
                return SingleChildScrollView(
                  child: Column(
                    children: [
                      FutureBuilder(
                        builder: (ctx, snapshot) {
                          // Checking if future is resolved or not
                          if (snapshot.connectionState ==
                              ConnectionState.done) {
                            // If we got an error
                            if (snapshot.hasError) {
                              return Center(
                                child: Text(
                                  '${snapshot.error} occurred',
                                  style: TextStyle(fontSize: 18),
                                ),
                              );

                              // if we got our data
                            } else if (snapshot.hasData) {
                              final data = snapshot.data;
                              // int totalTasks = data!.length;
                              return Column(
                                children: [
                                  TopSection(
                                    homeController: _controller,
                                    deviceInfo: deviceInfo,
                                  ),
                                  SizedBox(height: 10),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 20,
                                      vertical: 0,
                                    ),
                                    child: Align(
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        "financial transactions",
                                        style: MangeStyles().getRegularStyle(
                                          color: ColorManager.black,
                                          fontSize: FontSize.s20,
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                  ),
                                  WithdrawalsList(
                                      userId:
                                          sharedPreferences.getString("id")!),
                                ],
                              );
                            }
                          }

                          // Displaying LoadingSpinner to indicate waiting state
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        },

                        // Future that needs to be resolved
                        // inorder to display something on the Canvas
                        future: _controller
                            .fetchUserData(sharedPreferences.getString("id")!),
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
