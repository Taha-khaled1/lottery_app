import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';

Future<void> endLottery(String lotteryId) async {
  // Fetch all tickets for the current lottery
  QuerySnapshot ticketSnapshot = await FirebaseFirestore.instance
      .collection('tickets')
      .where('lottery_id', isEqualTo: lotteryId)
      .get();

  // Calculate prize value based on number of tickets
  double prizeValue = ticketSnapshot.docs.length * 0.1;

  // Select a random winner
  QueryDocumentSnapshot winningTicket =
      ticketSnapshot.docs[Random().nextInt(ticketSnapshot.docs.length)];

  // Update lottery document
  await FirebaseFirestore.instance
      .collection('lotteries')
      .doc(lotteryId)
      .update({
    'status': false,
    'prize': prizeValue,
    'winning_user_id': winningTicket['user_id'],
  });

  // Update winning ticket document
  await FirebaseFirestore.instance
      .collection('tickets')
      .doc(winningTicket.id)
      .update({
    'status': false,
    'prize': prizeValue,
  });

  // Update all other ticket documents for this lottery
  ticketSnapshot.docs.forEach((ticketDoc) async {
    if (ticketDoc.id != winningTicket.id) {
      await ticketDoc.reference.update({
        'status': false,
      });
    }
  });

  // Initialize a new lottery for the next round
  await initializeNewLottery();
}

Future<void> buyTicket(String userId, String lotteryId) async {
  // Update ticket document
  await FirebaseFirestore.instance.collection('tickets').add({
    'user_id': userId,
    'lottery_id': lotteryId,
    'status': true, // Ticket is active
    'create_at': DateTime.now(),
    // Other fields as needed
  });
}

// Assuming you have a "lotteries" collection in your Firestore
Future<void> initializeNewLottery() async {
  // Calculate end time for the new lottery
  DateTime endTime =
      DateTime.now().add(Duration(hours: 1)); // or admin-defined interval

  // Create a new lottery document
  await FirebaseFirestore.instance.collection('lotteries').add({
    'end_time': endTime,
    'status': true,
    'prize': 0, // Initial prize value
    // Other fields as needed
  });
}
