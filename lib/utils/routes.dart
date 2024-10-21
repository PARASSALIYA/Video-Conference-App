import 'package:flutter/material.dart';
import 'package:video_conference_app/Screens/Auth/login.dart';
import 'package:video_conference_app/Screens/Auth/signup.dart';
import 'package:video_conference_app/Screens/Auth/user_profile.dart';
import 'package:video_conference_app/Screens/Home/bnb.dart';
import 'package:video_conference_app/Screens/Home/mettings/mettings.dart';
import 'package:video_conference_app/users/screens/addgroup/addgroup_screen.dart';
import 'package:video_conference_app/users/screens/setting/setting_screen.dart';
import 'package:video_conference_app/users/screens/splash/splash_screen.dart';

class Routes {
  static Map<String, WidgetBuilder> routes = {
    '/splash': (context) => const SplashScreen(),
    '/signup' : (context) => const SignupScreen(),
    '/login' : (context) => const LoginScreen(),
    '/home': (context) => const Bnb(),
    '/addgroup': (context) => const AddgroupScreen(),
    '/setting': (context) => const SettingScreen(),
    '/meeting': (context) => const MeetingScreen(),
    '/userProfile': (context) => const UserProfile(),
  };
}
