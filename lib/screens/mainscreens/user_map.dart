import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:user_mitti/controllers/location_controller.dart';

class UserMapPage extends StatefulWidget {
  const UserMapPage(
      {super.key});


  @override
  State createState() => _UserMapPageState();
}

class _UserMapPageState extends State<UserMapPage> {
  late GoogleMapController mapController;

  List<Marker> markers = [];

  @override
  void initState() {
    super.initState();
    _addCustomMarkers();
  }

  void _addCustomMarkers() async {
    markers.add(Marker(
      markerId: const MarkerId('user'),
      position: LatLng(Get.find<LocationController>().userLocation.value!.latitude, Get.find<LocationController>().userLocation.value!.longitude),
    
    ));

    if (mounted) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GoogleMap(
        initialCameraPosition: CameraPosition(
          target: LatLng(Get.find<LocationController>().userLocation.value!.latitude, Get.find<LocationController>().userLocation.value!.longitude),
          zoom: 30.0,
        ),
        onMapCreated: (GoogleMapController controller) {
          setState(() {
            mapController = controller;
          });
        },
        markers: Set<Marker>.of(markers),
        circles: {
          Circle(
            circleId: const CircleId('disaster radius'),
            center: LatLng(Get.find<LocationController>().userLocation.value!.latitude, Get.find<LocationController>().userLocation.value!.longitude),
            radius: 10,
            fillColor: Colors.red.withOpacity(0.3),
            strokeColor: Colors.red,
            strokeWidth: 2,
          ),
        },
      ),
    );
  }
}

Future<BitmapDescriptor> _createCustomMarker(String imagePath) async {
  const ImageConfiguration config = ImageConfiguration();
  final BitmapDescriptor bitmapDescriptor =
      await BitmapDescriptor.fromAssetImage(config, imagePath);
  return bitmapDescriptor;
}
