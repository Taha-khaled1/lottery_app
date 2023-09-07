import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:free_lottery/data_layer/models/winner_model.dart';
import 'package:free_lottery/presentation_layer/components/nav_bar.dart';
import 'package:free_lottery/presentation_layer/resources/color_manager.dart';
import 'package:free_lottery/presentation_layer/resources/font_manager.dart';
import 'package:free_lottery/presentation_layer/resources/styles_manager.dart';
import 'package:free_lottery/presentation_layer/src/get_packge.dart';
import 'package:free_lottery/presentation_layer/utils/responsive_design/ui_components/info_widget.dart';
import 'package:lottie/lottie.dart';

import '../../utils/shard_function/image_checker.dart';

class AwardScreen extends StatelessWidget {
  final WinnerModel winnerModel;
  const AwardScreen({Key? key, required this.winnerModel}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorManager.background,
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Get.offAll(() => MainScreen());
          },
          icon: Icon(Icons.arrow_back, color: ColorManager.black),
        ),
        title: Text(
          "Return to the main page",
          style: MangeStyles().getBoldStyle(
            color: ColorManager.black,
            fontSize: FontSize.s20,
          ),
        ),
      ),
      body: InfoWidget(
        builder: (context, deviceInfo) {
          return Center(
            child: SingleChildScrollView(
              child: Stack(
                alignment: AlignmentDirectional.center,
                children: [
                  Transform.translate(
                    offset: Offset(-80, 0),
                    child: Lottie.asset(
                      "assets/json/winner.json",
                      height: 550,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 0),
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: FractionalTranslation(
                        translation:
                            Offset(0.0, -0.5), // Adjust vertical position
                        child: ClipOval(
                          child: CachedNetworkImage(
                            imageUrl: imageNetworkCheck(winnerModel.image),
                            width: 150,
                            height: 150,
                            fit: BoxFit.cover,
                            placeholder: (context, url) =>
                                CircularProgressIndicator(),
                            errorWidget: (context, url, error) => Image.network(
                              'https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_1280.png',
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  Transform.translate(
                    offset: Offset(0, 50),
                    child: Text(
                      winnerModel.name,
                      style: MangeStyles().getBoldStyle(
                        color: ColorManager.black,
                        fontSize: FontSize.s22,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
