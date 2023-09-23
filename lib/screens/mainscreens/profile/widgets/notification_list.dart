import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class NotificationsList extends StatelessWidget {
  const NotificationsList({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Notifications'),
        scrolledUnderElevation: 0,
        backgroundColor: Colors.white,
      ),
      body: Center(
        child: Container(
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
          // no notifications vector image from flaticon
          child: Image.network(
            'https://as1.ftcdn.net/v2/jpg/04/40/90/50/1000_F_440905092_6U6FO7qJY8oG8aQ2mdaLO3vyy4hsrI9G.jpg',
            height: 200.h,
            width: 200.w,
          ),
        ),
      ),
    );
  }
}
