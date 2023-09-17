import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';

class LocationController extends GetxController {
  Rx<Position?> userLocation = Rx<Position?>(null);

  @override
  void onInit() {
    super.onInit();
    updateUserLocation();
    print(userLocation);
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

      
    } else {
      Get.showSnackbar(GetSnackBar(
        message: 'Location permission is required to use this application.',
        duration: Duration(seconds: 5),
        mainButton: TextButton(
          onPressed: () async {
            await openAppSettings();
          },
          child: Text('Settings'),
        ),
      ));
    }
  }
}
