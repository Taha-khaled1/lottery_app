import '../../../src/style_packge.dart';

class HeaderText extends StatelessWidget {
  const HeaderText({
    super.key,
    required this.title,
  });
  final String title;
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 12, left: 14, top: 10),
        child: Text(
          title,
          style: MangeStyles().getBoldStyle(
            color: ColorManager.black,
            fontSize: FontSize.s22,
          ),
        ),
      ),
    );
  }
}
