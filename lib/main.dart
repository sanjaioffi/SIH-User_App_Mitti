import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:user_mitti/controllers/usercontroller.dart';
import 'package:user_mitti/firebase_options.dart';
import 'package:user_mitti/screens/call/videocall/groupcall.dart';
import 'package:user_mitti/screens/call/videocall/videocall.dart';
import 'package:user_mitti/screens/call/voicecall/voicecall.dart';
import 'package:user_mitti/screens/mainscreens/home_page.dart';
import 'package:user_mitti/screens/mainscreens/main_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';
import 'package:user_mitti/screens/onboarding/signin_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await Firebase.initializeApp();
  // Check if the user's UID is saved in shared preferences
  final prefs = await SharedPreferences.getInstance();
  final uid = prefs.getString('uid');
  runApp(MyApp(
    uid: uid,
  ));
}

class MyApp extends StatelessWidget {
  final String? uid;

  const MyApp({super.key, required this.uid});

  @override
  Widget build(BuildContext context) {
    final UserController userController = Get.put(UserController());
    if (uid != null) {
      userController.setUserUid(uid!);
      userController.fetchUserData();
    }
    return ScreenUtilInit(
      child: GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'User App',
        theme: ThemeData(
          fontFamily: 'Poppins',
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.greenAccent),
          useMaterial3: true,
        ),
        home: uid != null ? const MainPage() : const SignInPage(),
        routes: {
          "groupCall": (p0) => const GroupCall(),
          "voiceCall": (p0) => VoiceCall("cha"),
          "mainPage": (p0) => const MainPage(),
          "homePage": (p0) => const HomePage(),
          "signInPage": (p0) => const SignInPage(),
          "videoCall": (p0) => const VideoCall(),
        },
      ),
    );
  }
}
