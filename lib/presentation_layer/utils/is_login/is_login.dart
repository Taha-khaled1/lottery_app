import 'package:free_lottery/main.dart';

bool isLogin() {
  print(
      "${sharedPreferences.getString('id')} : ${sharedPreferences.getString('name')}");
  if (sharedPreferences.getString('id') == null &&
      sharedPreferences.getString('name') == null) {
    return false;
  }
  return true;
}
