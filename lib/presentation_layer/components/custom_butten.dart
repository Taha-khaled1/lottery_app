import 'package:free_lottery/presentation_layer/src/style_packge.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    required this.width,
    required this.height,
    required this.color,
    required this.text,
    required this.press,
    this.rectangel,
    this.colorText,
    this.colorborder,
    this.sideIs,
    this.fontSize,
    this.boxShadowValue,
  });

  final Color color;
  final String text;
  final double width, height;
  final void Function()? press;
  final double? rectangel;
  final Color? colorText;
  final Color? colorborder;
  final BorderSide? sideIs;
  final double? fontSize;
  final BoxShadow? boxShadowValue;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(7),
      width: width,
      height: height,
      decoration: ShapeDecoration(
        color: Color(0xFF7206FC),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(rectangel ?? 20),
        ),
        shadows: [
          boxShadowValue ??
              BoxShadow(
                color: Color(0x3FFF575C),
                blurRadius: 24,
                offset: Offset(4, 8),
                spreadRadius: 0,
              )
        ],
      ),
      child: ElevatedButton(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(color),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                side: sideIs ?? BorderSide.none,
                borderRadius: BorderRadius.circular(rectangel ?? 20),
              ),
            ),
          ),
          onPressed: press,
          child: Text(
            text,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: colorText ?? ColorManager.white,
              fontSize: fontSize ?? FontSize.s20,
              fontFamily: 'Urbanist',
              fontWeight: FontWeight.w700,
              height: 1.40,
              letterSpacing: 0.20,
            ),
          )),
    );
  }
}
