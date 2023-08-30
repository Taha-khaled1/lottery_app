import 'package:flutter/material.dart';

class EndAuthPage extends StatelessWidget {
  const EndAuthPage({
    super.key,
    required this.title,
    this.onTap,
    required this.title2,
  });
  final String title, title2;
  final void Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 380,
      height: 20,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            title,
            textAlign: TextAlign.right,
            style: TextStyle(
              color: Color(0xFF9E9E9E),
              fontSize: 14,
              fontFamily: 'Urbanist',
              fontWeight: FontWeight.w400,
              height: 1.40,
              letterSpacing: 0.20,
            ),
          ),
          const SizedBox(width: 8),
          GestureDetector(
            onTap: onTap,
            child: Text(
              title2,
              style: TextStyle(
                color: Color(0xFF7206FC),
                fontSize: 14,
                fontFamily: 'Urbanist',
                fontWeight: FontWeight.w600,
                height: 1.40,
                letterSpacing: 0.20,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
