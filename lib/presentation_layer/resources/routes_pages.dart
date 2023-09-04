import 'package:free_lottery/presentation_layer/components/nav_bar.dart';
import 'package:free_lottery/presentation_layer/resources/routes_manager.dart';
import 'package:get/get.dart';
// import 'package:free_lottery/presentation_layer/screen/auth/LoginScreen/login_screen.dart';
// import 'package:free_lottery/presentation_layer/screen/auth/social_login/social_login.dart';
// import 'package:free_lottery/presentation_layer/screen/onboarding_screen/onboarding_screen.dart';

List<GetPage<dynamic>>? getPage = [
  GetPage(
    name: Routes.startpage,
    page: () => MainScreen(),
    // middlewares: [
    //   Midelware(),
    // ],
  ),
  // GetPage(
  //   name: Routes.on,
  //   page: () => OnboardingScreen(),
  // ),
  // GetPage(
  //   name: Routes.loginRoute,
  //   page: () => const SocialScreen(),
  // ),
  // GetPage(
  //   name: Routes.homeRoute,
  //   page: () => MainScreen(),
  // ),
];
