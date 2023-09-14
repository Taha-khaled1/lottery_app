import 'package:flutter/material.dart';
import 'package:free_lottery/data_layer/models/ticke_model.dart';
import 'package:free_lottery/main.dart';
import 'package:free_lottery/presentation_layer/components/appbar.dart';
import 'package:free_lottery/presentation_layer/resources/color_manager.dart';
import 'package:free_lottery/presentation_layer/resources/font_manager.dart';
import 'package:free_lottery/presentation_layer/resources/styles_manager.dart';
import 'package:free_lottery/presentation_layer/screen/before_login_screen/before_login_screen.dart';
import 'package:free_lottery/presentation_layer/screen/ticket_screen/ticket_controller.dart';
import 'package:free_lottery/presentation_layer/utils/is_login/is_login.dart';
import 'package:free_lottery/presentation_layer/utils/responsive_design/ui_components/info_widget.dart';
import 'package:get/get.dart';
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
    final TicketController controller = Get.put(TicketController());

    return isLogin()
        ? DefaultTabController(
            animationDuration: Duration(milliseconds: 1000),
            length: 3, // Number of tabs
            child: Scaffold(
              backgroundColor: ColorManager.background,
              appBar: appbar(title: "Your Tickets", isBack: false),
              body: Column(
                children: [
                  TabBar(
                    indicatorColor: Colors.black,
                    tabs: [
                      Tab(
                        child: Text(
                          'Winners',
                          style: MangeStyles().getBoldStyle(
                            color: ColorManager.kPrimary,
                            fontSize: FontSize.s18,
                          ),
                        ),
                      ),
                      Tab(
                        child: Text(
                          'Losers',
                          style: MangeStyles().getBoldStyle(
                            color: ColorManager.kPrimary,
                            fontSize: FontSize.s18,
                          ),
                        ),
                      ),
                      Tab(
                        child: Text(
                          'Pending',
                          style: MangeStyles().getBoldStyle(
                            color: ColorManager.kPrimary,
                            fontSize: FontSize.s18,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Expanded(
                    child: TabBarView(
                      children: [
                        buildTicketListView(
                            context, controller.fetchWinningTickets),
                        buildTicketListView(
                            context, controller.fetchLosingTickets),
                        buildTicketListView(
                            context, controller.fetchPendingTickets),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          )
        : BeforeLoginScreen();
  }
}

Widget buildTicketListView(
  BuildContext context,
  Future<List<UserTicketModel>> Function(String) fetchFunction,
) {
  return FutureBuilder<List<UserTicketModel>>(
    future: fetchFunction(sharedPreferences.getString("id")!),
    builder: (context, snapshot) {
      if (snapshot.connectionState == ConnectionState.waiting) {
        return Center(
            child: CircularProgressIndicator(
          color: ColorManager.kPrimary,
        )); // Show loading indicator
      } else if (snapshot.hasError) {
        return Text('Error: ${snapshot.error}');
      } else if (snapshot.hasData) {
        List<UserTicketModel> userTickets = snapshot.data!;
        return ListView.builder(
          itemCount: userTickets.length,
          itemBuilder: (BuildContext context, int index) {
            UserTicketModel ticket = userTickets[index];
            return CreativeTicketCard(
              ticketNumber: ticket.ticketNumber.toString(),
              purchaseDate: DateTime.parse(ticket.createAt),
              lotteryDate: DateTime.parse(ticket.endAt),
              status: ticket.type,
            );
          },
        );
      } else {
        return Text('No tickets available.');
      }
    },
  );
}
