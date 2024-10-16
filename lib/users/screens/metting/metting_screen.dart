import 'package:flutter/material.dart';

class MettingScreen extends StatefulWidget {
  const MettingScreen({super.key});

  @override
  State<MettingScreen> createState() => _MettingScreenState();
}

class _MettingScreenState extends State<MettingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Meeting Page"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            ...List.generate(
              3,
              (index) => Container(
                margin: const EdgeInsets.only(bottom: 10),
                height: 200,
                decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
