import 'package:flutter/material.dart';
import 'package:video_conference_app/Agora/video_call.dart';

class JoinPage extends StatelessWidget {
  final TextEditingController _controller = TextEditingController();

  JoinPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Align(
              alignment: Alignment.topLeft,
              child: InkWell(
                onTap: Navigator.of(context).pop,
                child: const Icon(
                  Icons.arrow_back_ios_new_sharp,
                  size: 25,
                ),
              ),
            ),
            const SizedBox(height: 60),
            Image.asset(
              'assets/images/join.png',
              fit: BoxFit.cover,
              height: 150,
            ),
            const SizedBox(height: 20),
            const Text(
              "Enter Meeting Code Below",
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(15, 20, 15, 20),
              child: Card(
                color: Colors.grey[300],
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25)),
                child: TextField(
                  controller: _controller,
                  textAlign: TextAlign.center,
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    hintText: "Example: abc-def-ghi",
                  ),
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => VideoCall(
                              channelName: _controller.text.trim(),
                            )));
              },
              style: ElevatedButton.styleFrom(
                  fixedSize: const Size(80, 30),
                  backgroundColor: Colors.indigo,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25))),
              child: const Text(
                "Join",
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
