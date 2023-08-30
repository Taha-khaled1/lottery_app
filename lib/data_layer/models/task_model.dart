import 'package:free_lottery/presentation_layer/src/style_packge.dart';

class TaskModel {
  final String image, title, subtitle;
  final String? data, time;
  final bool? ishome, isdone;
  final Color? color;
  final String? id, taskName;
  TaskModel({
    this.taskName,
    this.id,
    this.isdone,
    required this.color,
    required this.image,
    this.ishome = false,
    required this.title,
    required this.subtitle,
    this.data,
    this.time,
  });
}

List<int> taskColors = [
  0xFFFF5726,
  0xFFFFC02D,
  0xFF00A9F1,
  0xFF8BC255,
  0xFFCDDC4C,
  0xFFF54336,
  0xFF607D8A,
];
List<TaskModel> taskmodelList = [
  TaskModel(
    image: 'assets/images/Reading.png',
    title: 'Reading Books',
    subtitle: '25 minutes',
    ishome: false,
    color: Color(0xFFFF5726),
  ),
  TaskModel(
    color: Color(0xFFFFC02D),
    image: 'assets/images/music.png',
    title: 'Editing Audio',
    subtitle: '25 minutes',
    ishome: false,
  ),
  TaskModel(
    color: Color(0xFF00A9F1),
    image: 'assets/images/programing.png',
    title: 'Learn Programming',
    subtitle: '25 minutes',
    ishome: false,
  ),
  TaskModel(
    color: Color(0xFF8BC255),
    image: 'assets/images/dumbile.png',
    title: 'Dumbbell Exercise',
    subtitle: '25 minutes',
    ishome: false,
  ),
  TaskModel(
    color: Color(0xFFCDDC4C),
    image: 'assets/images/laptop.png',
    title: 'Tech Exploration',
    subtitle: '25 minutes',
    ishome: false,
  ),
  TaskModel(
    color: Color(0xFFF54336),
    image: 'assets/images/medtion.png',
    title: 'Meditation',
    subtitle: '25 minutes',
    ishome: false,
  ),
  TaskModel(
    color: Color(0xFF607D8A),
    image: 'assets/images/pap.png',
    title: 'Fixing Smartphone',
    subtitle: '25 minutes',
    ishome: false,
  ),
];
