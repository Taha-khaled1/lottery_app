import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:free_lottery/main.dart';
import 'package:free_lottery/presentation_layer/components/nav_bar.dart';
import 'package:free_lottery/presentation_layer/src/show_toast.dart';
import 'package:free_lottery/presentation_layer/src/style_packge.dart';
import 'package:fluttertoast/fluttertoast.dart';

class LoginController extends GetxController {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  bool isCheckBox = false;
  String? emailAddress, password;
  void updateCheckBox(bool val) {
    isCheckBox = val;
    update();
  }

  bool isload = false;
  signInWithEmailAndPassword() async {
    try {
      isload = true;
      update();
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailAddress!, password: password!);
      final userId = credential.user!.uid;
      sharedPreferences.setString('id', userId);
      sharedPreferences.setString('email', credential.user!.email!);
      var user = await FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .get();
      sharedPreferences.setString('image', user['image'] ?? '');
      sharedPreferences.setString('name', user['name'] ?? '');
      sharedPreferences.setString('phone', user['phone'] ?? '');
      sharedPreferences.setString("lev", '2');
      Get.offAll(() => MainScreen());
      showToast(
        'You are logged in successfully. Welcome.${user['name'] ?? ''}',
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        showToast('No user found for that email.');
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        showToast('Wrong password provided for that user.');
        print('Wrong password provided for that user.');
      }
    }
    isload = false;
    update();
  }
}
