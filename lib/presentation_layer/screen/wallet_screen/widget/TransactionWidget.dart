import 'package:flutter/material.dart';
import 'package:free_lottery/data_layer/models/WithdrawalModel.dart';
import 'package:free_lottery/presentation_layer/components/custom_butten.dart';
import 'package:free_lottery/presentation_layer/resources/color_manager.dart';
import 'package:free_lottery/presentation_layer/screen/wallet_screen/wallet_controller/wallet_controller.dart';
import 'package:free_lottery/presentation_layer/utils/responsive_design/ui_components/info_widget.dart';

class TransactionWidget extends StatelessWidget {
  final Withdrawal transaction;
  final bool islonley;
  final WalletController controller;
  TransactionWidget({
    required this.transaction,
    required this.islonley,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    Color? getStatusColor(String status) {
      switch (status) {
        case 'completed':
          return Color(0xFF4A90E2);
        case 'failed':
          return Color(0xFFE57373);
        case 'pending':
        default:
          return Color(0xFFFFC107);
      }
    }

    IconData getStatusIcon(String status) {
      switch (status) {
        case 'completed':
          return Icons.check_circle_outline;
        case 'failed':
          return Icons.error_outline;
        case 'pending':
        default:
          return Icons.hourglass_empty;
      }
    }

    return Container(
      margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            getStatusColor(transaction.status)!,
            getStatusColor(transaction.status)!.withOpacity(0.7)
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(15.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 8,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          ListTile(
            contentPadding: EdgeInsets.all(16.0),
            leading: Icon(
              getStatusIcon(transaction.status),
              color: Colors.white,
              size: 40,
            ),
            title: Text(
              'ID: ${transaction.userId}',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 8),
                Text('Prize: \$${transaction.money}',
                    style: TextStyle(color: Colors.white)),
                Text('PayPal Email: ${transaction.paypalEmail}',
                    style: TextStyle(color: Colors.white)),
                Text('Created at: ${transaction.createdAt}',
                    style: TextStyle(color: Colors.white)),
              ],
            ),
          ),
          if (!islonley)
            InfoWidget(
              builder: (context, deviceInfo) {
                return Row(
                  children: [
                    CustomButton(
                      width: deviceInfo.localWidth * 0.45,
                      height: 45,
                      color: ColorManager.error,
                      text: "refused",
                      press: () {
                        controller.updateWithdrawalStatus(
                          transaction.id.toString(),
                          WithdrawalStatus.failed,
                        ); // to mark as failed
                      },
                      rectangel: 10,
                    ),
                    CustomButton(
                      width: deviceInfo.localWidth * 0.45,
                      height: 45,
                      color: ColorManager.kPrimary,
                      text: "paid",
                      press: () {
                        controller.updateWithdrawalStatus(
                          transaction.id.toString(),
                          WithdrawalStatus.paid,
                        ); // to mark as paid},
                      },
                      rectangel: 10,
                    ),
                  ],
                );
              },
            )
        ],
      ),
    );
  }
}
