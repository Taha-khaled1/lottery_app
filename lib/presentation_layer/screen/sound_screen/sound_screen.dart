import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:free_lottery/main.dart';
import 'package:free_lottery/presentation_layer/components/appbar.dart';
import 'package:free_lottery/presentation_layer/resources/color_manager.dart';
import 'package:free_lottery/presentation_layer/screen/sound_screen/widget/SoundCard.dart';

int selectedOption = 1;
List<String> aduis = [
  'audio/a.mp3',
  'audio/s.mp3',
  'audio/d.mp3',
  'audio/f.mp3',
  'audio/g.mp3',
  'audio/h.mp3'
];
// bool isStop = true;

class SoundScreen extends StatefulWidget {
  const SoundScreen({Key? key}) : super(key: key);

  @override
  State<SoundScreen> createState() => _SoundScreenState();
}

class _SoundScreenState extends State<SoundScreen> {
  AudioPlayer audioPlayer = AudioPlayer();
  @override
  void dispose() {
    audioPlayer.stop();
    audioPlayer.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.background,
      appBar: appbar(title: 'Reminder Ringtone'),
      body: Container(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Choose an option:',
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16.0),
            SoundCard(
              valueSelected: 1,
              onChanged: (value) async {
                setState(() {
                  selectedOption = value!;
                  // isStop = false;
                });
                playRecord(aduio: aduis[0]);
                sharedPreferences.setString('tun', 'a');
              },
              onTap: () {
                setState(() {
                  audioPlayer.stop();
                  // isStop = true;
                });
              },
              title: 'tune (1)',
            ),
            SoundCard(
              valueSelected: 2,
              onTap: () {
                setState(() {
                  audioPlayer.stop();
                  // isStop = true;
                });
              },
              onChanged: (value) {
                setState(() {
                  selectedOption = value!;
                  // isStop = false;
                });
                playRecord(aduio: aduis[1]);
                sharedPreferences.setString('tun', 's');
              },
              title: 'tune (2)',
            ),
            SoundCard(
              valueSelected: 3,
              onTap: () {
                setState(() {
                  audioPlayer.stop();
                  // isStop = true;
                });
              },
              onChanged: (value) {
                setState(() {
                  selectedOption = value!;
                  // isStop = false;
                });
                playRecord(aduio: aduis[2]);
                sharedPreferences.setString('tun', 's');
              },
              title: 'tune (3)',
            ),
            SoundCard(
              valueSelected: 4,
              onTap: () {
                setState(() {
                  audioPlayer.stop();
                  // isStop = true;
                });
              },
              onChanged: (value) {
                setState(() {
                  selectedOption = value!;
                  // isStop = false;
                });
                playRecord(aduio: aduis[3]);
                sharedPreferences.setString('tun', 'd');
              },
              title: 'tune (4)',
            ),
            SoundCard(
              valueSelected: 5,
              onTap: () {
                setState(() {
                  audioPlayer.stop();
                  // isStop = true;
                });
              },
              onChanged: (value) {
                setState(() {
                  selectedOption = value!;
                  // isStop = false;
                });
                playRecord(aduio: aduis[4]);
                sharedPreferences.setString('tun', 'f');
              },
              title: 'tune (5)',
            ),
            SoundCard(
              valueSelected: 6,
              onTap: () {
                setState(() {
                  audioPlayer.stop();
                  // isStop = true;
                });
              },
              onChanged: (value) {
                sharedPreferences.setString('tun', 'h');
                setState(() {
                  selectedOption = value!;
                  // isStop = false;
                });
                playRecord(aduio: aduis[5]);
              },
              title: 'tune (5)',
            ),
          ],
        ),
      ),
    );
  }

  void playRecord({required String aduio}) async {
    try {
      audioPlayer.setReleaseMode(ReleaseMode.loop);
      await audioPlayer.play(AssetSource(aduio));
    } catch (e) {
      print(e.toString());
    }
  }
}

//   await audioController.stopRecord(uploadAudio);  audioPlayer.onPlayerComplete.listen((a) {
//       audioController.start.value = DateTime.now();
//       audioController.startRecord();
//       audioController.isRecording.value = true;
//     });
