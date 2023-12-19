import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:free_lottery/presentation_layer/utils/image_handelar/image_handelar.dart';
import 'package:get/get.dart';
import 'package:free_lottery/application_layer/utils/valid.dart';
import 'package:free_lottery/main.dart';
import 'package:free_lottery/presentation_layer/components/appbar.dart';
import 'package:free_lottery/presentation_layer/components/custom_butten.dart';
import 'package:free_lottery/presentation_layer/components/custom_text_field.dart';
import 'package:free_lottery/presentation_layer/components/nav_bar.dart';
import 'package:free_lottery/presentation_layer/resources/color_manager.dart';
import 'package:free_lottery/presentation_layer/resources/font_manager.dart';
import 'package:free_lottery/presentation_layer/resources/styles_manager.dart';
import 'package:free_lottery/presentation_layer/screen/auth/info_account_screen/widget/EditImage.dart';
import 'package:free_lottery/presentation_layer/src/show_toast.dart';
import 'package:free_lottery/presentation_layer/utils/responsive_design/ui_components/info_widget.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

class InfoAccount extends StatefulWidget {
  const InfoAccount({Key? key, required this.isgoogle}) : super(key: key);
  final bool isgoogle;
  @override
  State<InfoAccount> createState() => _InfoAccountState();
}

class _InfoAccountState extends State<InfoAccount> {
  final GlobalKey<FormState> formkeysigin = GlobalKey();
  bool isLoading = false;
  String? name = '';
  String? email = '';
  String? number = '';
  String? code = 'US';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appbar(),
      backgroundColor: ColorManager.background,
      body: InfoWidget(
        builder: (context, deviceInfo) {
          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 40),
                Text(
                  'Fill Your Profile',
                  style: MangeStyles().getBoldStyle(
                    color: ColorManager.black,
                    fontSize: FontSize.s30 + 2,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 20),
                Text(
                  'Don\'t worry, you can always change it later, or you can skip it for now.',
                  style: MangeStyles().getRegularStyle(
                    color: ColorManager.black,
                    fontSize: FontSize.s18,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 40),
                SizedBox(height: 30),
                Form(
                  key: formkeysigin,
                  child: Column(
                    children: [
                      GetBuilder<ImageMangerController>(
                        init: ImageMangerController(),
                        // id: 1,
                        builder: (controller) {
                          return GestureDetector(
                            onTap: () async {
                              await controller.handleAttachmentPressed();
                            },
                            child: EditImage(
                              image: sharedPreferences.getString('image') ==
                                          null ||
                                      sharedPreferences
                                          .getString('image')!
                                          .isEmpty ||
                                      sharedPreferences.getString('image') == ''
                                  ? 'https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_1280.png'
                                  : sharedPreferences.getString('image')!,
                            ),
                          );
                        },
                      ),
                      CustomTextfield(
                        valid: (p0) {
                          return validInput(p0.toString(), 3, 100, 'name');
                        },
                        onsaved: (p0) {
                          return name = p0.toString();
                        },
                        titel: 'Full Name',
                        width: deviceInfo.localWidth * 0.8,
                        height: 60,
                      ),
                      SizedBox(height: 15),
                      SizedBox(
                        width: deviceInfo.localWidth * 0.8,
                        child: IntlPhoneField(
                          onSaved: (newValue) {
                            number = newValue!.number.toString();
                          },
                          validator: (p0) {
                            return validInput(
                              p0!.number.toString(),
                              6,
                              100,
                              'number',
                            );
                          },
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
                            print(phone.completeNumber);
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CustomButton(
                      boxShadowValue: BoxShadow(),
                      width: deviceInfo.localWidth * 0.42,
                      rectangel: 18,
                      height: 60,
                      color: Color(0xffFFEEEF),
                      text: "Skip",
                      colorText: Colors.black,
                      press: () {
                        if (widget.isgoogle) {
                          print("hi");
                          sharedPreferences.setString(
                            'code',
                            code ?? 'US',
                          );
                          sharedPreferences.setString(
                            'phone',
                            number ?? '00000',
                          );
                          sharedPreferences.setString("lev", '2');
                          Get.offAll(() => MainScreen());
                        } else {
                          showToast(
                            "You must fill in the data for a better experience",
                          );
                        }
                      },
                    ),
                    CustomButton(
                      width: deviceInfo.localWidth * 0.42,
                      rectangel: 18,
                      height: 60,
                      color: ColorManager.kPrimaryButton,
                      text: "Start",
                      press: () async {
                        try {
                          final userDoc = FirebaseFirestore.instance
                              .collection('users')
                              .doc(sharedPreferences.getString('id'));

                          if (formkeysigin.currentState!.validate()) {
                            formkeysigin.currentState!.save();

                            await userDoc.update({
                              'name':
                                  name ?? sharedPreferences.getString('name'),
                              'userId': sharedPreferences.getString('id'),
                              'image': sharedPreferences.getString('image'),
                              'phone': number,
                              'code': code,
                            });

                            sharedPreferences.setString(
                              'name',
                              name ?? "",
                            );
                            sharedPreferences.setString(
                              'code',
                              code ?? '',
                            );
                            sharedPreferences.setString(
                              'phone',
                              number ?? '',
                            );
                            sharedPreferences.setString("lev", '2');
                            Get.offAll(() => MainScreen());
                          }
                        } catch (e) {
                          print(e);
                        }
                      },
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
