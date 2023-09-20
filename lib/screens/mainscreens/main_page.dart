import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:user_mitti/screens/mainscreens/home_page.dart';
import 'package:user_mitti/screens/mainscreens/profile.dart';
import 'package:user_mitti/screens/mainscreens/user_map.dart';

import '../../controllers/location_controller.dart';


class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final LocationController locationController = Get.put(LocationController());
  final List pages = [
    HomePage(),
   UserMapPage(),
   
    Profile(),
  ];

  late int curPage;
  @override
  void initState() {
    curPage = 0;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        onTap: (index) {
          setState(() {
            curPage = index;
          });
        },
        currentIndex: curPage,
        type: BottomNavigationBarType.fixed,
        selectedLabelStyle: const TextStyle(fontSize: 0),
        unselectedFontSize: 0,
        iconSize: 30,
        selectedIconTheme: const IconThemeData(color: Colors.blueAccent),
        unselectedIconTheme: const IconThemeData(color: Colors.grey),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.location_on),
            label: "",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: "",
          ),
        ],
      ),
      body: pages[curPage],
    );
  }
}
