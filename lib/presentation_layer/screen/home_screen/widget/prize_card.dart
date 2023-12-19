// ignore_for_file: unused_field

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:free_lottery/presentation_layer/screen/home_screen/home_controller/home_controller.dart';
import 'package:free_lottery/presentation_layer/src/get_packge.dart';
import 'package:free_lottery/presentation_layer/utils/shard_function/printing_function_red.dart';

class PrizeWidget extends StatefulWidget {
  final int ticketCount;

  PrizeWidget({required this.ticketCount});

  @override
  _PrizeWidgetState createState() => _PrizeWidgetState();
}

class _PrizeWidgetState extends State<PrizeWidget>
    with SingleTickerProviderStateMixin {
  AnimationController? _controller;
  Animation<double>? _animation;
  HomeController homeController = Get.find();
  // double get prize => widget.ticketCount * 0.1;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    )..repeat(reverse: true);

    _animation = CurvedAnimation(
      parent: _controller!,
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: 165,
        width: double.infinity,
        margin: EdgeInsets.symmetric(horizontal: 20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15.0),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.3),
              spreadRadius: 5,
              blurRadius: 7,
              offset: Offset(0, 3),
            ),
          ],
          // image: DecorationImage(
          //   image: AssetImage('assets/images/backrr.png'),
          //   fit: BoxFit.cover,
          // ),
        ),
        child: Stack(
          alignment: AlignmentDirectional.center,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              // mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "Current Prize",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
                  stream: homeController.getCurrentLotteryStream(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return CircularProgressIndicator(); // Loading indicator
                    }
                    printRedColor("..... ${snapshot.data!.data()}");
                    final lotteryData = snapshot.data!.data()!;
                    // Access your lottery fields like lotteryData['totalticket'], lotteryData['prize'], etc.
                    return TweenAnimationBuilder<double>(
                      tween: Tween<double>(
                          begin: 0, end: lotteryData['totalticket'] * 0.01),
                      duration: Duration(seconds: 4),
                      builder:
                          (BuildContext context, double value, Widget? child) {
                        return Text(
                          "\$${value.toStringAsFixed(2)}",
                          style: TextStyle(
                            fontSize: 40,
                            fontWeight: FontWeight.w900,
                            color: Colors.green,
                          ),
                        );
                      },
                    );
                  },
                ),
                AnimatedTextKit(
                  animatedTexts: [
                    TyperAnimatedText(
                      'get a ticket to increase the prize!',
                      textStyle: TextStyle(
                        fontSize: 16.0,
                        fontStyle: FontStyle.italic,
                      ),
                      speed: Duration(milliseconds: 100),
                    ),
                  ],
                  totalRepeatCount: 8,
                  pause: Duration(milliseconds: 1000),
                  displayFullTextOnTap: true,
                  stopPauseOnTap: true,
                ),
                AnimatedTextKit(
                  animatedTexts: [
                    TyperAnimatedText(
                      'Every ticket increases the prize by 0.01!',
                      textStyle: TextStyle(
                        fontSize: 16.0,
                        fontStyle: FontStyle.italic,
                      ),
                      speed: Duration(milliseconds: 100),
                    ),
                  ],
                  totalRepeatCount: 8,
                  pause: Duration(milliseconds: 1000),
                  displayFullTextOnTap: true,
                  stopPauseOnTap: true,
                ),
              ],
            ),
            // Lottie.asset("assets/json/mo.json", fit: BoxFit.cover, width: 500),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller!.dispose();
    super.dispose();
  }
}
