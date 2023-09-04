import 'dart:io';

import 'package:free_lottery/presentation_layer/resources/color_manager.dart';
import 'package:free_lottery/presentation_layer/resources/font_manager.dart';
import 'package:free_lottery/presentation_layer/resources/strings_manager.dart';
import 'package:free_lottery/presentation_layer/resources/styles_manager.dart';
import 'package:free_lottery/presentation_layer/utils/shard_function/printing_function_red.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class AdmobeController extends GetxController {
  final BuildContext ctx;
  final int maxFailedLoadAttempts = 3;
  final AdRequest request = AdRequest(
    keywords: <String>['foo', 'bar'],
    contentUrl: 'http://foo.com/bar.html',
    nonPersonalizedAds: true,
  );

  // HomeController homeController = Get.find();
  RewardedAd? _rewardedAd;
  int _numRewardedLoadAttempts = 0;

  AdmobeController(this.ctx);
  void _createRewardedAd() {
    RewardedAd.load(
        adUnitId: Platform.isAndroid
            ? 'ca-app-pub-3940256099942544/5224354917'
            : 'ca-app-pub-3940256099942544/1712485313',
        request: request,
        rewardedAdLoadCallback: RewardedAdLoadCallback(
          onAdLoaded: (RewardedAd ad) {
            printRedColor(
              '$ad loaded. loaded loaded loaded loaded loaded loaded loaded loaded loaded loaded loaded',
            );
            showCustomSnackBar(AppStrings.ad_loaded.tr);
            _rewardedAd = ad;
            _numRewardedLoadAttempts = 0;
          },
          onAdFailedToLoad: (LoadAdError error) {
            printRedColor('${AppStrings.something_wrong.tr}: $error');
            _rewardedAd = null;
            _numRewardedLoadAttempts += 1;
            if (_numRewardedLoadAttempts < maxFailedLoadAttempts) {
              _createRewardedAd();
            }
          },
        ));
  }

  void showRewardedAd() {
    if (_rewardedAd == null) {
      printRedColor(AppStrings.show_ad_before_loaded.tr);
      showCustomSnackBar(AppStrings.show_ad_before_loaded.tr);
      return;
    }

    _rewardedAd!.fullScreenContentCallback = FullScreenContentCallback(
      onAdShowedFullScreenContent: (RewardedAd ad) {
        printRedColor('ad onAdShowedFullScreenContent.');
        // showCustomSnackBar('onAdShowedFullScreenContent');
      },
      onAdDismissedFullScreenContent: (RewardedAd ad) {
        printRedColor('$ad onAdDismissedFullScreenContent.');

        ad.dispose();
        _createRewardedAd();
      },
      onAdFailedToShowFullScreenContent: (RewardedAd ad, AdError error) {
        printRedColor('$ad onAdFailedToShowFullScreenContent: $error');
        showCustomSnackBar('${AppStrings.something_wrong.tr}: $error');
        ad.dispose();
        _createRewardedAd();
      },
    );

    _rewardedAd!.setImmersiveMode(true);
    _rewardedAd!.show(
        onUserEarnedReward: (AdWithoutView ad, RewardItem reward) {
      printRedColor(
          '$ad ------------------------------------- with reward $RewardItem(${reward.amount}, ${reward.type})'); // give him coin
      // homeController.getReward();
      Future.delayed(Duration(seconds: 2)).then((value) {
        showCustomSnackBar('${AppStrings.you_got.tr} \$10');
      });
    });
    _rewardedAd = null;
  }

  void showCustomSnackBar(String content) {
    Get.snackbar(
      '',
      '',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.black,
      overlayColor: Colors.black.withOpacity(0.3),
      backgroundGradient: LinearGradient(
        colors: [Colors.red, Colors.redAccent],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      colorText: ColorManager.white,
      duration: Duration(seconds: 1),
      borderRadius: 40,
      margin: EdgeInsets.all(20),
      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 12),
      // borderColor: Color(0xff4A148C),
      // borderWidth: 1,
      animationDuration: Duration(milliseconds: 500),
      isDismissible: true,
      boxShadows: [
        BoxShadow(
          color: Colors.black.withOpacity(0.25),
          spreadRadius: 0,
          blurRadius: 8,
          offset: Offset(0, 4),
        ),
      ],
      dismissDirection: DismissDirection.horizontal,
      snackStyle: SnackStyle.FLOATING,
      titleText: Transform.translate(
        offset: Offset(0, 15),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(color: Colors.orange),
            SizedBox(width: 10),
            Text(
              content,
              style: MangeStyles().getBoldStyle(
                color: ColorManager.white,
                fontSize: FontSize.s16,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  @override
  void onInit() {
    _createRewardedAd();
    super.onInit();
  }

  @override
  void onClose() {
    _rewardedAd?.dispose();
    super.onClose();
  }
}
