import 'package:flutter/material.dart';
import 'package:free_lottery/presentation_layer/screen/auth/LoginScreen/widget/circle_social_button.dart';
import 'package:free_lottery/presentation_layer/screen/auth/social_login/social_login.dart';

class StandSocialLogin extends StatelessWidget {
  const StandSocialLogin({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        CircleSocialButton(
          image: 'assets/icons/google.svg',
          onTap: signInWithGoogle,
        ),
      ],
    );
  }
}
