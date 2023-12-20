import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:user_mitti/controllers/location_controller.dart';
import 'package:user_mitti/widgets/room_function.dart';
import 'package:user_mitti/widgets/temp_emergency_rooms.dart';

class AvailableRooms extends StatefulWidget {
  const AvailableRooms({super.key});

  @override
  State<AvailableRooms> createState() => _AvailableRoomsState();
}

class _AvailableRoomsState extends State<AvailableRooms> {
  List<Map<String, dynamic>> roomsData = [];
  @override
  void initState() {
    super.initState();
    getRooms();
  }

  Future<void> getRooms() async {
    List<Map<String, dynamic>> data = await findRoomsInRadius([
      Get.find<LocationController>().userLocation.value!.latitude,
      Get.find<LocationController>().userLocation.value!.longitude
    ]);
    setState(() {
      roomsData = data;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: RefreshIndicator(
        onRefresh: () => getRooms(),
        child: ListView.builder(
          itemCount: roomsData.length,
          itemBuilder: (context, index) {
            Map<String, dynamic> room = roomsData[index];
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: TemprorayEmergencyRoomWidget(
                  radius: room['radius'],
                  integratedlatLng: room['location'],
                  integratedroomId: room['roomId'],
                  integratedCreatedOn: Timestamp.fromMillisecondsSinceEpoch(
                          room['createdOn'].millisecondsSinceEpoch)
                      .toDate()
                      .toString(),
                  integratedReliefRoomName: room['roomName'],
                  integratedReliefRoomCause: room['disasterType'],
                  integratedReliefRoomAgencies: room['agencies'],
                  integratedReliefLocation: room['district']),
            );
          },
        ),
      ),
    );
  }
}
