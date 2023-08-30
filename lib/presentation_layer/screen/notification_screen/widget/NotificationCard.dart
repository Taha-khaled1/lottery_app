import 'package:flutter/material.dart';
import 'package:free_lottery/data_layer/models/notf_model.dart';
import 'package:free_lottery/presentation_layer/resources/color_manager.dart';
import 'package:free_lottery/presentation_layer/resources/font_manager.dart';
import 'package:free_lottery/presentation_layer/resources/styles_manager.dart';

class NotificationCard extends StatelessWidget {
  const NotificationCard({
    super.key,
    required this.notfModel,
  });
  final NotfModel notfModel;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 380,
      height: 120,
      padding: const EdgeInsets.only(
        top: 20,
        left: 20,
        right: 24,
        bottom: 20,
      ),
      margin: EdgeInsets.only(top: 15, right: 10, left: 10),
      decoration: ShapeDecoration(
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        shadows: [
          BoxShadow(
            color: Color(0x0C04060F),
            blurRadius: 60,
            offset: Offset(0, 4),
            spreadRadius: 0,
          )
        ],
      ),
      child: Row(
        children: [
          Image.asset(notfModel.image),
          SizedBox(width: 10),
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  notfModel.title,
                  style: MangeStyles().getRegularStyle(
                    color: ColorManager.black,
                    fontSize: FontSize.s20,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 7),
                Text(
                  notfModel.subtitle,
                  style: MangeStyles().getRegularStyle(
                    color: ColorManager.black,
                    fontSize: FontSize.s14,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
