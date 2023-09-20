import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:user_mitti/widgets/available_rooms.dart';
import 'package:user_mitti/widgets/weather_alerts.dart';
import 'dart:async';
import '../../controllers/location_controller.dart';
import 'package:intl/intl.dart';

class HomePage extends StatefulWidget {
  HomePage({super.key});

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
    return SafeArea(
      child: Scaffold(
        body: GetBuilder<LocationController>(builder: (_) {
          return  _.userAddress.value == null
              ? Center(child: CircularProgressIndicator())
              : Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 10),
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Text('${formatDate(DateTime.now())}'),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Row(
                          children: [
                            Icon(
                              Icons.location_on,
                              color: Colors.red,
                            ),
                            SizedBox(width: 10),
                            Text(
                              '${_.userAddress.value!.locality ?? 'Unknown'}, ',
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                            Text(
                              '${_.userAddress.value!.country ?? 'Unknown'}',
                              style: TextStyle(
                                  fontSize: 17, color: Colors.grey.shade700),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 10),
                      WeatherAlerts(),
                      SizedBox(height: 20),
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Text('Available Rooms ',
                            style: TextStyle(
                              fontSize: 20,
                            )),
                      ),
                      AvailableRooms()
                    ],
                  ),
                );
        }),
      ),
    );
  }

  String formatDate(DateTime dateTime) {
    final DateFormat dayFormat = DateFormat('EEEE'); // Day in letters
    final DateFormat dateFormat = DateFormat('d'); // Date in numbers
    final DateFormat monthFormat = DateFormat('MMMM'); // Month in letters

    final String day = dayFormat.format(dateTime);
    final String date = dateFormat.format(dateTime);
    final String month = monthFormat.format(dateTime);

    return '$day, $date $month';
  }
}
