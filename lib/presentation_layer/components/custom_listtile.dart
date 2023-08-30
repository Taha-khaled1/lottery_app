// ignore_for_file: deprecated_member_use

import 'package:flutter_svg/svg.dart';
import 'package:free_lottery/presentation_layer/src/style_packge.dart';

class CustomListtile extends StatelessWidget {
  const CustomListtile({
    Key? key,
    this.image,
    required this.onTap,
    required this.titel,
    this.textStyle,
    this.widget,
    this.color,
    this.istr = false,
  }) : super(key: key);
  final void Function()? onTap;
  final String? image, titel;
  final TextStyle? textStyle;
  final Widget? widget;
  final Color? color;
  final bool istr;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: istr ? 0 : 10),
      child: ListTile(
        onTap: onTap,
        leading: widget == null
            ? image != null
                ? SvgPicture.asset(
                    image!,
                    color: Colors.black,
                    height: 25,
                  )
                : null
            : widget,
        title: Text(
          titel!,
          style: textStyle ??
              MangeStyles().getBoldStyle(
                color: color ?? ColorManager.kTextlightgray,
                fontSize: FontSize.s16,
              ),
        ),
        trailing: istr
            ? Transform.translate(
                offset: Offset(15, 0),
                child: const Icon(
                  Icons.arrow_forward_ios,
                  color: Colors.black,
                ),
              )
            : SizedBox(),
      ),
    );
  }
}
