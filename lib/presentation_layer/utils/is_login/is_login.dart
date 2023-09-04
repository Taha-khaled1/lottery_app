import 'package:free_lottery/main.dart';

bool isLogin() {
  if (sharedPreferences.getString('id') == null ||
      sharedPreferences.getString('name') == null) {
    return false;
  }
  return true;
}
