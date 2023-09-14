import 'package:flutter/services.dart';
import 'package:free_lottery/application_layer/service/localizetion/translate.dart';
import 'package:free_lottery/presentation_layer/components/nav_bar.dart';
import 'package:free_lottery/presentation_layer/resources/routes_pages.dart';
import 'package:free_lottery/presentation_layer/resources/theme_manager.dart';
import 'package:free_lottery/presentation_layer/screen/internet_screen/internet_screen.dart';
import 'package:free_lottery/presentation_layer/src/get_packge.dart';
import 'package:free_lottery/presentation_layer/src/style_packge.dart';
import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:free_lottery/presentation_layer/utils/shard_function/printing_function_red.dart';

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  ConnectivityResult connectionStatus = ConnectivityResult.none;
  final Connectivity connectivity = Connectivity();
  late StreamSubscription<ConnectivityResult> connectivitySubscription;
  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initConnectivity() async {
    late ConnectivityResult result;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      result = await connectivity.checkConnectivity();
    } on PlatformException catch (e) {
      print('Couldn\'t check connectivity status $e');
      return;
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    // if (!mounted) {
    //   return Future.value(null);
    // }

    return _updateConnectionStatus(result);
  }

  Future<void> _updateConnectionStatus(ConnectivityResult result) async {
    connectionStatus = result;
    setState(() {
      printRedColor("$connectionStatus : $result");
      if (connectionStatus == ConnectivityResult.none) {
        Get.offAll(() => NoInternetScreen());
      } else {
        Get.off(() => MainScreen());
      }
    });
  }

  @override
  void initState() {
    super.initState();
    initConnectivity();

    connectivitySubscription =
        connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
  }

  @override
  void dispose() {
    connectivitySubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      translations: MyTranslation(),
      locale: const Locale('en'),
      theme: getApplicationTheme(),
      // home: TestScreen(),
      getPages: getPage,
    );
  }
}
