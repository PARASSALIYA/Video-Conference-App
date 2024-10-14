import 'package:flutter/material.dart';
import 'package:video_conference_app/users/screens/addgroup/addgroup_screen.dart';
import 'package:video_conference_app/users/screens/home/home_screen.dart';
import 'package:video_conference_app/users/screens/metting/metting_screen.dart';
import 'package:video_conference_app/users/screens/setting/setting_screen.dart';
import 'package:video_conference_app/users/screens/splash/splash_screen.dart';

class Routes {
  static Map<String, WidgetBuilder> routes = {
    '/': (context) => const SplashScreen(),
    '/home': (context) => const HomeScreen(),
    '/addgroup': (context) => const AddgroupScreen(),
    '/setting': (context) => const SettingScreen(),
    '/meeting': (context) => const MettingScreen(),
  };
}
