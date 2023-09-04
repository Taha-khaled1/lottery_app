import 'package:flutter/material.dart';

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
          CircleAvatar(
            radius: 35,
            backgroundImage: AssetImage(imageUrl),
            backgroundColor: Colors.transparent,
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
          _scrollController.jumpTo(_scrollController.position.minScrollExtent);
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
    return Container(
      height: 162,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        controller: _scrollController,
        itemCount: winners.length,
        itemBuilder: (context, index) {
          return WinnerCard(
            name: winners[index]["name"]!,
            prize: winners[index]["prize"]!,
            imageUrl: winners[index]["imageUrl"]!,
          );
        },
      ),
    );
  }
}
