import 'package:flutter/material.dart';
import 'package:free_lottery/presentation_layer/components/appbar.dart';
import 'package:free_lottery/presentation_layer/resources/color_manager.dart';
import 'package:free_lottery/presentation_layer/utils/responsive_design/ui_components/info_widget.dart';

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
    return Card(
      elevation: 5,
      margin: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: ListTile(
        contentPadding: EdgeInsets.all(15),
        leading: CircleAvatar(
          radius: 30,
          backgroundImage: AssetImage(imageUrl),
        ),
        title: Text(name, style: TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text('Ticket: $ticket'),
        trailing: CircleAvatar(
          backgroundColor: ColorManager.kPrimary,
          child: Text(
            '#$rank',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
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
          return ListView.builder(
            itemCount:
                10, // You can change this to the actual number of winners
            itemBuilder: (BuildContext context, int index) {
              // Sample data for demonstration. Replace with actual data.
              return WinnerCard(
                name: "John Doe",
                imageUrl: "assets/images/profile.jpg",
                ticket: "123456",
                rank: index + 1,
              );
            },
          );
        },
      ),
    );
  }
}
