import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:free_lottery/presentation_layer/screen/sound_screen/sound_screen.dart';
import 'package:get/get.dart';
import 'package:free_lottery/presentation_layer/components/appbar.dart';
import 'package:free_lottery/presentation_layer/components/custom_listtile.dart';
import 'package:free_lottery/presentation_layer/resources/color_manager.dart';
import 'package:free_lottery/presentation_layer/resources/font_manager.dart';
import 'package:free_lottery/presentation_layer/resources/styles_manager.dart';
import 'package:free_lottery/presentation_layer/utils/responsive_design/ui_components/info_widget.dart';

class PomoSettingScreen extends StatefulWidget {
  const PomoSettingScreen({Key? key}) : super(key: key);

  @override
  State<PomoSettingScreen> createState() => _PomoSettingScreenState();
}

class _PomoSettingScreenState extends State<PomoSettingScreen> {
  bool switch1 = false;
  bool switch2 = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.background,
      appBar: appbar(title: 'Pomo Settings'),
      body: InfoWidget(
        builder: (context, deviceInfo) {
          return Padding(
            padding:
                EdgeInsets.symmetric(horizontal: deviceInfo.localWidth * 0.04),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Do Not Disturb',
                      style: MangeStyles().getRegularStyle(
                        color: ColorManager.black,
                        fontSize: FontSize.s18,
                      ),
                    ),
                    CupertinoSwitch(
                      activeColor: ColorManager.kPrimary,
                      value: switch1,
                      onChanged: (value) {
                        setState(() {
                          switch1 = !switch1;
                        });
                      },
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Reminder',
                      style: MangeStyles().getRegularStyle(
                        color: ColorManager.black,
                        fontSize: FontSize.s18,
                      ),
                    ),
                    CupertinoSwitch(
                      activeColor: ColorManager.kPrimary,
                      value: switch2,
                      onChanged: (value) {
                        setState(() {
                          switch2 = !switch2;
                        });
                      },
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Transform.translate(
                  offset: Offset(-20, 0),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: CustomListtile(
                      onTap: () {
                        Get.to(() => SoundScreen());
                      },
                      istr: true,
                      titel: 'Reminder Ringtone',
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
