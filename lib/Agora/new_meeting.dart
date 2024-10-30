import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:video_conference_app/Agora/video_call.dart';
import 'package:flutter_share/flutter_share.dart';

class NewMeeting extends StatefulWidget {
  const NewMeeting({super.key});

  @override
  State<NewMeeting> createState() => _NewMeetingState();
}

class _NewMeetingState extends State<NewMeeting> {
  String _meetingCode = "abcdefgwq";

  @override
  void initState() {
    var uuid = const Uuid();
    _meetingCode = uuid.v1().substring(0, 8);
    super.initState();
  }

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
              'assets/images/newmeeting.png',
              fit: BoxFit.cover,
              height: 150,
            ),
            const SizedBox(height: 20),
            const Text(
              "Your Meeting is Ready",
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(15, 20, 15, 0),
              child: Card(
                color: Colors.grey[300],
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25)),
                child: ListTile(
                  leading: const Icon(Icons.link),
                  title: SelectableText(
                    _meetingCode,
                    style: const TextStyle(
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                  trailing: const Icon(Icons.copy),
                ),
              ),
            ),
            const Divider(
              thickness: 1,
              height: 40,
              indent: 20,
              endIndent: 20,
            ),
            ElevatedButton.icon(
              onPressed: () {
                FlutterShare.share(title: _meetingCode);
              },
              label: const Text(
                "Share Invite",
                style: TextStyle(color: Colors.white),
              ),
              icon: const Icon(
                Icons.arrow_drop_down,
                color: Colors.white,
              ),
              style: ElevatedButton.styleFrom(
                  fixedSize: const Size(350, 30),
                  backgroundColor: Colors.indigo,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25))),
            ),
            const SizedBox(height: 20),
            OutlinedButton.icon(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            VideoCall(channelName: _meetingCode)));
              },
              icon: const Icon(Icons.video_call),
              label: const Text("Start Call"),
              style: OutlinedButton.styleFrom(
                  side: const BorderSide(color: Colors.indigo),
                  fixedSize: const Size(350, 30),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25))),
            ),
          ],
        ),
      ),
    );
  }
}
