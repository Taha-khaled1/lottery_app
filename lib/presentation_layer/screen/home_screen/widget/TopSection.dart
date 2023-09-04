import 'package:flutter/material.dart';
import 'package:free_lottery/presentation_layer/components/custom_butten.dart';
import 'package:free_lottery/presentation_layer/resources/color_manager.dart';
import 'package:free_lottery/presentation_layer/resources/font_manager.dart';
import 'package:free_lottery/presentation_layer/resources/styles_manager.dart';
import 'package:free_lottery/presentation_layer/screen/home_screen/home_controller/home_controller.dart';
import 'package:free_lottery/presentation_layer/screen/home_screen/widget/stopwatch.dart';
import 'package:free_lottery/presentation_layer/utils/responsive_design/models/device_info.dart';
import 'package:lottie/lottie.dart';

import 'WithdrawDialog.dart';

class TopSection extends StatelessWidget {
  const TopSection({
    super.key,
    required this.homeController,
    required this.deviceInfo,
  });

  final HomeController homeController;
  final DeviceInfo deviceInfo;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: deviceInfo.localWidth * 0.88,
      height: 180,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25),
        gradient: LinearGradient(
          begin: Alignment(-0.96, 0.28),
          end: Alignment(0.96, -0.28),
          colors: [Color(0xFF7306FD), Color(0xFFB173FF)],
        ),
        image: DecorationImage(
          image: AssetImage('assets/images/backrr.png'),
          fit: BoxFit.cover,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          // Wallet with total profits
          Column(
            children: [
              SizedBox(
                height: 10,
              ),
              Text(
                "Wallet",
                style: MangeStyles().getBoldStyle(
                  color: ColorManager.white,
                  fontSize: FontSize.s25,
                ),
              ),
              // SizedBox(height: 10),
              Text(
                "\$2,430.00",
                style: MangeStyles().getBoldStyle(
                  color: ColorManager.white,
                  fontSize: FontSize.s25,
                ),
              ),
            ],
          ),
          // SizedBox(height: 20),

          Transform.translate(
            offset: Offset(-12, 0),
            child: GestureDetector(
              onTap: () {
                showWithdrawDialog(context);
              },
              child: SizedBox(
                width: deviceInfo.localWidth * 0.6,
                height: 100,
                child: Stack(
                  children: [
                    Lottie.asset(
                      "assets/json/anmieButton.json",
                      fit: BoxFit.cover,
                      height: 100,
                      width: deviceInfo.localWidth * 0.6,
                    ),
                    Positioned(
                      right: 0,
                      left: 47,
                      top: 35,
                      child: Text(
                        "withdrawal request",
                        style: MangeStyles().getBoldStyle(
                          color: ColorManager.white,
                          fontSize: FontSize.s18,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          // CustomButton(
          //   width: deviceInfo.localWidth * 0.6,
          //   height: 55,
          //   color: ColorManager.kPrimary,
          //   text: "withdrawal request",
          //   press: () {
          //     // CountDownTimerPage.navigatorPush(context);

          //     // homeController.startPomo();
          //   },
          // ),
        ],
      ),
    );
  }
}

class LowerSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Current Prize
        Text("Upcoming Prize: \$5000",
            style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.green)),
        SizedBox(height: 20),

        // Buttons
        ElevatedButton(
          onPressed: () {
            // Logic for getting a free ticket
          },
          child: Text("Get a Free Ticket"),
        ),
        SizedBox(height: 10),
        ElevatedButton(
          onPressed: () {
            // Logic for buying a ticket
          },
          child: Text("Buy a Ticket"),
        ),
        SizedBox(height: 20),

        // Previous Prize
        Text("Last Prize: \$1000",
            style: TextStyle(fontSize: 20, color: Colors.grey)),
      ],
    );
  }
}



                // Row(
                //   children: [
                    // CustomButton(
                    //   width: deviceInfo.localWidth * 0.45,
                    //   height: 55,
                    //   color: ColorManager.kPrimary,
                    //   text: "Get ads",
                    //   press: () {
                    //     homeController.startPomo();
                    //   },
                    // ),
                //     CustomButton(
                //       width: deviceInfo.localWidth * 0.45,
                //       height: 55,
                //       color: ColorManager.grey2,
                //       text: "Get Tiket",
                //       colorText: Colors.black,
                //       press: () {},
                //     ),
                //   ],
                // )