import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:free_lottery/presentation_layer/utils/NotificationHandler.dart';
import 'package:get/get.dart';
import 'package:free_lottery/main.dart';
import 'package:free_lottery/presentation_layer/screen/auth/info_account_screen/info_account_screen.dart';
import 'package:free_lottery/presentation_layer/src/show_toast.dart';
import 'package:free_lottery/presentation_layer/src/style_packge.dart';

class SiginUpController extends GetxController {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  bool isCheckBox = false;
  bool isload = false;
  void updateCheckBox(bool val) {
    isCheckBox = val;
    update();
  }

  late String emailAddress, password;

  void createAccount(BuildContext context) async {
    try {
      isload = true;
      update();

      UserCredential credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailAddress,
        password: password,
      );
      sharedPreferences.setString('id', credential.user!.uid);
      sharedPreferences.setString('email', credential.user!.email!);
      final userDoc = FirebaseFirestore.instance
          .collection('users')
          .doc(sharedPreferences.getString('id'));
      String token = await NotificationHandler().userToken();
      await userDoc.set({
        'userId': sharedPreferences.getString('id'),
        'image': sharedPreferences.getString('image'),
        'wallet': "0",
        "fcm": token,
      });
      sharedPreferences.setString('password', password);
      Get.offAll(() => InfoAccount(
            isgoogle: false,
          ));
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        showToast('The password provided is too weak.');
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        showToast('The account already exists for that email.');
        print('The account already exists for that email.');
      }
    } catch (e) {
      showToast('$e.');
      print(e);
    }
    isload = false;
    update();
  }
}
