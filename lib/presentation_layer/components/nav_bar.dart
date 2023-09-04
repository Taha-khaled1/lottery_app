// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:free_lottery/presentation_layer/screen/home_screen/home_screen.dart';
import 'package:free_lottery/presentation_layer/screen/profile_screen/profile_screen.dart';
import 'package:free_lottery/presentation_layer/screen/ticket_screen/ticket_screen.dart';
import 'package:free_lottery/presentation_layer/screen/winners_screen/winners_screen.dart';
import 'package:get/get.dart';
import 'package:free_lottery/presentation_layer/resources/color_manager.dart';
import 'package:free_lottery/presentation_layer/resources/font_manager.dart';
import 'package:free_lottery/presentation_layer/resources/styles_manager.dart';

List<String> svgIcon = [
  'assets/icons/Home.svg',
  'assets/icons/win.svg',
  'assets/icons/ticket.svg',
  'assets/icons/user.svg',
];
List<String> titles = [
  'Home',
  'Winners',
  'Tickets',
  'Profile',
];

class MainScreen extends StatefulWidget {
  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  List<Color> iconColors = [ColorManager.kPrimary, Colors.grey];
  final List<Widget> _screens = [
    HomeScreen(),
    WinnersScreen(),
    TicketsScreen(),
    ProfileScreen(),
  ];

  final tabController = Get.put(TabAppController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(),
      body: Obx(
        () => _screens[tabController.currentIndex.value],
      ),
      bottomNavigationBar: GetBuilder<TabAppController>(
        init: TabAppController(),
        initState: (_) {},
        builder: (_) {
          return BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            enableFeedback: false,
            elevation: 10,
            showUnselectedLabels: true,
            unselectedItemColor: iconColors.last,
            unselectedLabelStyle: MangeStyles().getRegularStyle(
              color: Colors.grey,
              fontSize: FontSize.s14,
            ),
            selectedItemColor: iconColors.first,
            selectedLabelStyle: TextStyle(color: Colors.red),
            currentIndex: tabController.currentIndex.value,
            onTap: (index) {
              tabController.changeTabIndex(index);
            },
            items: [
              for (int i = 0; i < 4; i++)
                BottomNavigationBarItem(
                  icon: Container(
                    child: titles[i] != ''
                        ? SvgPicture.asset(svgIcon[i],
                            height: 30,
                            color: iconColors[
                                i == tabController.currentIndex.value ? 0 : 1])
                        : CircleAvatar(
                            radius: 30,
                            backgroundColor: ColorManager.kPrimary,
                            child: SvgPicture.asset(
                              svgIcon[i],
                              color: Colors.white,
                            ),
                          ),
                  ),
                  label: titles[i],
                ),
            ],
          );
        },
      ),
    );
  }
}

class TabAppController extends GetxController {
  var currentIndex = 0.obs;

  void changeTabIndex(int index) {
    currentIndex.value = index;
    update();
  }
}

class Screen2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Screen 2'),
      ),
      body: Center(
        child: Text('Screen 2'),
      ),
    );
  }
}

class Screen3 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Screen 3'),
      ),
      body: Center(
        child: Text('Screen 3'),
      ),
    );
  }
}

class Screen4 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Screen 4'),
      ),
      body: Center(
        child: Text('Screen 4'),
      ),
    );
  }
}

class Screen5 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Screen 5'),
      ),
      body: Center(
        child: Text('Screen 5'),
      ),
    );
  }
}

class Screen6 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Screen 6'),
      ),
      body: Center(
        child: Text('Screen 6'),
      ),
    );
  }
}

class Screen7 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Screen 7'),
      ),
      body: Center(
        child: Text('Screen 7'),
      ),
    );
  }
}
