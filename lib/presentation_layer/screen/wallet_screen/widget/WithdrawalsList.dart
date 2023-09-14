import 'package:flutter/material.dart';
import 'package:free_lottery/data_layer/models/WithdrawalModel.dart';
import 'package:free_lottery/presentation_layer/screen/wallet_screen/wallet_controller/wallet_controller.dart';
import 'package:get/get.dart';

import 'TransactionWidget.dart';

class WithdrawalsList extends StatefulWidget {
  final String userId;

  WithdrawalsList({required this.userId});

  @override
  _WithdrawalsListState createState() => _WithdrawalsListState();
}

class _WithdrawalsListState extends State<WithdrawalsList> {
  late Future<List<Withdrawal>> futureWithdrawals;
  final WalletController _controller = Get.put(WalletController());
  @override
  void initState() {
    super.initState();
    futureWithdrawals = _controller.fetchWithdrawals(widget.userId);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Withdrawal>>(
      future: futureWithdrawals,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          final withdrawals = snapshot.data;

          return ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: withdrawals!.length,
            itemBuilder: (context, index) {
              return TransactionWidget(transaction: withdrawals[index]);
            },
          );
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
