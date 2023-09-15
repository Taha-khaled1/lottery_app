import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:free_lottery/presentation_layer/components/appbar.dart';
import 'package:free_lottery/presentation_layer/components/custom_butten.dart';
import 'package:free_lottery/presentation_layer/components/custom_text_field.dart';
import 'package:free_lottery/presentation_layer/screen/auth/social_login/widget/custom_dvider.dart';
import 'package:free_lottery/presentation_layer/src/show_toast.dart';
import 'package:free_lottery/presentation_layer/utils/responsive_design/ui_components/info_widget.dart';
import 'package:get/get.dart';

import '../../../main.dart';
import '../../src/style_packge.dart';
import 'login_dashboard.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  Map<String, dynamic> updatedData = {};
  final _formKey = GlobalKey<FormState>();
  bool isload = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appbar(title: "Dashboard"),
      body: InfoWidget(
        builder: (context, deviceInfo) {
          return Center(
            child: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  // mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextHeader(
                      text: "public",
                      fontSize: 26,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextHeader(text: "password"),
                    CustomTextfield(
                      inialvalue: sharedPreferences.getString("password"),
                      valid: (value) {},
                      onsaved: (value) {
                        updatedData['password'] = value;
                      },
                      titel: "Enter password",
                      width: deviceInfo.localWidth * 0.85,
                      height: 60,
                    ),
                    TextHeader(text: "percentage"),
                    CustomTextfield(
                      inialvalue: sharedPreferences.getString("percentage"),
                      valid: (value) {},
                      onsaved: (value) {
                        updatedData['percentage'] = value;
                      },
                      titel: "Enter percentage",
                      width: deviceInfo.localWidth * 0.85,
                      height: 60,
                    ),
                    TextHeader(text: "Number of ads"),
                    CustomTextfield(
                      inialvalue: sharedPreferences.getString("num_ads"),
                      valid: (value) {},
                      onsaved: (value) {
                        updatedData['num_ads'] = value;
                      },
                      titel: "Enter Number of ads",
                      width: deviceInfo.localWidth * 0.85,
                      height: 60,
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    TextHeader(
                      text: "Admobe",
                      fontSize: 26,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextHeader(text: "android id"),
                    CustomTextfield(
                      inialvalue: sharedPreferences.getString("android_id"),
                      valid: (value) {},
                      onsaved: (value) {
                        updatedData['android_id'] = value;
                      },
                      titel: "Enter android id",
                      width: deviceInfo.localWidth * 0.85,
                      height: 60,
                    ),
                    TextHeader(text: "ios id"),
                    CustomTextfield(
                      inialvalue: sharedPreferences.getString("ios_id"),
                      valid: (value) {},
                      onsaved: (value) {
                        updatedData['ios_id'] = value;
                      },
                      titel: "Enter ios id",
                      width: deviceInfo.localWidth * 0.85,
                      height: 60,
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    TextHeader(
                      text: "Paypal",
                      fontSize: 26,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextHeader(text: "public key"),
                    CustomTextfield(
                      inialvalue: sharedPreferences.getString("public_key"),
                      valid: (value) {},
                      onsaved: (value) {
                        updatedData['public_key'] = value;
                      },
                      titel: "Enter public key",
                      width: deviceInfo.localWidth * 0.85,
                      height: 60,
                    ),
                    TextHeader(text: "secret key"),
                    CustomTextfield(
                      inialvalue: sharedPreferences.getString("secret_key"),
                      valid: (value) {},
                      onsaved: (value) {
                        updatedData['secret_key'] = value;
                      },
                      titel: "Enter secret key",
                      width: deviceInfo.localWidth * 0.85,
                      height: 60,
                    ),
                    TextHeader(text: "client id"),
                    CustomTextfield(
                      inialvalue: sharedPreferences.getString("client_id"),
                      valid: (value) {},
                      onsaved: (value) {
                        updatedData['client_id'] = value;
                      },
                      titel: "Enter client id",
                      width: deviceInfo.localWidth * 0.85,
                      height: 60,
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    isload == false
                        ? CustomButton(
                            width: deviceInfo.localWidth * 0.85,
                            height: 60,
                            color: ColorManager.kPrimary,
                            text: "Next",
                            press: () {
                              saveData();
                              print(sharedPreferences.getString("percentage"));
                            },
                          )
                        : Center(
                            child: CircularProgressIndicator(
                              color: ColorManager.kPrimary,
                            ),
                          ),
                    SizedBox(
                      height: 35,
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  void saveData() async {
    isload = true;
    if (mounted) {
      setState(() {});
    }
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      final firestore = FirebaseFirestore.instance;
      try {
        await firestore
            .collection('setting')
            .doc('setting')
            .set(updatedData, SetOptions(merge: true));
        updatedData.forEach((key, value) {
          if (value is String) {
            sharedPreferences.setString(key, value);
          } else if (value is int) {
            sharedPreferences.setInt(key, value);
          }
          // Add more types as needed
        });
        print("Data updated successfully!");
      } catch (e) {
        print('Error updating data: $e');
      }
    }
    isload = false;
    if (mounted) {
      setState(() {});
    }
  }
}

class TextHeader extends StatelessWidget {
  const TextHeader({
    super.key,
    required this.text,
    this.fontSize,
  });
  final String text;
  final double? fontSize;
  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        color: Color(0xFF212121),
        fontSize: fontSize ?? 18,
        fontFamily: 'Urbanist',
        fontWeight: FontWeight.w700,
        height: 1.20,
      ),
    );
  }
}
