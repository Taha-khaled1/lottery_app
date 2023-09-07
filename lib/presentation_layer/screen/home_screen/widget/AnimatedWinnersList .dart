import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:free_lottery/data_layer/models/winner_model.dart';
import 'package:free_lottery/presentation_layer/screen/home_screen/home_controller/home_controller.dart';
import 'package:free_lottery/presentation_layer/src/get_packge.dart';
import 'package:free_lottery/presentation_layer/utils/shard_function/image_checker.dart';

class WinnerCard extends StatelessWidget {
  final String name;
  final String prize;
  final String imageUrl;

  WinnerCard({required this.name, required this.prize, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      padding: EdgeInsets.all(10),
      width: 160,
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.1),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.white.withOpacity(0.5), width: 1.5),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 5,
            blurRadius: 7,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ClipOval(
            child: CachedNetworkImage(
              imageUrl: imageNetworkCheck(imageUrl),
              width: 70,
              height: 70,
              fit: BoxFit.cover,
              placeholder: (context, url) => CircularProgressIndicator(),
              errorWidget: (context, url, error) => Image.network(
                'https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_1280.png',
              ),
            ),
          ),
          SizedBox(height: 10),
          Text(
            name,
            style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black54),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 5),
          Text(
            "\$$prize",
            style: TextStyle(
                fontSize: 20, fontWeight: FontWeight.bold, color: Colors.green),
          ),
        ],
      ),
    );
  }
}

class AnimatedWinnersList extends StatefulWidget {
  final HomeController homeController;

  const AnimatedWinnersList({super.key, required this.homeController});
  @override
  _AnimatedWinnersListState createState() => _AnimatedWinnersListState();
}

class _AnimatedWinnersListState extends State<AnimatedWinnersList> {
  late ScrollController _scrollController;
  late List<Map<String, String>> winners;

  @override
  void initState() {
    super.initState();

    // Sample data
    winners = [
      {
        "name": "John",
        "prize": "1000",
        "imageUrl": "assets/images/profile.jpg"
      },
      {
        "name": "Jane",
        "prize": "1200",
        "imageUrl": "assets/images/profile.jpg"
      },
      {"name": "Doe", "prize": "1100", "imageUrl": "assets/images/profile.jpg"},
      {
        "name": "Alice",
        "prize": "1050",
        "imageUrl": "assets/images/profile.jpg"
      },
      {"name": "Bob", "prize": "1150", "imageUrl": "assets/images/profile.jpg"},
    ];

    _scrollController = ScrollController();
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      _animateScroll();
    });
  }

  _animateScroll() async {
    while (true) {
      await Future.delayed(Duration(seconds: 2));
      if (_scrollController.hasClients) {
        if (_scrollController.offset >=
            _scrollController.position.maxScrollExtent) {
          _scrollController.animateTo(
            _scrollController.position.minScrollExtent,
            duration: Duration(milliseconds: 1500),
            curve: Curves.easeOut,
          );
        } else {
          _scrollController.animateTo(
            _scrollController.offset + 170,
            duration: Duration(seconds: 1),
            curve: Curves.easeOut,
          );
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    List<WinnerModel> latestWinners = widget.homeController.latestWinners;
    return Container(
      height: 162,
      child: latestWinners.isNotEmpty
          ? ListView.builder(
              scrollDirection: Axis.horizontal,
              controller: _scrollController,
              itemCount: latestWinners.length,
              itemBuilder: (context, index) {
                return WinnerCard(
                  name: latestWinners[index].name!,
                  prize: latestWinners[index].prize!.toString(),
                  imageUrl: imageNetworkCheck(latestWinners[index].image),
                );
              },
            )
          : SizedBox(),
    );
  }
}
