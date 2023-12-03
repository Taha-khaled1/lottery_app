import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

import 'package:share_plus/share_plus.dart';
import 'package:free_lottery/presentation_layer/components/appbar.dart';
import 'package:free_lottery/presentation_layer/resources/color_manager.dart';

class ShareApp extends StatelessWidget {
  const ShareApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appbar(),
      backgroundColor: ColorManager.background,
      body: LayoutBuilder(
        builder: (context, deviceInfo) {
          return SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: 45,
                ),
                Lottie.asset(
                  "assets/json/share.json",
                  height: 400,
                  width: deviceInfo.maxWidth * 0.95,
                ),
                Text(
                  'share app',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 12),
                // const SizedBox(height: 33),
                SizedBox(
                  height: 50,
                  width: Get.width * 0.4,
                  child: ElevatedButton.icon(
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all(ColorManager.kPrimary),
                    ),
                    onPressed: () async {
                      try {
                        final box = context.findRenderObject() as RenderBox?;

                        await Share.share(
                          'https://play.google.com/store/apps/details?id=com.lottorealm.freewin',
                          sharePositionOrigin:
                              box!.localToGlobal(Offset.zero) & box.size,
                        );
                        //  Share.share('check out my website https://example.com');
                      } catch (e) {
                        print('erorrrr  :  $e');
                      }
                    },
                    icon: const Icon(Icons.share),
                    label: Text('share app'),
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
