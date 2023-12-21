import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:free_lottery/data_layer/models/user_model.dart';
import 'package:get/get.dart';

class WinnersController extends GetxController {
  bool isLoad = false;
  final List<UserModel> users = [];

  Future<void> fetchUsers() async {
    try {
      final querySnapshot = await FirebaseFirestore.instance
          .collection('users')
          .orderBy('wallet',
              descending: true) // Order by wallet in descending order
          .limit(10) // Limit the results to 10 users
          .get();

      // Parse user data and add to the users list
      querySnapshot.docs.forEach((doc) {
        final userData = doc.data();
        final user = UserModel.fromMap(userData);
        users.add(user);
      });

      // Sort users by wallet balance in descending order
      users.sort((a, b) => b.wallet.compareTo(a.wallet));
      isLoad = true;
      update(); // Update the UI
    } catch (error) {
      print('Error fetching users: $error');
    }
  }

  @override
  void onInit() {
    fetchUsers();
    super.onInit();
  }
}
