import 'package:flutter/material.dart';
import 'package:free_lottery/presentation_layer/components/appbar.dart';
import 'package:free_lottery/presentation_layer/resources/color_manager.dart';
import 'package:free_lottery/presentation_layer/screen/winners_screen/winners_controller.dart';
import 'package:free_lottery/presentation_layer/test.dart';
import 'package:free_lottery/presentation_layer/utils/responsive_design/ui_components/info_widget.dart';
import 'package:free_lottery/presentation_layer/utils/shard_function/image_checker.dart';
import 'package:get/get.dart';

class WinnerCard extends StatelessWidget {
  final String name;
  final String imageUrl;
  final String ticket;
  final int rank;

  WinnerCard({
    required this.name,
    required this.imageUrl,
    required this.ticket,
    required this.rank,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // TestScreen();
        Get.to(() => TestScreen());
      },
      child: Card(
        elevation: 5,
        margin: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        child: ListTile(
          contentPadding: EdgeInsets.all(15),
          leading: CircleAvatar(
            radius: 30,
            backgroundImage: NetworkImage(imageNetworkCheck(imageUrl)),
          ),
          title: Text(name, style: TextStyle(fontWeight: FontWeight.bold)),
          subtitle: Text('wallet: $ticket'),
          trailing: CircleAvatar(
            backgroundColor: ColorManager.kPrimary,
            child: Text(
              '#$rank',
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ),
    );
  }
}

class WinnersScreen extends StatelessWidget {
  const WinnersScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.background,
      appBar: appbar(title: "Winners", isBack: false),
      body: InfoWidget(
        builder: (context, deviceInfo) {
          return GetBuilder<WinnersController>(
            init: WinnersController(),
            builder: (controller) {
              return ListView.builder(
                itemCount: controller.users.length,
                itemBuilder: (BuildContext context, int index) {
                  return WinnerCard(
                    name: controller.users[index].name,
                    imageUrl: controller.users[index].image,
                    ticket: controller.users[index].wallet.toString(),
                    rank: index + 1,
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
