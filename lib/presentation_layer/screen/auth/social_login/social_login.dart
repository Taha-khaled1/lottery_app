import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:free_lottery/main.dart';
import 'package:free_lottery/presentation_layer/components/appbar.dart';
import 'package:free_lottery/presentation_layer/components/custom_butten.dart';
import 'package:free_lottery/presentation_layer/components/nav_bar.dart';
import 'package:free_lottery/presentation_layer/resources/color_manager.dart';
import 'package:free_lottery/presentation_layer/resources/font_manager.dart';
import 'package:free_lottery/presentation_layer/resources/styles_manager.dart';
import 'package:free_lottery/presentation_layer/screen/auth/LoginScreen/login_screen.dart';
import 'package:free_lottery/presentation_layer/screen/auth/info_account_screen/info_account_screen.dart';
import 'package:free_lottery/presentation_layer/screen/auth/siginUp_screen/siginUp_screen.dart';
import 'package:free_lottery/presentation_layer/screen/auth/social_login/widget/EndAuthPage.dart';
import 'package:free_lottery/presentation_layer/screen/auth/social_login/widget/custom_dvider.dart';
import 'package:free_lottery/presentation_layer/screen/auth/social_login/widget/social_card.dart';
import 'package:free_lottery/presentation_layer/src/get_packge.dart';
import 'package:free_lottery/presentation_layer/src/show_toast.dart';
import 'package:free_lottery/presentation_layer/utils/NotificationHandler.dart';
import 'package:free_lottery/presentation_layer/utils/responsive_design/ui_components/info_widget.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SocialScreen extends StatelessWidget {
  const SocialScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.background,
      appBar: appbar(),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          SizedBox(height: 10),
          Text(
            'Let’s you in',
            style: MangeStyles().getBoldStyle(
              color: ColorManager.black,
              fontSize: FontSize.s40,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 30),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Column(
              children: [
                SocialCard(
                  image: 'assets/icons/facebook.svg',
                  title: 'Continue with Facebook',
                  onTap: () {
                    showToast("This feature has not been added yet");
                  },
                ),
                SizedBox(height: 15),
                SocialCard(
                  image: 'assets/icons/google.svg',
                  title: 'Continue with Google',
                  onTap: signInWithGoogle,
                ),
                SizedBox(height: 15),
                // SocialCard(
                //   image: 'assets/icons/apple.svg',
                //   title: 'Continue with Apple',
                // ),
              ],
            ),
          ),
          SizedBox(height: 15),
          CustomDvider(title: 'or'),
          InfoWidget(
            builder: (context, deviceInfo) {
              return CustomButton(
                width: deviceInfo.localWidth * 0.8,
                rectangel: 18,
                height: 60,
                color: ColorManager.kPrimaryButton,
                text: "Sign in with password",
                press: () {
                  Get.to(() => LoginScreen());
                },
              );
            },
          ),
          EndAuthPage(
            title: 'Don’t have an account?',
            title2: 'Sign up',
            onTap: () {
              Get.to(() => SiginUpScreen());
            },
          ),
        ],
      ),
    );
  }
}

saveInformition({
  required String displayName,
  required String email,
  required String image,
  required String id,
}) {
  sharedPreferences.setString(
    'name',
    displayName,
  );
  sharedPreferences.setString(
    'email',
    email,
  );
  sharedPreferences.setString(
    'image',
    image,
  );
  sharedPreferences.setString('id', id);
}

Future<UserCredential> signInWithGoogle() async {
  // Trigger the authentication flow
  final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

  // Obtain the auth details from the request
  final GoogleSignInAuthentication? googleAuth =
      await googleUser?.authentication;

  // Create a new credential
  final credential = GoogleAuthProvider.credential(
    accessToken: googleAuth?.accessToken,
    idToken: googleAuth?.idToken,
  );
  final CollectionReference usersCollection =
      FirebaseFirestore.instance.collection('users');
  UserCredential googelInfo =
      await FirebaseAuth.instance.signInWithCredential(credential);
  if (googelInfo.user != null) {
    saveInformition(
      displayName: googelInfo.user!.displayName!,
      email: googelInfo.user!.email!,
      image: googelInfo.user!.photoURL!,
      id: googelInfo.user!.uid,
    );
    final String userId = sharedPreferences.getString('id')!;
    final userDoc = FirebaseFirestore.instance
        .collection('users')
        .doc(sharedPreferences.getString('id'));
    String token = await NotificationHandler().userToken();
    usersCollection.doc(googelInfo.user!.uid).get().then((docSnapshot) {
      if (docSnapshot.exists) {
        print("---->   ${docSnapshot.data()}");
        print("---->   ${docSnapshot["image"]}");
        sharedPreferences.setString(
          'code',
          docSnapshot["code"] ?? 'US',
        );
        sharedPreferences.setString(
          'phone',
          docSnapshot["phone"] ?? '0',
        );
        Get.offAll(() => MainScreen());
        sharedPreferences.setString("lev", '2');
      } else {
        userDoc.set({
          'name': sharedPreferences.getString('name'),
          'userId': sharedPreferences.getString('id'),
          'image': sharedPreferences.getString('image'),
          'phone': "000000",
          'code': "US",
          'wallet': "0",
          "fcm": token,
        });
        Get.offAll(() => InfoAccount(
              isgoogle: true,
            ));
      }
    });
  }
  // Once signed in, return the UserCredential
  return await googelInfo;
}
