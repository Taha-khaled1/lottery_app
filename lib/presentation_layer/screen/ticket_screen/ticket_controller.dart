import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:free_lottery/data_layer/models/ticke_model.dart';
import 'package:get/get.dart';

class TicketController extends GetxController {
  List<UserTicketModel> userTickets = [];

  Future<List<UserTicketModel>> fetchUserTickets(String userId) async {
    userTickets.clear();
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('tickets')
        .where('user_id', isEqualTo: userId)
        .get();

    for (QueryDocumentSnapshot docSnapshot in querySnapshot.docs) {
      Map<String, dynamic> ticketData =
          docSnapshot.data() as Map<String, dynamic>;
      UserTicketModel userTicket = UserTicketModel.fromMap(ticketData);
      userTickets.add(userTicket);
    }

    return userTickets;
  }

  Future<List<UserTicketModel>> fetchWinningTickets(String userId) async {
    List<UserTicketModel> winningTickets = [];
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('tickets')
        .where('user_id', isEqualTo: userId)
        .where('type',
            isEqualTo: "Won") // Assuming 'false' status means winning
        .get();

    for (QueryDocumentSnapshot docSnapshot in querySnapshot.docs) {
      Map<String, dynamic> ticketData =
          docSnapshot.data() as Map<String, dynamic>;
      UserTicketModel userTicket = UserTicketModel.fromMap(ticketData);
      winningTickets.add(userTicket);
    }

    return winningTickets;
  }

  Future<List<UserTicketModel>> fetchLosingTickets(String userId) async {
    List<UserTicketModel> losingTickets = [];
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('tickets')
        .where('user_id', isEqualTo: userId)
        .where('type', isEqualTo: "Lost") // Assuming 'true' status means losing
        .get();

    for (QueryDocumentSnapshot docSnapshot in querySnapshot.docs) {
      Map<String, dynamic> ticketData =
          docSnapshot.data() as Map<String, dynamic>;
      UserTicketModel userTicket = UserTicketModel.fromMap(ticketData);
      losingTickets.add(userTicket);
    }

    return losingTickets;
  }

  Future<List<UserTicketModel>> fetchPendingTickets(String userId) async {
    List<UserTicketModel> pendingTickets = [];
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('tickets')
        .where('user_id', isEqualTo: userId)
        .where('type',
            isEqualTo: "Upcoming") // Assuming 'true' status means pending
        .get();

    for (QueryDocumentSnapshot docSnapshot in querySnapshot.docs) {
      Map<String, dynamic> ticketData =
          docSnapshot.data() as Map<String, dynamic>;
      UserTicketModel userTicket = UserTicketModel.fromMap(ticketData);
      pendingTickets.add(userTicket);
    }

    return pendingTickets;
  }

  @override
  void onInit() {
    super.onInit();
  }
}
