import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:free_lottery/data_layer/models/WithdrawalModel.dart';
import 'package:free_lottery/data_layer/models/user_model.dart';
import 'package:free_lottery/main.dart';
import 'package:free_lottery/presentation_layer/src/show_toast.dart';
import 'package:free_lottery/presentation_layer/utils/shard_function/printing_function_red.dart';
import 'package:get/get.dart';

class WalletController extends GetxController {
  double? money;
  String? email;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  UserModel? user;
  Future fetchUserData(String userId) async {
    DocumentSnapshot userSnapshot =
        await FirebaseFirestore.instance.collection('users').doc(userId).get();

    if (userSnapshot.exists) {
      Map<String, dynamic> userData =
          userSnapshot.data() as Map<String, dynamic>;
      user = UserModel.fromMap(userData);
      update();
      return userData;
    }
  }

  Future<bool> createwithdrawalsForUser(
      double money, String paypal_email) async {
    try {
      return await FirebaseFirestore.instance
          .runTransaction((transaction) async {
        final userRef = FirebaseFirestore.instance
            .collection('users')
            .doc(sharedPreferences.getString('id')!);
        DocumentSnapshot userSnapshot = await transaction.get(userRef);

        // Convert 'wallet' to a double
        double walletMoney =
            double.tryParse(userSnapshot.get('wallet').toString() ?? '0.0') ??
                0.0;

        if (walletMoney < money) {
          showToast("You don't have enough money in your wallet.");
          return false;
        }

        double walletMoneyNew = walletMoney - money;

        // Create a new ticket
        final ticketData = {
          'user_id': sharedPreferences.get('id'),
          'status': "pending", // completed failed pending
          'create_at': DateTime.now().toString(),
          'money': money,
          'paypal_email': paypal_email,
        };

        final ticketRef = FirebaseFirestore.instance
            .collection('withdrawals')
            .doc(); // Generate a new document ID
        transaction.set(ticketRef, ticketData);
        transaction.update(ticketRef, {'id': ticketRef.id});
        transaction.update(userRef, {'wallet': walletMoneyNew.toString()});

        return true;
      });
    } catch (e) {
      printRedColor(e.toString());
      return false;
    }
  }

  Future<List<Withdrawal>> fetchWithdrawals(String userId) async {
    List<Withdrawal> withdrawals = [];

    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('withdrawals')
        .where('user_id', isEqualTo: userId)
        .get();

    for (QueryDocumentSnapshot docSnapshot in querySnapshot.docs) {
      Withdrawal userWithdrawal = Withdrawal.fromMap(
          docSnapshot.data() as Map<String, dynamic>, docSnapshot.id);
      withdrawals.add(userWithdrawal);
    }

    return withdrawals;
  }
}
