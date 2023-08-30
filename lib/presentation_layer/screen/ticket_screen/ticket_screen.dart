import 'package:flutter/material.dart';
import 'package:free_lottery/presentation_layer/components/appbar.dart';
import 'package:free_lottery/presentation_layer/resources/color_manager.dart';
import 'package:free_lottery/presentation_layer/utils/responsive_design/ui_components/info_widget.dart';
import 'package:intl/intl.dart';

class CreativeTicketCard extends StatelessWidget {
  final String ticketNumber;
  final DateTime purchaseDate;
  final DateTime lotteryDate;
  final String status;

  CreativeTicketCard({
    required this.ticketNumber,
    required this.purchaseDate,
    required this.lotteryDate,
    required this.status,
  });

  Color _getStatusColor() {
    switch (status) {
      case "Won":
        return Colors.green;
      case "Lost":
        return Colors.red;
      default:
        return Colors.blue;
    }
  }

  @override
  Widget build(BuildContext context) {
    String _formatDate(DateTime date) {
      return DateFormat('y-M-d : H:m').format(date);
    }

    return Container(
      margin: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            ColorManager.kPrimary,
            ColorManager.kPrimary.withOpacity(0.5),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 5,
            blurRadius: 7,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Ticket: $ticketNumber',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: Colors.white,
                  ),
                ),
                Icon(
                  Icons.confirmation_number,
                  color: Colors.white,
                  size: 30,
                ),
              ],
            ),
            Divider(color: Colors.white54),
            SizedBox(height: 8),
            Text(
              'Purchased: ${_formatDate(purchaseDate)}',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
            SizedBox(height: 8),
            Text(
              'Lottery Date: ${_formatDate(lotteryDate)}',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
            SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Status: $status',
                  style: TextStyle(
                    color: _getStatusColor(),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Icon(
                    status == "Won"
                        ? Icons.star
                        : (status == "Lost"
                            ? Icons.close
                            : Icons.hourglass_empty),
                    color: _getStatusColor(),
                    size: 24),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class TicketsScreen extends StatelessWidget {
  const TicketsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.background,
      appBar: appbar(title: "Your Tickets", isBack: false),
      body: InfoWidget(
        builder: (context, deviceInfo) {
          return ListView.builder(
            itemCount: 10, // Replace with the actual number of tickets
            itemBuilder: (BuildContext context, int index) {
              // Sample data for demonstration. Replace with actual data.
              return CreativeTicketCard(
                ticketNumber: "ABC12345",
                purchaseDate: DateTime.now().subtract(Duration(days: index)),
                lotteryDate: DateTime.now().add(Duration(hours: 24 - index)),
                status: index % 2 == 0 ? "Upcoming" : "Lost",
              );
            },
          );
        },
      ),
    );
  }
}
