// import 'dart:async';
// import 'package:circular_countdown_timer/circular_countdown_timer.dart';
// import 'package:flutter/material.dart';
// import 'package:free_lottery/presentation_layer/screen/home_screen/home_controller/home_controller.dart';
// import 'package:get/get.dart';
// import 'package:free_lottery/presentation_layer/resources/color_manager.dart';
// import 'package:free_lottery/presentation_layer/resources/font_manager.dart';
// import 'package:free_lottery/presentation_layer/resources/styles_manager.dart';

// class CircularTimer extends StatefulWidget {
//   const CircularTimer({Key? key}) : super(key: key);

//   @override
//   State<CircularTimer> createState() => _CircularTimerState();
// }

// class _CircularTimerState extends State<CircularTimer> {
//   Timer? timer;
//   DateTime firstDateTime = DateTime.now();
//   @override
//   void dispose() {
//     timer?.cancel();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     HomeController homeController = Get.put(HomeController());
//     return Center(
//       child: CircularCountDownTimer(
//         // Countdown duration in Seconds.
//         duration: homeController.duration,

//         // Countdown initial elapsed Duration in Seconds.
//         initialDuration: 0,

//         // Controls (i.e Start, Pause, Resume, Restart) the Countdown Timer.
//         controller: homeController.controller,

//         // Width of the Countdown Widget.
//         width: MediaQuery.of(context).size.width / 2,

//         // Height of the Countdown Widget.
//         height: MediaQuery.of(context).size.height / 2,

//         // Ring Color for Countdown Widget.
//         ringColor: Colors.grey[300]!,

//         // Ring Gradient for Countdown Widget.
//         ringGradient: null,

//         // Filling Color for Countdown Widget.
//         fillColor: ColorManager.kPrimary,

//         // Filling Gradient for Countdown Widget.
//         fillGradient: null,

//         // Background Color for Countdown Widget.
//         backgroundColor: ColorManager.background,

//         // Background Gradient for Countdown Widget.
//         backgroundGradient: null,

//         // Border Thickness of the Countdown Ring.
//         strokeWidth: 20.0,

//         // Begin and end contours with a flat edge and no extension.
//         strokeCap: StrokeCap.square,

//         // Text Style for Countdown Text.
//         textStyle: MangeStyles().getBoldStyle(
//           color: ColorManager.black,
//           fontSize: FontSize.s40,
//         ),

//         // Format for the Countdown Text.
//         textFormat: CountdownTextFormat.MM_SS,

//         // Handles Countdown Timer (true for Reverse Countdown (max to 0), false for Forward Countdown (0 to max)).
//         isReverse: true,

//         // Handles Animation Direction (true for Reverse Animation, false for Forward Animation).
//         isReverseAnimation: false,

//         // Handles visibility of the Countdown Text.
//         isTimerTextShown: true,

//         // Handles the timer start.
//         autoStart: false,

//         // This Callback will execute when the Countdown Starts.
//         onStart: () {
//           // timer = Timer.periodic(Duration(minutes: 1), (_) {
//           // });

//           debugPrint('Countdown Started');
//         },

//         // This Callback will execute when the Countdown Ends.
//         onComplete: () async {
//           // Get.to(() => SuccssScreen());
//         },

//         // This Callback will execute when the Countdown Changes.
//         onChange: (String timeStamp) {
//           // Here, do whatever you want
//           print('object : $timeStamp');
//           debugPrint('Countdown Changed $timeStamp');
//         },

//         /* 
//             * Function to format the text.
//             * Allows you to format the current duration to any String.
//             * It also provides the default function in case you want to format specific moments
//               as in reverse when reaching '0' show 'GO', and for the rest of the instances follow 
//               the default behavior.
//           */
//         timeFormatterFunction: (defaultFormatterFunction, duration) {
//           if (duration.inSeconds == 0) {
//             // only format for '0'
//             return "Start";
//           } else {
//             // other durations by it's default format
//             return Function.apply(defaultFormatterFunction, [duration]);
//           }
//         },
//       ),
//     );
//   }
// }
