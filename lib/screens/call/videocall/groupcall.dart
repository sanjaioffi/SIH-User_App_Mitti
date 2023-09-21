import 'package:agora_uikit/agora_uikit.dart';
import 'package:flutter/material.dart';
import 'package:user_mitti/screens/call/value/setting.dart';

class GroupCall extends StatefulWidget {
  const GroupCall({Key? key}) : super(key: key);

  @override
  State<GroupCall> createState() => _GroupCallState();
}

class _GroupCallState extends State<GroupCall> {
  final AgoraClient client = AgoraClient(
    agoraConnectionData: AgoraConnectionData(
        appId: appId,
        channelName: channelId,
        uid: 0,
        tempToken: generateToken(0, channelId)
        // username: "user1",
        ),
  );

  @override
  void initState() {
    super.initState();
    initAgora();
  }

  void initAgora() async {
    await client.initialize();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Agora UI Kit'),
          centerTitle: true,
        ),
        body: SafeArea(
          child: Stack(
            children: [
              AgoraVideoViewer(
                client: client,
                // layoutType: Layout.floating,
                enableHostControls: true, // Add this to enable host controls
              ),
              AgoraVideoButtons(
                client: client,
              ),
            ],
          ),
        ),
      );
  }
}
