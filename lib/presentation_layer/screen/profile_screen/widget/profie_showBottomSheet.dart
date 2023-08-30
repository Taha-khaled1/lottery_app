import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:free_lottery/main.dart';
import 'package:free_lottery/presentation_layer/components/custom_butten.dart';
import 'package:free_lottery/presentation_layer/resources/color_manager.dart';
import 'package:free_lottery/presentation_layer/resources/font_manager.dart';
import 'package:free_lottery/presentation_layer/resources/styles_manager.dart';
import 'package:free_lottery/presentation_layer/screen/auth/LoginScreen/login_screen.dart';
import 'package:free_lottery/presentation_layer/utils/responsive_design/ui_components/info_widget.dart';

customLogoutShowBottomSheet(BuildContext context) {
  showModalBottomSheet(
    backgroundColor: ColorManager.background,
    context: context,
    shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
      topLeft: Radius.circular(25),
      topRight: Radius.circular(25),
    )),
    builder: (BuildContext context) {
      return Container(
        height: 250,
        padding: EdgeInsets.all(16.0),
        child: InfoWidget(
          builder: (context, deviceInfo) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Align(
                  alignment: Alignment.center,
                  child: Text(
                    'Logout',
                    style: MangeStyles().getBoldStyle(
                      color: ColorManager.kPrimary,
                      fontSize: FontSize.s18,
                    ),
                    textAlign: TextAlign.left,
                  ),
                ),
                SizedBox(height: 10),
                Align(
                  alignment: Alignment.center,
                  child: Text(
                    'Are you sure you want to log out?',
                    style: MangeStyles().getRegularStyle(
                      color: ColorManager.black,
                      fontSize: FontSize.s18,
                    ),
                    textAlign: TextAlign.left,
                  ),
                ),
                SizedBox(height: 15),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CustomButton(
                      boxShadowValue: BoxShadow(),
                      width: deviceInfo.localWidth * 0.42,
                      rectangel: 25,
                      haigh: 60,
                      color: Color(0xFFFFEEEF),
                      text: "Cancel",
                      colorText: Colors.black,
                      press: () {
                        Get.back();
                      },
                    ),
                    CustomButton(
                      width: deviceInfo.localWidth * 0.42,
                      rectangel: 25,
                      haigh: 60,
                      color: ColorManager.kPrimaryButton,
                      text: "Yes, Logout",
                      press: () async {
                        // Get.to(() => TimelineScreen());
                        await FirebaseAuth.instance.signOut();
                        await sharedPreferences.setString("lev", '1');
                        await sharedPreferences.remove('id');
                        await sharedPreferences.remove('image');
                        Get.offAll(() => LoginScreen());

                        customRatingShowBottomSheet(context);
                      },
                    ),
                  ],
                ),
              ],
            );
          },
        ),
      );
    },
  );
}

customRatingShowBottomSheet(BuildContext context) {
  showModalBottomSheet(
    backgroundColor: ColorManager.background,
    context: context,
    shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
      topLeft: Radius.circular(25),
      topRight: Radius.circular(25),
    )),
    builder: (BuildContext context) {
      return Container(
        height: 250,
        padding: EdgeInsets.all(16.0),
        child: InfoWidget(
          builder: (context, deviceInfo) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Align(
                  alignment: Alignment.center,
                  child: Text(
                    'Rate Now',
                    style: MangeStyles().getBoldStyle(
                      color: ColorManager.kPrimary,
                      fontSize: FontSize.s25,
                    ),
                    textAlign: TextAlign.left,
                  ),
                ),
                SizedBox(height: 10),
                RatingBar.builder(
                  initialRating: 3,
                  minRating: 1,
                  direction: Axis.horizontal,
                  allowHalfRating: true,
                  itemCount: 5,
                  itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                  itemBuilder: (context, _) => Icon(
                    Icons.star,
                    color: Colors.amber,
                  ),
                  onRatingUpdate: (rating) {
                    print(rating);
                  },
                ),
                SizedBox(height: 15),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CustomButton(
                      boxShadowValue: BoxShadow(),
                      width: deviceInfo.localWidth * 0.42,
                      rectangel: 25,
                      haigh: 60,
                      color: Color(0xFFFFEEEF),
                      text: "Later",
                      colorText: Colors.black,
                      press: () {
                        Get.back();
                      },
                    ),
                    CustomButton(
                      width: deviceInfo.localWidth * 0.42,
                      rectangel: 25,
                      haigh: 60,
                      color: ColorManager.kPrimaryButton,
                      text: "Submit",
                      press: () async {
                        //go to app store
                        // StoreRedirect.redirect(
                        //   androidAppId:
                        //       'shri.complete.fitness.gymtrainingapp',
                        //   iOSAppId: 'com.example.rating',
                        // );
                      },
                    ),
                  ],
                ),
              ],
            );
          },
        ),
      );
    },
  );
}




// class TimelineScreen extends StatefulWidget {
//   @override
//   _TimelineScreenState createState() => _TimelineScreenState();
// }

// class _TimelineScreenState extends State<TimelineScreen> {
//   List<Event> events = [
//     // ... your events
//   ];

//   List<TaskModel> tasks = [
//     // ... your tasks
//   ];

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text("Timeline Demo")),
//       body: ListView.custom(
//         childrenDelegate: SliverChildBuilderDelegate(
//           (BuildContext context, int index) {
//             if (index == DateTime.now().hour) {
//               return Column(
//                 children: [
//                   Container(
//                     height: DateTime.now().minute * 1.0,
//                     color: index.isEven ? Colors.grey[200] : Colors.white,
//                   ),
//                   Container(
//                     height: 2,
//                     color: Colors.red,
//                   ),
//                   Container(
//                     height: (60 - DateTime.now().minute) * 1.0,
//                     color: index.isEven ? Colors.grey[200] : Colors.white,
//                     child: Align(
//                       alignment: Alignment.centerLeft,
//                       child: Padding(
//                         padding: const EdgeInsets.only(left: 16.0),
//                         child: Text(
//                           "$index:00",
//                           style: TextStyle(
//                             fontSize: 16.0,
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                       ),
//                     ),
//                   ),
//                   for (var task in tasks)
//                     if (task.time.hour == index)
//                       TaskInfoDataCard(
//                         taskModel: task,
//                         // ... other required parameters
//                       ),
//                 ],
//               );
//             } else {
//               return Column(
//                 children: [
//                   Container(
//                     height: 60.0,
//                     color: index.isEven ? Colors.grey[200] : Colors.white,
//                     child: Align(
//                       alignment: Alignment.centerLeft,
//                       child: Padding(
//                         padding: const EdgeInsets.only(left: 16.0),
//                         child: Text(
//                           "$index:00",
//                           style: TextStyle(
//                             fontSize: 16.0,
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                       ),
//                     ),
//                   ),
//                   for (var task in tasks)
//                    if (parseTime(task.time!).hour == index)
//                       Builder(builder: (context) {
//                             int ind = taskmodelList.indexWhere(
//                                       (element) =>
//                                           element.title ==
//                                           task.['catogery']);
                                          
                                          
//                                           return TaskInfoDataCard(
//                                       taskModel: TaskModel(
//                                         color: taskmodelList[ind].color,
//                                         image: taskmodelList[ind].image,
//                                         title: taskmodelList[ind].title,
//                                         subtitle: taskmodelList[ind].subtitle,
//                                         id: task.timestamp,
//                                         data: task.['datatime'],
//                                         time: task.['timeOfDay'],
//                                         isdone: task.['done'],
//                                         taskName: task.['title'],
//                                       ),
//                                       taslength: totalTasks,index: index,
//                                     );

//                       },
                    
//                       );
//                 ],
//               );
//             }
//           },
//           childCount: 24,
//         ),
//       ),
//     );
//   }
// }


// class Event {
//   final DateTime startTime;
//   final Duration duration;
//   final String title;

//   Event({required this.startTime, required this.duration, required this.title});
// }
//  TimeOfDay parseTime(String timeStr) {
//     final format = DateFormat.jm(); // for format like "12:20 PM"
//     DateTime dt = format.parse(timeStr);
//     return TimeOfDay.fromDateTime(dt);
//   }