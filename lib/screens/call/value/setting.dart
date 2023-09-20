import 'package:agora_token_service/agora_token_service.dart';
import 'package:flutter/material.dart';

const channelId = 'test1';
const tempToken = "";
const appId = "95471fc0625f4be89c5c65cd334159eb";
generateToken(int uid, String channelName) {
  const expirationInSeconds = 3600;
  final currentTimestamp = DateTime.now().millisecondsSinceEpoch ~/ 1000;
  final expireTimestamp = currentTimestamp + expirationInSeconds;
  var token = RtcTokenBuilder.build(
    appId: appId,
    appCertificate: "2f09bc9363a84b12952e8e525880247d",
    channelName: channelName,
    uid: uid.toString(),
    role: RtcRole.publisher,
    expireTimestamp: expireTimestamp,
  );

  return token;
}

final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey =
    GlobalKey<ScaffoldMessengerState>(); // Global key to access the scaffold

showMessage(String message) {
  scaffoldMessengerKey.currentState?.showSnackBar(SnackBar(
    content: Text(message),
  ));
}
