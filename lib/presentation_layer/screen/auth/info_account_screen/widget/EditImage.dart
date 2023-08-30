import 'package:flutter/material.dart';
import 'package:free_lottery/presentation_layer/screen/auth/info_account_screen/widget/custom_circle_Image.dart';

class EditImage extends StatelessWidget {
  const EditImage({
    super.key,
    required this.image,
  });
  final String image;
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: Stack(
        children: [
          CustomCircleImage(
            radius: 70,
            image: image,
          ),
          Positioned(
            right: 8,
            bottom: 5,
            child: InkWell(
              child: Container(
                alignment: Alignment.center,
                width: 28,
                height: 28,
                decoration: BoxDecoration(
                  // color: Colors.blue,
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Image.asset('assets/icons/Edit_Square.png'),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
