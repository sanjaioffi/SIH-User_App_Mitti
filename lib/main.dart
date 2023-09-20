import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:user_mitti/firebase_options.dart';
import 'package:user_mitti/screens/call/videocall/groupcall.dart';
import 'package:user_mitti/screens/call/videocall/videocall.dart';
import 'package:user_mitti/screens/call/voicecall/voicecall.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
   options: DefaultFirebaseOptions.currentPlatform,
  );
  
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      child: GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'User App',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.greenAccent),
          useMaterial3: true,
        ),
        home: GroupCall(),
        routes: {
          "voiceCall": (p0) => VoiceCall("cha" ),
          "videoCall": (p0) => VideoCall(),
        },
      ),
    );
  }
}
