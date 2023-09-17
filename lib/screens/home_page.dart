import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';

import '../controllers/location_controller.dart';

class HomePage extends StatefulWidget {
 HomePage({super.key});
    final LocationController locationController = Get.put(LocationController());

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String? _currentDistrict;
  @override
  void initState() {
    super.initState();
  }

  Future<void> getDistrictFromPosition(Position position) async {
    try {
      final placemarks =
          await placemarkFromCoordinates(position.latitude, position.longitude);
      if (placemarks.isNotEmpty) {
        final firstPlacemark = placemarks.first;
        setState(() {
          _currentDistrict = firstPlacemark.subAdministrativeArea!;
        });
      }
    } catch (e) {
      print("Error getting district: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Home Page')),
      body: 
      GetBuilder<LocationController>(
        builder: (_) {
          return 
           Center(
            child: Text(
                'Current Location is: ${_.userLocation.value?.latitude}, ${_.userLocation.value?.longitude}'),
          );
        }
      ),
    );
  }
}
