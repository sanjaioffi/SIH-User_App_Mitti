import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:user_mitti/controllers/location_controller.dart';
import 'package:user_mitti/controllers/usercontroller.dart';
import 'package:user_mitti/screens/mainscreens/main_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';
import 'package:user_mitti/screens/onboarding/signin_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
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

  MyApp({required this.uid});

  @override
  Widget build(BuildContext context) {

    final UserController userController = Get.put(UserController());
    if (uid != null) {
      userController.setUserUid(uid!);
      userController.fetchUserData();
    }
    return GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'User App',
        theme: ThemeData(
          fontFamily: 'Poppins',
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: uid != null ? MainPage() : SignInPage()
        ,
        );
  }
}
