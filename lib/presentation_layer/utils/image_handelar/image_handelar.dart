import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:free_lottery/main.dart';
import 'package:free_lottery/presentation_layer/components/custom_listtile.dart';
import 'package:free_lottery/presentation_layer/resources/color_manager.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class ImageMangerController extends GetxController {
  Future getImage(ImageSource source) async {
    ImagePicker imagePicker = ImagePicker();
    XFile? pickedFile;
    pickedFile = await imagePicker.pickImage(
      source: source,
      imageQuality: 50, // reduce image quality to 50%
      maxWidth: 400, // reduce image width to 400 pixels
    );
    // update();
    if (pickedFile != null) {
      File imageFile = File(pickedFile.path);
      uploadImageFiles(imageFile);
      // update();
    }
  }

  Future<UploadTask> uploadImageFile(File image, String filename) async {
    Reference reference = await FirebaseStorage.instance.ref().child(filename);
    UploadTask uploadTask = reference.putFile(image);
    // update();
    return uploadTask;
  }

  void uploadImageFiles(
    File imageFile,
  ) async {
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
      update();
      // setState(() {
      //   isLoading = false;
      // });
    } on FirebaseException catch (e) {
      // setState(() {
      //   isLoading = false;
      // });
      update();
      print(e.message.toString());
    }
  }

  Future<void> handleAttachmentPressed() async {
    Get.bottomSheet(
      Container(
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
              onTap: () async {
                Get.back();
                await getImage(ImageSource.camera);
                // update();
              },
              titel: 'photo shoot',
              widget: Icon(Icons.camera),
              // color: ColorManager.background,
            ),
            CustomListtile(
              onTap: () async {
                Get.back();
                await getImage(ImageSource.gallery);
                // update();
              },
              titel: 'select a picture',
              widget: Icon(Icons.photo_album),
              // color: ColorManager.background,
            ),
            CustomListtile(
              onTap: () {
                Get.back();
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
      backgroundColor: ColorManager.background,
    );
  }
}
