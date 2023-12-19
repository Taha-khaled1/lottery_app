import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:free_lottery/presentation_layer/components/nav_bar.dart';
import 'package:free_lottery/presentation_layer/screen/home_screen/home_screen.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:free_lottery/main.dart';
import 'package:free_lottery/presentation_layer/components/appbar.dart';
import 'package:free_lottery/presentation_layer/components/custom_butten.dart';
import 'package:free_lottery/presentation_layer/components/custom_listtile.dart';
import 'package:free_lottery/presentation_layer/components/custom_text_field.dart';
import 'package:free_lottery/presentation_layer/resources/color_manager.dart';
import 'package:free_lottery/presentation_layer/screen/auth/info_account_screen/widget/EditImage.dart';
import 'package:free_lottery/presentation_layer/src/show_toast.dart';
import 'package:free_lottery/presentation_layer/utils/responsive_design/ui_components/info_widget.dart';

class EditScreen extends StatefulWidget {
  const EditScreen({Key? key}) : super(key: key);

  @override
  State<EditScreen> createState() => _EditScreenState();
}

class _EditScreenState extends State<EditScreen> {
  bool isLoading = false;
  String name = sharedPreferences.getString('name') ?? "name";
  String code = sharedPreferences.getString('code') ?? 'US';
  String number = sharedPreferences.getString('phone') ?? "0";
  String email = sharedPreferences.getString('email') ?? "email@gmail.com";
  @override
  void initState() {
    print('image : ${sharedPreferences.getString('image')}  code : $code');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.background,
      appBar: appbar(title: 'Edit Profile', isBack: true),
      body: InfoWidget(
        builder: (context, deviceInfo) {
          return Align(
            alignment: Alignment.center,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () {
                      _handleAttachmentPressed();
                    },
                    child: EditImage(
                      image: sharedPreferences.getString('image') == null ||
                              sharedPreferences.getString('image')!.isEmpty ||
                              sharedPreferences.getString('image') == ''
                          ? 'https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_1280.png'
                          : sharedPreferences.getString('image')!,
                    ),
                  ),
                  // EditImage(),
                  SizedBox(height: 30),
                  // SizedBox(height: deviceInfo.localHeight * 0.1),
                  CustomTextfield(
                    inialvalue: name,
                    valid: (value) {
                      return null;
                    },
                    onsaved: (value) {
                      return null;
                    },
                    onChanged: (value) {
                      name = value.toString();
                    },
                    titel: 'Full Name',
                    width: deviceInfo.localWidth * 0.85,
                    height: 60,
                  ),
                  // SizedBox(height: 20),
                  // CustomTextfield(
                  //   inialvalue: 'Christina',
                  //   valid: (value) {},
                  //   onsaved: (value) {},
                  //   titel: 'Full Name',
                  //   width: deviceInfo.localWidth * 0.85,
                  //   height: 60,
                  // ),
                  SizedBox(height: 20),
                  CustomTextfield(
                    inialvalue: sharedPreferences.getString('email'),
                    valid: (value) {
                      return null;
                    },
                    onsaved: (value) {
                      return null;
                    },
                    titel: 'Full Email',
                    width: deviceInfo.localWidth * 0.85,
                    height: 60,
                    onChanged: (value) {
                      email = value.toString();
                    },
                  ),
                  SizedBox(height: 20),
                  SizedBox(
                    width: deviceInfo.localWidth * 0.85,
                    child: IntlPhoneField(
                      initialValue: number,
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide.none,
                        ),
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
                        hintText: 'Phone Number',
                        hintStyle: TextStyle(
                          color: Color(0xFF9E9E9E),
                          fontSize: 14,
                          fontFamily: 'Urbanist',
                          fontWeight: FontWeight.w400,
                          height: 1.40,
                          letterSpacing: 0.20,
                        ),
                      ),
                      initialCountryCode: code,
                      onChanged: (phone) {
                        number = phone.completeNumber;
                        code = phone.countryISOCode;
                        print(phone.countryISOCode);
                        print(phone.completeNumber);
                      },
                    ),
                  ),
                  SizedBox(height: 30),
                  CustomButton(
                    boxShadowValue: BoxShadow(),
                    width: deviceInfo.localWidth * 0.85,
                    rectangel: 18,
                    height: 60,
                    color: ColorManager.kPrimary,
                    text: "Update",
                    colorText: Colors.white,
                    press: () async {
                      final userDoc = FirebaseFirestore.instance
                          .collection('users')
                          .doc(sharedPreferences.getString('id'));
                      await userDoc.update({
                        'name': name,
                        'code': code,
                        'phone': number,
                      });
                      sharedPreferences.setString(
                        'name',
                        name,
                      );
                      sharedPreferences.setString(
                        'phone',
                        number,
                      );
                      if (sharedPreferences.getString('email') != email) {
                        sharedPreferences.setString(
                          'email',
                          email,
                        );
                        changeEmail(email);
                      }

                      sharedPreferences.setString(
                        'code',
                        code,
                      );
                      showToast('The data has been updated successfully.');
                      Get.off(() => MainScreen());
                    },
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Future<void> changeEmail(String newEmail) async {
    try {
      User? user = FirebaseAuth.instance.currentUser;

      // Check if the user is signed in
      if (user != null) {
        // Re-authenticate the user with their current email and password
        AuthCredential credential = EmailAuthProvider.credential(
          email: user.email!,
          password: sharedPreferences.getString('password') ??
              await getDeviceIdentifier(), // Replace with the user's current password
        );

        await user.reauthenticateWithCredential(credential);

        // Update the user's email address to the new value
        await user.updateEmail(newEmail);

        // // Send a verification email to the new email address (optional)
        // await user.sendEmailVerification();

        // // Sign the user out so they can sign in with the new email
        // await FirebaseAuth.instance.signOut();

        // You can now ask the user to sign in again with the new email address
        print('done');
      }
    } catch (e) {
      // Handle any exceptions that may occur during the process
      print('Error changing email: $e');
    }
  }

  Future getImage(ImageSource source) async {
    ImagePicker imagePicker = ImagePicker();
    XFile? pickedFile;
    pickedFile = await imagePicker.pickImage(
      source: source,
      imageQuality: 50, // reduce image quality to 50%
      maxWidth: 400, // reduce image width to 400 pixels
    );
    if (pickedFile != null) {
      File imageFile = File(pickedFile.path);
      uploadImageFiles(imageFile);
    }
  }

  Future<UploadTask> uploadImageFile(File image, String filename) async {
    Reference reference = await FirebaseStorage.instance.ref().child(filename);
    UploadTask uploadTask = reference.putFile(image);

    return uploadTask;
  }

  void uploadImageFiles(File imageFile) async {
    final userDoc = FirebaseFirestore.instance
        .collection('users')
        .doc(sharedPreferences.getString('id'));
    String fileName = DateTime.now().millisecondsSinceEpoch.toString();
    UploadTask uploadTask = await uploadImageFile(imageFile, fileName);
    try {
      TaskSnapshot snapshot = await uploadTask;
      String imageUrl = await snapshot.ref.getDownloadURL();
      await userDoc.update({
        'image': imageUrl,
      });
      sharedPreferences.setString('image', imageUrl);
      setState(() {
        isLoading = false;
      });
    } on FirebaseException catch (e) {
      setState(() {
        isLoading = false;
      });
      print(e.message.toString());
    }
  }

  void _handleAttachmentPressed() {
    showModalBottomSheet<void>(
      context: context,
      backgroundColor: ColorManager.background,
      builder: (BuildContext context) => Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(20),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            CustomListtile(
              onTap: () {
                Navigator.pop(context);
                getImage(ImageSource.camera);
              },
              titel: 'photo shoot',
              widget: Icon(Icons.camera),
              // color: ColorManager.background,
            ),
            CustomListtile(
              onTap: () {
                Navigator.pop(context);
                getImage(ImageSource.gallery);
              },
              titel: 'select a picture',
              widget: Icon(Icons.photo_album),
              // color: ColorManager.background,
            ),
            CustomListtile(
              onTap: () {
                Navigator.pop(context);
              },
              titel: 'Close',
              // color: ColorManager.background,
              widget: Icon(
                Icons.cancel,
                color: Colors.red,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
