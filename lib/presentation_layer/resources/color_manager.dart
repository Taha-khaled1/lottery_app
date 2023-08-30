import 'package:flutter/material.dart';

class ColorManager {
  //------------------------main color----------------------------
  static const Color kPrimary = const Color(0xFF7206FC);
  static const Color kPrimary2 = const Color(0xff747281);
  static const Color background = Color.fromARGB(255, 250, 250, 250);
  static const Color kTextlightgray = const Color(0xFF616161);
  static const Color kTextBlack = const Color(0xFF212121);
  static const Color white = Color.fromARGB(255, 250, 250, 250);
  static const Color black = const Color(0xff000000);
  static const Color kPrimaryButton = const Color(0xFF7206FC);

  static const Color fillColor = const Color(0xFFF9F9F9);

  LinearGradient kPrimaryGradient = LinearGradient(
    begin: Alignment(-0.96, 0.28),
    end: Alignment(0.96, -0.28),
    colors: [Color(0xFF1AB65C), Color(0xFF39E180)],
  );
  // new colors

  // static const Color lightPrimary = const Color(0xCCd17d11); // color with 80% opacity
  static const Color backgroundpersonalimage = const Color(0xff63edff);
  static const Color grey2 = const Color(0xffEDEDED);
  static const Color switchcolor = const Color(0xff86FFC5);

  static const Color navbar = const Color(0xffC0C0C0);
  static const Color ktextlabny = const Color(0xff3AB0FF);
  static const Color error = const Color(0xffe61f34); // red color
  static const Color controlercolor = const Color(0xff385CAD);
  //------------------------text color----------------------------
  static const Color containacolor1 = const Color(0xff747281);
  static const Color containacolor2 = const Color(0xff709AFF);
  static const Color containacolor3 = const Color(0xff66FFA3);
}
