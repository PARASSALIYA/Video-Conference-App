import 'dart:convert';

import 'package:agora_uikit/agora_uikit.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

class VideoCall extends StatefulWidget {
  String channelName = "test";

  VideoCall({super.key, required this.channelName});

  @override
  State<VideoCall> createState() => _VideoCallState();
}

class _VideoCallState extends State<VideoCall> {
  late final AgoraClient _client;

  bool _loading = true;

  String tempToken = "";

  @override
  void initState() {
    getToken();
    super.initState();
  }

  Future<void> getToken() async {
    String link =
        "https://a26b4f5a-8c2d-4ead-8423-dd20e5a26196-00-6renojoy82y.pike.replit.dev/rtc/${widget.channelName}/publisher/uid/1";

    Response _response = await get(Uri.parse(link));
    Map data = jsonDecode(_response.body);

    // print(data["rtcToken"]);
    setState(() {
      tempToken = data["rtcToken"];
    });

    _client = AgoraClient(
        agoraConnectionData: AgoraConnectionData(
            appId: "e54069fc15d843cdb53cf131e7c9311b",
            tempToken: tempToken,
            channelName: widget.channelName),
        enabledPermission: [
          Permission.camera,
          Permission.microphone,
        ]);
    Future.delayed(const Duration(seconds: 1))
        .then((value) => setState(() => _loading = false));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: _loading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : Stack(
                children: [
                  AgoraVideoViewer(
                    client: _client,
                    //layoutType: Layout.floating,
                  ),
                  AgoraVideoButtons(client: _client),
                ],
              ),
      ),
    );
  }
}
