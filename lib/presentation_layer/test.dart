import 'package:flutter/material.dart';

class TestScreen extends StatefulWidget {
  @override
  _TestScreenState createState() => _TestScreenState();
}

class _TestScreenState extends State<TestScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey.shade200, // Sample background color
      appBar: AppBar(
        title: Text("Lottery App"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            UpperSection(),
            // Previous Prize
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.price_change,
                    color: Colors.yellow, size: 30), // Sample icon
                SizedBox(width: 10),
                Text("Last Prize: \$1000",
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold)), // Sample prize amount
              ],
            ),
            SizedBox(height: 20),

            // Current Prize
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.price_change,
                    color: Colors.green, size: 30), // Sample icon
                SizedBox(width: 10),
                Text("Upcoming Prize: \$5000",
                    style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.green)), // Sample prize amount
              ],
            ),
            SizedBox(height: 40),

            // Buttons
            ElevatedButton.icon(
              onPressed: () {
                // Logic for getting a free ticket
              },
              icon: Icon(Icons.gif, color: Colors.white),
              label: Text("Get a Free Ticket"),
              style: ElevatedButton.styleFrom(
                  primary: Colors.blue,
                  padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15)),
            ),
            SizedBox(height: 20),
            ElevatedButton.icon(
              onPressed: () {
                // Logic for buying a ticket
              },
              icon: Icon(Icons.shopping_cart, color: Colors.white),
              label: Text("Buy a Ticket"),
              style: ElevatedButton.styleFrom(
                  primary: Colors.green,
                  padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15)),
            ),
          ],
        ),
      ),
    );
  }
}

class UpperSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.blue.shade200, Colors.blue.shade600],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: Column(
        children: [
          Text("Next Draw In",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold)),
          SizedBox(height: 10),
          Text("12:34:56",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 40,
                  fontWeight: FontWeight.bold)), // Sample countdown
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.g_mobiledata_outlined,
                  color: Colors.amber, size: 30), // Sample icon
              SizedBox(width: 10),
              Text("Upcoming Prize: \$5000",
                  style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.amber)), // Sample prize amount
            ],
          ),
        ],
      ),
    );
  }
}
