import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';

class LocationController extends GetxController {
  Rx<Position?> userLocation = Rx<Position?>(null);
  Rx<Placemark?> userAddress = Rx<Placemark?>(null);

  @override
  void onInit() {
    super.onInit();
    updateUserLocation();
    print(userLocation);
  }

  Future<void> updateDistrict(Position position) async {
    try {
      final placemarks =
          await placemarkFromCoordinates(position.latitude, position.longitude);
      if (placemarks.isNotEmpty) {
        final firstPlacemark = placemarks.first;
        userAddress.value = firstPlacemark;
        update();
      }
    } catch (e) {
      print("Error getting district: $e");
    }
  }

  Future<void> updateUserLocation() async {
    final permissionStatus = await Permission.location.request();
    print(permissionStatus);
    if (permissionStatus.isGranted) {
      final position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );
      userLocation.value = position;
      update();
      updateDistrict(position);
    } else {
      Get.showSnackbar(GetSnackBar(
        message: 'Location permission is required to use this application.',
        duration: const Duration(seconds: 5),
        mainButton: TextButton(
          onPressed: () async {
            await openAppSettings();
          },
          child: const Text('Settings'),
        ),
      ));
    }
  }
}
