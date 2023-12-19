import 'package:flutter/material.dart';

class WinningTicketWidget extends StatefulWidget {
  final String name;

  final double prize;
  final String ticket_id;
  final String ticket_number;

  const WinningTicketWidget({
    Key? key,
    required this.name,
    required this.prize,
    required this.ticket_id,
    required this.ticket_number,
  }) : super(key: key);

  @override
  _WinningTicketWidgetState createState() => _WinningTicketWidgetState();
}

class _WinningTicketWidgetState extends State<WinningTicketWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 1),
    )..repeat(reverse: true);
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: Tween(begin: 1.0, end: 1.05).animate(_animationController),
      child: Container(
        margin: EdgeInsets.all(16.0),
        padding: EdgeInsets.all(20.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15.0),
          gradient: LinearGradient(
            colors: [Colors.purple.shade300, Colors.blue.shade500],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Winner's name #: ${widget.name}",
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              "Winning tickets #: ${widget.ticket_number}",
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              "Earned reward  \$${widget.prize.toStringAsFixed(2)}",
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
}
