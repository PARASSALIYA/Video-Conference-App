import 'package:flutter/material.dart';
import 'package:video_conference_app/Screens/Auth/signup.dart';

void main() {
  setup().then((_) {
    runApp(const MyApp());
  });
}

Future<void> setup() async {
  // await setupFirebase();
  // await registerServices();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        
        useMaterial3: true,
      ),
      home: const SignupScreen(),
    );
  }
}
