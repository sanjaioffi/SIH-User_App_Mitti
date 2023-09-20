import 'dart:async';
import 'package:agora_token_service/agora_token_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:permission_handler/permission_handler.dart';

import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:user_mitti/screens/call/value/setting.dart';
import 'package:user_mitti/screens/call/voicecall/voicewidget.dart';

class VoiceCall extends StatefulWidget {
  static String statusText = 'Join a channel';
  VoiceCall(this.channelId);
  String channelId;
  @override
  _VoiceCallState createState() => _VoiceCallState();
}

class _VoiceCallState extends State<VoiceCall> {
  String channelName = channelId;
  String token = tempToken;

  int uid = 0; // uid of the local user

  int? _remoteUid; // uid of the remote user
  bool _isJoined = false; // Indicates if the local user has joined the channel
  late RtcEngine agoraEngine; // Agora engine instance

  final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey =
      GlobalKey<ScaffoldMessengerState>(); // Global key to access the scaffold

  showMessage(String message) {
    scaffoldMessengerKey.currentState?.showSnackBar(SnackBar(
      content: Text(message),
    ));
  }

  @override
  void initState() {
    super.initState();
    // Set up an instance of Agora engine
    setupVoiceSDKEngine();
    // generating Token
    generateToken();
  } // Clean up the resources when you leave

  @override
  void dispose() async {
    await agoraEngine.leaveChannel();
    super.dispose();
  }

  // Build UI
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: scaffoldMessengerKey,
        appBar: AppBar(
          title: Text(widget.channelId + 'Voice Call'),
        ),
        body: Center(
          child: ElevatedButton(
            child: const Text("Make a call"),
            onPressed: () => {
              print("token --------------------> $token"),
              setState(() {
                join();
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          Voice(status: _status, leave: leave),
                    ));
              })
            },
          ),
        ));
  }

  Widget _status() {
    if (!_isJoined)
      setState(() {
        VoiceCall.statusText = 'Join a channel';
      });
    else if (_remoteUid == null)
      setState(() {
        VoiceCall.statusText = 'Waiting for a remote user to join...';
      });
    else
      setState(() {
        VoiceCall.statusText = 'Connected to remote user, uid:$_remoteUid';
      });

    return Text(
      VoiceCall.statusText,
    );
  }

  Future<void> setupVoiceSDKEngine() async {
    // retrieve or request microphone permission
    await [Permission.microphone].request();

    //create an instance of the Agora engine
    agoraEngine = createAgoraRtcEngine();
    await agoraEngine.initialize(const RtcEngineContext(appId: appId));

    // Register the event handler
    agoraEngine.registerEventHandler(
      RtcEngineEventHandler(
        onJoinChannelSuccess: (RtcConnection connection, int elapsed) {
          showMessage(
              "Local user uid:${connection.localUid} joined the channel");
          setState(() {
            _isJoined = true;
          });
        },
        onUserJoined: (RtcConnection connection, int remoteUid, int elapsed) {
          showMessage("Remote user uid:$remoteUid joined the channel");
          setState(() {
            _remoteUid = remoteUid;
          });
        },
        onUserOffline: (RtcConnection connection, int remoteUid,
            UserOfflineReasonType reason) {
          showMessage("Remote user uid:$remoteUid left the channel");
          setState(() {
            _remoteUid = null;
          });
        },
      ),
    );
  }

  void join() async {
    // Set channel options including the client role and channel profile
    ChannelMediaOptions options = const ChannelMediaOptions(
      clientRoleType: ClientRoleType.clientRoleBroadcaster,
      channelProfile: ChannelProfileType.channelProfileCommunication,
    );

    await agoraEngine.joinChannel(
      token: token,
      channelId: channelName,
      options: options,
      uid: uid,
    );
  }

  void leave() {
    setState(() {
      _isJoined = false;
      _remoteUid = null;
    });
    agoraEngine.leaveChannel();
  }

  void generateToken() {
    const expirationInSeconds = 3600;
    final currentTimestamp = DateTime.now().millisecondsSinceEpoch ~/ 1000;
    final expireTimestamp = currentTimestamp + expirationInSeconds;
    token = RtcTokenBuilder.build(
      appId: appId,
      appCertificate: "2f09bc9363a84b12952e8e525880247d",
      channelName: channelName,
      uid: uid.toString(),
      role: RtcRole.publisher,
      expireTimestamp: expireTimestamp,
    );

    return;
  }
}
