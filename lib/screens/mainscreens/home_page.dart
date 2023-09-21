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
    print('home');
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: GetBuilder<LocationController>(builder: (_) {
          return _.userAddress.value == null
              ? const Center(child: CircularProgressIndicator())
              : Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 10),
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Text(formatDate(DateTime.now())),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 1.0, top: 8.0),
                        child: Row(
                          children: [
                            const Icon(
                              Icons.location_on,
                              color: Colors.red,
                            ),
                            const SizedBox(width: 5),
                            Text(
                              '${_.userAddress.value!.locality ?? 'Unknown'}, ',
                              style: const TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                            Text(
                              _.userAddress.value!.country ?? 'Unknown',
                              style: TextStyle(
                                  fontSize: 17, color: Colors.grey.shade700),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 25),
                      WeatherAlerts(),
                      const SizedBox(height: 25),
                      const Padding(
                        padding: EdgeInsets.only(left: 8.0),
                        child: Text('Available Rooms ',
                            style: TextStyle(
                              fontSize: 20,
                            )),
                      ),
                      const AvailableRooms()
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
