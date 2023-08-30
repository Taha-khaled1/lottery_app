// import 'package:flutter/material.dart';
// import 'package:intl_phone_field/intl_phone_field.dart';
// import 'package:free_lottery/presentation_layer/resources/color_manager.dart';

// class CustomPhoneNumber extends StatelessWidget {
//   const CustomPhoneNumber({
//     super.key, required this.number,
//   });
//    String ?number;
//   @override
//   Widget build(BuildContext context) {
//     return IntlPhoneField(
//       onSaved: (newValue) {
//         number = newValue.toString();
//       },
//       decoration: InputDecoration(
//         enabledBorder: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(10),
//           borderSide: BorderSide.none,
//         ),
//         focusedBorder: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(10),
//           borderSide: BorderSide(
//             width: 1.2,
//             // style: BorderStyle.none,
//             color: ColorManager.kPrimary,
//           ), //<-- SEE HERE
//         ),

//         //  enabled: true,
//         filled: true,
//         fillColor: ColorManager.fillColor,
//         hintText: 'Phone Number',
//         hintStyle: TextStyle(
//           color: Color(0xFF9E9E9E),
//           fontSize: 14,
//           fontFamily: 'Urbanist',
//           fontWeight: FontWeight.w400,
//           height: 1.40,
//           letterSpacing: 0.20,
//         ),
//       ),
//       initialCountryCode: 'US',
//       onChanged: (phone) {
//         print(phone.completeNumber);
//       },
//     );
//   }
// }
