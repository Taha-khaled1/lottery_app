import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:get/get_navigation/src/routes/route_middleware.dart';
import 'package:free_lottery/main.dart';
import 'package:free_lottery/presentation_layer/resources/routes_manager.dart';

class Midelware extends GetMiddleware {
  @override
  // ignore: overridden_fields
  final int? priority = 1;

  @override
  RouteSettings? redirect(String? route) {
    print('----------------- > ${sharedPreferences.getString('lev')}');
    print('ooooooooooooooooooooooo');
    if (sharedPreferences.getString('lev') == '0') {
      return const RouteSettings(name: Routes.on);
    } else if (sharedPreferences.getString('lev') == '1') {
      return const RouteSettings(name: '/login');
    } else if (sharedPreferences.getString('lev') == '2') {
      return const RouteSettings(name: '/home');
    } else {
      return const RouteSettings(name: '/');
    }
    // return null;
  }
}

class MyMidelware extends GetMiddleware {
  @override
  // ignore: overridden_fields
  final int? priority = 1;

  @override
  RouteSettings? redirect(String? route) {
    print('----------------- > ${sharedPreferences.getString('lev')}');
    print('ooooooooooooooooooooooo');
    if (sharedPreferences.getString('lev').toString() == '0') {
      return RouteSettings(name: '/');
    } else if (sharedPreferences.getString('lev') == '1') {
      return RouteSettings(name: 'login');
    } else if (sharedPreferences.getString('lev') == '2') {
      return RouteSettings(name: 'home');
    }
    return null;
  }
}
