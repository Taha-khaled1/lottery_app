import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:free_lottery/data_layer/models/lottery_model.dart';
import 'package:free_lottery/data_layer/models/user_model.dart';
import 'package:free_lottery/data_layer/models/winner_model.dart';
import 'package:free_lottery/main.dart';
import 'package:free_lottery/presentation_layer/screen/award_screen/award_screen.dart';
import 'package:free_lottery/presentation_layer/utils/is_login/is_login.dart';
import 'package:free_lottery/presentation_layer/utils/shard_function/printing_function_red.dart';
import 'package:get/get.dart';
import 'package:stop_watch_timer/stop_watch_timer.dart';

class HomeController extends GetxController {
  bool isloading = true;
  final CountDownController controller = CountDownController();
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  List<WinnerModel> latestWinners = [];
  Rx<LotteryModel?> currentLottery = Rx<LotteryModel?>(null);
  int? duration;
  UserModel? user;
  StopWatchTimer? stopWatchTimer = null;

  final scrollController = ScrollController();
  Future<void> fetchCurrentLotteryData() async {
    final querySnapshot = await FirebaseFirestore.instance
        .collection('lottery')
        .where('status', isEqualTo: true)
        .limit(1)
        .get();

    if (querySnapshot.docs.isNotEmpty) {
      final data = querySnapshot.docs.first.data();
      final LotteryModel lotteryModel = LotteryModel.fromJson(data);
      currentLottery.value = lotteryModel;
      duration = calculateTimeDifference(lotteryModel);
    } else {
      currentLottery.value = null;
    }
    update();
  }

  Future<void> fetchUserData(String userId) async {
    DocumentSnapshot userSnapshot =
        await FirebaseFirestore.instance.collection('users').doc(userId).get();

    if (userSnapshot.exists) {
      Map<String, dynamic> userData =
          userSnapshot.data() as Map<String, dynamic>;
      user = UserModel.fromMap(userData);
      update();
    }
  }

  int calculateTimeDifference(LotteryModel lottery) {
    final currentTime = DateTime.now();
    final timeDifference = lottery.timeEnd.difference(currentTime);

    // final hours = timeDifference.inHours;
    // final minutes = timeDifference.inMinutes % 60;
    // final seconds = timeDifference.inSeconds % 60;

    return timeDifference.inSeconds.toInt() + 20;
  }

  Future<WinnerModel?> getLatestWinner() async {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('winners')
        .orderBy('create_at', descending: true)
        .limit(1)
        .get();

    if (querySnapshot.docs.isNotEmpty) {
      return WinnerModel.fromMap(
          querySnapshot.docs.first.data() as Map<String, dynamic>);
    } else {
      return null; // or handle this case appropriately
    }
  }

  Future<List<WinnerModel>> getLatestWinners({int limit = 5}) async {
    QuerySnapshot winnersSnapshot = await FirebaseFirestore.instance
        .collection('winners')
        .orderBy('create_at', descending: true)
        .limit(limit)
        .get();

    for (QueryDocumentSnapshot winnerDoc in winnersSnapshot.docs) {
      latestWinners
          .add(WinnerModel.fromMap(winnerDoc.data() as Map<String, dynamic>));
    }

    return latestWinners;
  }

  Future<bool> createTicketForUser() async {
    return await FirebaseFirestore.instance.runTransaction((transaction) async {
      // Fetch the current lottery and update its totalticket value
      final lotteryRef = FirebaseFirestore.instance
          .collection('lottery')
          .doc(currentLottery.value!.lotteryId);

      DocumentSnapshot lotterySnapshot = await transaction.get(lotteryRef);
      if (!lotterySnapshot.exists) {
        throw Exception("Document does not exist!");
      }

      int newTotalTicket = lotterySnapshot.get('totalticket') + 1;

      // Create a new ticket
      final ticketData = {
        'user_id': sharedPreferences.get('id'),
        'lottery_id': currentLottery.value!.lotteryId,
        'status': true, // assuming this is for active tickets
        'create_at': DateTime.now().toString(),
        'type': "Upcoming",
        'ticket_number': newTotalTicket,
        'end_at': currentLottery.value!.timeEnd
            .toString() // assuming you want to set end time as lottery end time
      };

      final ticketRef = FirebaseFirestore.instance
          .collection('tickets')
          .doc(); // Generate a new document ID
      transaction.set(ticketRef, ticketData);
      transaction.update(ticketRef, {'ticket_id': ticketRef.id});
      transaction.update(lotteryRef, {'totalticket': newTotalTicket});

      return true;
    });
  }

  Stream<DocumentSnapshot<Map<String, dynamic>>> getCurrentLotteryStream() {
    final lotteryRef = FirebaseFirestore.instance
        .collection('lottery')
        .doc(currentLottery.value!.lotteryId);
    print(lotteryRef.snapshots());
    return lotteryRef.snapshots();
  }

  @override
  void onInit() async {
    await fetchCurrentLotteryData();
    await getLatestWinners();
    if (isLogin()) {
      await fetchUserData(sharedPreferences.getString('id')!);
    }

    stopWatchTimer = await StopWatchTimer(
      mode: StopWatchMode.countDown,
      presetMillisecond:
          StopWatchTimer.getMilliSecFromSecond(duration ?? 400 * 60),
      // onChange: (value) => print('onChange $value'),
      // onChangeRawSecond: (value) => print('onChangeRawSecond $value'),
      onChangeRawMinute: (value) => print('onChangeRawMinute $value'),
      onStopped: () {
        print('onStopped');
      },
      onEnded: () async {
        WinnerModel? winnerModel = await getLatestWinner();

        if (winnerModel != null) {
          printRedColor(winnerModel.prize);
          Get.off(
            () => AwardScreen(
              winnerModel: winnerModel,
            ),
          );
        } else {
          print('No winners found.');
        }

        print('onEnded');
      },
    );

    // stopWatchTimer.rawTime.listen((value) =>
    //     print('rawTime $value ${StopWatchTimer.getDisplayTime(value)}'));
    // stopWatchTimer.secondTime.listen((value) => print('secondTime $value'));
    await stopWatchTimer!.minuteTime
        .listen((value) => print('minuteTime $value'));
    await stopWatchTimer!.fetchStopped
        .listen((value) => print('stopped from stream'));
    await stopWatchTimer!.fetchEnded
        .listen((value) => print('ended from stream'));
    stopWatchTimer!.onStartTimer();
    isloading = false;
    update();
    super.onInit();
  }

  @override
  void onClose() {
    stopWatchTimer?.dispose();
    scrollController.dispose();
    super.onClose();
  }
}
    // Ensure a valid lottery is active
    // final querySnapshot = await FirebaseFirestore.instance
    //     .collection('lottery')
    //     .where('status', isEqualTo: true)
    //     .limit(1)
    //     .get();

    // if (querySnapshot.docs.isEmpty) {
    //   print("No active lottery.");
    //   return false;
    // }

    // final currentLottery = querySnapshot.docs.first;
    // final String currentLotteryId = currentLottery.id;

    // Create a ticket document in Firestore