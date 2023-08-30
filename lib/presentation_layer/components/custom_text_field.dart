import 'package:free_lottery/presentation_layer/src/style_packge.dart';

class CustomTextfield extends StatelessWidget {
  final String titel;
  final bool? obsecuer;
  final IconData? icon;
  final void Function()? iconontap;
  final String? Function(String?)? onsaved;
  final String? Function(String?)? valid;
  final double width, height;
  final TextDirection? textDirection;
  final String? inialvalue;
  final BorderStyle? isBoarder;
  final int? maxLines;
  final Color? fillColor;
  final bool? isenabledBorder;
  final bool readOnly;
  final void Function()? onTap;
  final void Function(String)? onChanged;
  final TextEditingController? textController;
  const CustomTextfield({
    super.key,
    this.iconontap,
    this.obsecuer,
    this.icon,
    required this.valid,
    required this.onsaved,
    required this.titel,
    required this.width,
    required this.height,
    this.textDirection,
    this.inialvalue,
    this.isBoarder,
    this.maxLines,
    this.fillColor,
    this.isenabledBorder = true,
    this.readOnly = false,
    this.onTap,
    this.onChanged,
    this.textController,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      //  height: height,
      child: TextFormField(
        controller: textController,
        cursorColor: Colors.black,
        style: TextStyle(color: ColorManager.black, fontSize: 18),
        autocorrect: false,
        enableSuggestions: false,
        onTap: onTap,
        readOnly: readOnly,
        // maxLines: maxLines,
        initialValue: inialvalue,
        textDirection: textDirection,
        obscureText: obsecuer == null ? false : obsecuer!,
        onSaved: onsaved,
        validator: valid,
        onChanged: onChanged,
        decoration: InputDecoration(
          prefixIcon: icon != null
              ? IconButton(
                  onPressed: iconontap,
                  icon: Icon(icon),
                )
              : null,

          enabledBorder: isenabledBorder == true
              ? OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide.none,
                )
              : null,
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(
              width: 1.2,
              // style: BorderStyle.none,
              color: ColorManager.kPrimary,
            ), //<-- SEE HERE
          ),

          //  enabled: true,
          filled: true,
          fillColor: ColorManager.fillColor,
          hintText: titel,
          hintStyle: TextStyle(
            color: Color(0xFF9E9E9E),
            fontSize: 14,
            fontFamily: 'Urbanist',
            fontWeight: FontWeight.w400,
            height: 1.40,
            letterSpacing: 0.20,
          ),
        ),
      ),
    );
  }
}
