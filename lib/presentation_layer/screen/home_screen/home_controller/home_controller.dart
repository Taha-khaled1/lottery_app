import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  final int duration = (460 * 60);
  final CountDownController controller = CountDownController();

  bool isplay = false;
  bool isFirstplay = true;
  void changePlay(bool value) {
    isplay = value;
    update();
  }

  void changeFirstPlay() {
    isFirstplay = false;
    update();
  }

  void startPomo() {
    controller.start();
    update();
  }

  void resumePomo() {
    controller.resume();
    update();
  }

  void pausePomo() {
    controller.pause();
    update();
  }

  void restartPomo() {
    controller.restart();
    update();
  }

  void playButton() {
    if (isFirstplay == true) {
      startPomo();
      changePlay(true);
      changeFirstPlay();
    } else {
      if (isplay == false) {
        resumePomo();
        changePlay(true);
      } else {
        pausePomo();
        changePlay(false);
      }
    }
  }

  @override
  void onInit() {
    startPomo();
    super.onInit();
  }
}
