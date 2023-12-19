import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:user_mitti/controllers/location_controller.dart';
import 'package:user_mitti/screens/track_help.dart';
import 'package:user_mitti/widgets/room_function.dart';

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class UserMapScreen extends StatefulWidget {
  const UserMapScreen({super.key});

  @override
  State createState() => _UserMapScreenState();
}

class _UserMapScreenState extends State<UserMapScreen> {
  late GoogleMapController mapController;

  double radius = 500;
  List<Marker> markers = [];
  List<Circle> circles = [];

  List<Map<String, dynamic>> roomsData = [];

  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  Future<void> _fetchData() async {
    List<Map<String, dynamic>> data = await getRooms();
    setState(() {
      roomsData = data;
    });
    if (roomsData.isEmpty) {
      return;
    }
    _addCustomMarkers();
    _addCircles();
  }

  Future<List<Map<String, dynamic>>> getRooms() async {
    List<Map<String, dynamic>> data = await findRoomsInRadius([
      Get.find<LocationController>().userLocation.value!.latitude,
      Get.find<LocationController>().userLocation.value!.longitude
    ]);
    return data;
  }

  Future<void> _addCustomMarkers() async {
    for (int i = 0; i < roomsData.length; i++) {
      markers.add(Marker(
        onTap: () {
          showModalBottomSheet(
            context: context,
            builder: (context) {
              return LocationInfoBottomSheet(
                roomData: roomsData[i],
              );
            },
          );
        },
        markerId: MarkerId(roomsData[i]['roomId']),
        position:
            LatLng(roomsData[i]['location'][0], roomsData[i]['location'][1]),
        icon: await _createCustomMarker('assets/images/fire.png'),
      ));
    }
    markers.add(Marker(
      onTap: () {
        showModalBottomSheet(
          context: context,
          builder: (context) {
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Align(
                    alignment: Alignment.center,
                    child: Text(
                      'User Location',
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Center(child: Text('Contact the nearest Agencies for help')),
                  const SizedBox(height: 8),
                  Center(
                    child: SizedBox(
                      width: double.maxFinite,
                      height: 50,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.white,
                          backgroundColor: Colors.deepPurpleAccent,
                          shape: const StadiumBorder(),
                        ),
                        onPressed: () {
                          // Navigator.push(
                          //     context,
                          //     MaterialPageRoute(
                          //         builder: (context) => TrackHelpPage(
                          //               roomId: roomData['roomId'],
                          //             )));
                        },
                        child: const Text(
                          'Request Help',
                          style: TextStyle(fontSize: 20),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
      markerId: const MarkerId('user'),
      position: LatLng(
          Get.find<LocationController>().userLocation.value!.latitude,
          Get.find<LocationController>().userLocation.value!.longitude),
    ));
    Marker agencyMarker1 = Marker(
      markerId: MarkerId('1'),
      position: LatLng(
        10.368834026556598,
        77.97227805344454,
      ), // Marker coordinates
      infoWindow: InfoWindow(
        title: 'Agency 1',
        snippet: 'Railway Protection Force', // Add agency information here
      ),
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
    );

    Marker agencyMarker2 = Marker(
      markerId: MarkerId('2'),
      position: LatLng(
        10.373399512462896,
        77.97094154938793,
      ), // Marker coordinates
      infoWindow: InfoWindow(
        title: 'Agency 2',
        snippet:
            'Dindigul Disaster Management Authority', // Add agency information here
      ),
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
    );

    // Add markers to the Set
    markers.add(agencyMarker1);
    markers.add(agencyMarker2);

    if (mounted) {
      setState(() {});
    }
  }

  Future<void> _addCircles() async {
    for (int i = 0; i < roomsData.length; i++) {
      circles.add(Circle(
        circleId: CircleId(roomsData[i]['roomId']),
        center:
            LatLng(roomsData[i]['location'][0], roomsData[i]['location'][1]),
        radius: roomsData[i]['radius'],
        fillColor: Colors.red.withOpacity(0.3),
        strokeColor: Colors.red,
        strokeWidth: 2,
      ));
    }

    if (mounted) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: roomsData.isEmpty && markers.isEmpty && circles.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : GoogleMap(
              initialCameraPosition: CameraPosition(
                target: LatLng(
                    roomsData[0]['location'][0], roomsData[0]['location'][1]),
                zoom: 14.5,
              ),
              onMapCreated: (GoogleMapController controller) {
                setState(() {
                  mapController = controller;
                });
              },
              markers: Set<Marker>.of(markers),
              circles: Set<Circle>.of(circles),
            ),
    );
  }
}

class LocationInfoBottomSheet extends StatelessWidget {
  LocationInfoBottomSheet({super.key, required this.roomData});
  var roomData;
  @override
  Widget build(
    BuildContext context,
  ) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Align(
            alignment: Alignment.center,
            child: Text(
              roomData['disasterType'],
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(height: 8),
          Text('Room Name: ${roomData['roomName']}'),
          const SizedBox(height: 8),
          Text('Location: ${roomData['district']}, ${roomData['state']}'),
          const SizedBox(height: 10),
          Center(
            child: SizedBox(
              width: double.maxFinite,
              height: 50,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: Colors.deepPurpleAccent,
                  shape: const StadiumBorder(),
                ),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => TrackHelpPage(
                                roomId: roomData['roomId'],
                              )));
                },
                child: const Text(
                  'Go To Room',
                  style: TextStyle(fontSize: 20),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// -----------------------

Future<BitmapDescriptor> _createCustomMarker(String imagePath) async {
  const ImageConfiguration config = ImageConfiguration();
  final BitmapDescriptor bitmapDescriptor =
      await BitmapDescriptor.fromAssetImage(config, imagePath);
  return bitmapDescriptor;
}

generateMarker(IconData icon, Color color) {
  return Column(
    children: [
      CircleAvatar(
          radius: 15,
          backgroundColor: color,
          child: Icon(
            icon,
            color: Colors.white,
          )),
      const SizedBox(height: 1),
      CircleAvatar(
        radius: 2,
        backgroundColor: color,
      )
    ],
  );
}
