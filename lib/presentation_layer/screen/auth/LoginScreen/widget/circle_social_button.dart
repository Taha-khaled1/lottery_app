import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class CircleSocialButton extends StatelessWidget {
  const CircleSocialButton({
    super.key,
    this.onTap,
    required this.image,
  });
  final void Function()? onTap;
  final String image;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        alignment: Alignment.center,
        width: 88,
        height: 60,
        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 18),
        decoration: ShapeDecoration(
          color: Colors.white,
          shape: RoundedRectangleBorder(
            side: BorderSide(width: 0.50, color: Colors.grey.withOpacity(0.5)),
            borderRadius: BorderRadius.circular(16),
          ),
        ),
        child: SvgPicture.asset(image),
      ),
    );
  }
}
