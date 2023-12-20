import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:user_mitti/widgets/available_rooms.dart';
import 'package:user_mitti/widgets/weather_alerts.dart';
import '../../controllers/location_controller.dart';
import 'package:intl/intl.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        title: const Text(
          "User Demo Application",
          style: TextStyle(fontSize: 18),
        ),
        centerTitle: true,
      ),
      body: GetBuilder<LocationController>(builder: (_) {
        return _.userAddress.value == null
            ? const Center(child: CircularProgressIndicator())
            : const Center(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: 8.0),
                        child: Text('Available Rooms ',
                            style: TextStyle(
                              fontSize: 20,
                            )),
                      ),
                      AvailableRooms()
                    ],
                  ),
                ),
              );
      }),
    );
  }

  String formatDate(DateTime dateTime) {
    final DateFormat dayFormat = DateFormat('EEEE'); // Day in letters
    final DateFormat dateFormat = DateFormat('d'); // Date in numbers
    final DateFormat monthFormat = DateFormat('MMMM'); // Month in letters

    final String day = dayFormat.format(dateTime);
    final String date = dateFormat.format(dateTime);
    final String month = monthFormat.format(dateTime);

    return '$date $month 2023';
  }
}
