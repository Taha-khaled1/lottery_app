import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:free_lottery/presentation_layer/notification_service/notification_service.dart';
import 'package:free_lottery/presentation_layer/utils/shard_function/printing_function_red.dart';

Future<void> endLottery(String lotteryId) async {
  // Fetch all tickets for the current lottery
  QuerySnapshot ticketSnapshot = await FirebaseFirestore.instance
      .collection('tickets')
      .where('lottery_id', isEqualTo: lotteryId)
      .get();
  await FirebaseFirestore.instance.collection('lottery').doc(lotteryId).update({
    "time_end": "",
  });
  // .where('lottery_id', isEqualTo: lotteryId)
  // .get();
  // Calculate prize value based on number of tickets
  double prizeValue = ticketSnapshot.docs.length * 0.1;

  // Select a random winner
  QueryDocumentSnapshot winningTicket =
      ticketSnapshot.docs[Random().nextInt(ticketSnapshot.docs.length)];

  // Update user's wallet for the winning user
  DocumentReference winningUserRef = FirebaseFirestore.instance
      .collection('users')
      .doc(winningTicket['user_id']);
  printRedColor(winningTicket['user_id']);

  await FirebaseFirestore.instance.runTransaction((transaction) async {
    DocumentSnapshot winningUserSnapshot =
        await transaction.get(winningUserRef);

    if (winningUserSnapshot.exists) {
      printRedColor("document exist");
      double currentWalletValue = double.parse(winningUserSnapshot['wallet']);
      // Check if 'wallet' field exists, otherwise set it to 0
      if (!(winningUserSnapshot.data() as Map<String, dynamic>)
          .containsKey('wallet')) {
        currentWalletValue = 0.0;
      }

      double updatedWalletValue = currentWalletValue + prizeValue;
      transaction.update(
          winningUserRef, {'wallet': updatedWalletValue.toStringAsFixed(1)});
      await addWinners(
        name: winningUserSnapshot['name'],
        image: winningUserSnapshot['image'],
        prize: prizeValue + 0,
      );
    } else {
      printRedColor("Winning user document does not exist.");
    }
  });

  // Update lottery document
  await FirebaseFirestore.instance.collection('lottery').doc(lotteryId).update({
    'status': false,
    'prize': prizeValue,
    'user_id': winningTicket['user_id'],
  });

  // Update winning ticket document
  await FirebaseFirestore.instance
      .collection('tickets')
      .doc(winningTicket.id)
      .update({
    'status': false,
    'prize': prizeValue.toStringAsFixed(1),
    'type': "Won",
  });

  // Update all other ticket documents for this lottery
  ticketSnapshot.docs.forEach((ticketDoc) async {
    if (ticketDoc.id != winningTicket.id) {
      await ticketDoc.reference.update({
        'status': false,
        'type': "Lost",
      });
    }
  });

  final nextLotteryEndTime = DateTime.now().add(Duration(seconds: 2));
  await NotificationService().alarmCallback(
    des: "notificationList[randomIndex].descriptio",
    scheduleDate: nextLotteryEndTime,
    title: "notificationList[randomIndex].title",
  );

  // Initialize a new lottery for the next round
  await initializeNewLottery();
}

Future<void> initializeNewLottery() async {
  final batch = FirebaseFirestore.instance.batch();

  // Calculate end time for the new lottery
  DateTime endTime =
      DateTime.now().add(Duration(hours: 1)); // or admin-defined interval

  // Create a new lottery document
  final newLotteryRef = FirebaseFirestore.instance
      .collection('lottery')
      .doc(); // Generate a new document ID

  batch.set(newLotteryRef, {
    'time_end': endTime.toString(),
    'create_at': DateTime.now().toString(),
    'status': true,
    'prize': 0,
    // Other fields as needed
  });

  batch.update(newLotteryRef, {'lottery_id': newLotteryRef.id});

  await batch.commit();
}

Future<void> addWinners({
  required String name,
  required String image,
  required double prize,
}) async {
  await FirebaseFirestore.instance.collection('winners').add({
    'name': name,
    'image': image,
    'prize': prize.toStringAsFixed(1),
    'create_at': DateTime.now().toString(),
  });
}
// --------------------------------------------------------------------------------------



// HTTP trigger to create a document with name "Taha"
// exports.createTahaDocument = functions.https.onRequest(async (req, res) => {
// // ==========================================================================
//   const usersCollection = db.collection("man");
//   const newUserData = {name: "Taha"};
//   try {
//     const newDocRef = await usersCollection.add(newUserData);
//     logger.info(`Document created with ID: ${newDocRef.id}`);
//     res.status(200).send(`Document created with ID: ${newDocRef.id}`);
//   } catch (error) {
//     logger.error("Error adding document: ", error);
//     res.status(500).send("Error adding document");
//   }
//   // ==========================================================================
// });




// eslint-disable-next-line max-len
// exports.scheduleFunctionRecursively = functions.https.onRequest(async (req, res) => {
//   try {
//     // Read next execution time from Firestore
//     const schedulerDoc = await db.collection("Scheduler").doc("schedulerDoc").
//         get();
//     const nextExecutionTime = schedulerDoc.data().nextExecutionTime.toMillis();

//     // Calculate the new next execution time (e.g., add 1 hour)
//     const newNextExecutionTime =
//     nextExecutionTime + 60 * 60 * 1000; // Add 1 hour

//     // Update the Firestore document with the new next execution time
//     await db.collection("Scheduler").doc("schedulerDoc").update({
//       nextExecutionTime:
//       admin.firestore.Timestamp.fromMillis(newNextExecutionTime),
//     });


//     const newNumber = Math.floor(Math.random() * 1000);
//     await db.collection("Documents").add({
//       number: newNumber,
//       timestamp: admin.firestore.Timestamp.now(),
//     });


//     const client = new CloudSchedulerClient();
//     const projectId = process.env.GCLOUD_PROJECT;
//     const location = "us-central1";
//     const parent = client.locationPath(projectId, location);
//     const url = "https://us-central1-free-lottery-2a3de.cloudfunctions.net/scheduleFunctionRecursively";

//     const job = {
//       httpTarget: {
//         uri: url,
//         httpMethod: "GET",
//       },
//       schedule: `at ${new Date(newNextExecutionTime).toISOString()}`,
//       timeZone: "UTC",
//       retryConfig: {
//         retryCount: 0,
//       },
//     };

//     const [response] = await client.createJob({parent, job});

//     console.log(`Job created: ${response.name}`);
//     res.status(200).send("Function scheduled successfully");
//   } catch (error) {
//     console.error("Error scheduling function:", error);
//     res.status(500).send("Error scheduling function");
//   }
// });
