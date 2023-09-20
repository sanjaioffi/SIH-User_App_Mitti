import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';

class Room {
  String id;
  String name;
  List<dynamic> location; // List of [latitude, longitude]
  double radius;

  Room(
      {required this.id,
      required this.name,
      required this.location,
      required this.radius});
}

// Constants for Earth's radius in meters and degrees-to-radians conversion
const double earthRadiusMeters = 6371000.0; // Earth's radius in meters
const double degreesToRadians = pi / 180.0;

// Function to calculate the Haversine distance between two points in meters
double calculateHaversineDistance(
    double lat1, double lon1, double lat2, double lon2) {
  final double dLat = (lat2 - lat1) * degreesToRadians;
  final double dLon = (lon2 - lon1) * degreesToRadians;

  final double a = sin(dLat / 2) * sin(dLat / 2) +
      cos(lat1 * degreesToRadians) *
          cos(lat2 * degreesToRadians) *
          sin(dLon / 2) *
          sin(dLon / 2);

  final double c = 2 * atan2(sqrt(a), sqrt(1 - a));

  final double distance = earthRadiusMeters * c;
  return distance;
}

// Function to check if a point is inside a circle defined by center and radius in meters
bool isPointInsideCircle(double pointLat, double pointLon, double circleLat,
    double circleLon, double radiusMeters) {
  final double distance =
      calculateHaversineDistance(pointLat, pointLon, circleLat, circleLon);

  return distance <= radiusMeters;
}

Future<List<Map<String, dynamic>>> findRoomsInRadius(List<dynamic> inputLocation) async {
  final roomsCollection = FirebaseFirestore.instance.collection('rooms');
  final querySnapshot = await roomsCollection.get();

  List<Map<String, dynamic>> roomsData = [];
  querySnapshot.docs.forEach((doc) {
    final roomData = doc.data() as Map<String, dynamic>;
    
    final roomLocation = roomData['location'] as List<dynamic>;
    final roomRadius = roomData['radius'] as double;
    // print(roomLocation);
    // print(roomRadius);

    if (isPointInsideCircle(inputLocation[0], inputLocation[1], roomLocation[0],
        roomLocation[1], roomRadius)) {
      print(roomData);
      print(roomData['roomName']);
             Map<String, dynamic> data = doc.data();
        roomsData.add(data);
    }
  });
  
  return roomsData;
}
