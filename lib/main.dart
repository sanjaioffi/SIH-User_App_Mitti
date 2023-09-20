import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:user_mitti/firebase_options.dart';
import 'package:user_mitti/screens/call/videocall/groupcall.dart';
import 'package:user_mitti/screens/call/videocall/videocall.dart';
import 'package:user_mitti/screens/call/voicecall/voicecall.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';
import 'package:user_mitti/screens/home_page.dart';
import 'package:user_mitti/screens/main_page.dart';
import 'package:user_mitti/screens/signin_page.dart';

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
        home: MainPage(),
        routes: {
          "groupCall": (p0) => GroupCall(),
          "voiceCall": (p0) => VoiceCall("cha"),
          "mainPage": (p0) => MainPage(),
          "homePage": (p0) => HomePage(),
          "signInPage": (p0) => SignInPage(),
          "videoCall": (p0) => VideoCall(),
        },
      ),
    );
  }
}
