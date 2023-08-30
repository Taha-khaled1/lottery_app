import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomCircleImage extends StatelessWidget {
  const CustomCircleImage(
      {Key? key, required this.radius, this.image, this.isWidget = false})
      : super(key: key);
  final double radius;
  final String? image;
  final bool? isWidget;
  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: radius,
      // استخدام عنصر ClipOval لعرض الصورة بشكل كامل داخل دائرة CircleAvatar
      child: ClipOval(
        child: CachedNetworkImage(
          errorWidget: (context, url, error) {
            return Image.network(
              'https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_1280.png',
            );
          },
          placeholder: (context, url) {
            return CircularProgressIndicator(
              color: Colors.purple,
            );
          },
          imageUrl:
              image!, //?? sharedPreferences.getString('image').toString(),
          width: radius * 2,
          height: radius * 2,
          fit: BoxFit
              .fill, // تحديد كيفية توسيط وتغطية الصورة داخل دائرة ال CircleAvatar
        ),
      ),
    );
  }
}

class CustomCircleImageAsset extends StatelessWidget {
  const CustomCircleImageAsset(
      {Key? key,
      required this.radius,
      this.image,
      required this.color,
      this.onTap})
      : super(key: key);
  final double radius;
  final String? image;
  final Color? color;
  final void Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: CircleAvatar(
        backgroundColor: color,
        radius: radius,
        child: ClipOval(
          child: SvgPicture.asset(
            image!,
            width: radius / 1.2,
            height: radius / 1.2,
          ),
        ),
      ),
    );
  }
}
