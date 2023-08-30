import 'package:flutter/material.dart';
import 'package:free_lottery/presentation_layer/resources/color_manager.dart';
import 'package:free_lottery/presentation_layer/resources/font_manager.dart';
import 'package:free_lottery/presentation_layer/resources/styles_manager.dart';
import 'package:free_lottery/presentation_layer/screen/sound_screen/sound_screen.dart';

class SoundCard extends StatelessWidget {
  const SoundCard({
    super.key,
    required this.onChanged,
    required this.title,
    required this.valueSelected,
    this.onTap,
  });
  final void Function(int?)? onChanged;
  final String title;
  final int valueSelected;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 380,
      height: 84,
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
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
      child: Stack(
        children: [
          RadioListTile<int>(
            activeColor: ColorManager.kPrimary,
            fillColor: MaterialStateProperty.all(ColorManager.kPrimary),
            title: Text(
              title,
              style: MangeStyles().getRegularStyle(
                color: ColorManager.kTextBlack,
                fontSize: FontSize.s20,
              ),
            ),
            value: valueSelected,
            groupValue: selectedOption,
            onChanged: onChanged,
            selected: true,
          ),
          Positioned(
            top: 5,
            right: 0,
            child: Container(
              alignment: Alignment.center,
              width: 38,
              height: 38,
              decoration: ShapeDecoration(
                gradient: LinearGradient(
                  begin: Alignment(-0.96, 0.28),
                  end: Alignment(0.96, -0.28),
                  colors: [Color(0xFF1AB65C), Color(0xFF39E180)],
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(100),
                ),
              ),
              child: GestureDetector(
                onTap: onTap,
                child: Icon(
                  valueSelected != selectedOption
                      ? Icons.play_arrow
                      : Icons.stop,
                  color: ColorManager.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
