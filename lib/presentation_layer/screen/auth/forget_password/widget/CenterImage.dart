import 'package:flutter/material.dart';

class CenterImage extends StatelessWidget {
  const CenterImage({
    super.key,
    required this.image,
    required this.width,
    required this.height,
  });
  final String image;
  final double width, height;
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: Container(
        alignment: Alignment.center,
        width: width,
        height: height,
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
          color: Colors.white,
          image: DecorationImage(
            alignment: Alignment.center,
            image: AssetImage(image),
          ),
        ),
      ),
    );
  }
}
