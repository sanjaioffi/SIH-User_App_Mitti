import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:user_mitti/screens/help_page.dart';
import 'package:user_mitti/screens/track_help.dart';
import 'package:flutter/material.dart';
import 'package:user_mitti/widgets/get_logo_text.dart';
import 'package:user_mitti/widgets/hub_info.dart';
import 'package:user_mitti/widgets/show_options.dart';

class TemprorayEmergencyRoomWidget extends StatelessWidget {
  const TemprorayEmergencyRoomWidget({
    super.key,
    required this.integratedReliefRoomName,
    required this.integratedReliefRoomCause,
    required this.integratedReliefLocation,
    required this.integratedReliefRoomAgencies,
    required this.integratedCreatedOn,
    required this.integratedroomId,
    required this.integratedlatLng,
    required this.radius,
  });

  final String integratedReliefRoomName;
  final String integratedReliefRoomCause;
  final String integratedReliefLocation;
  final List<dynamic> integratedReliefRoomAgencies;
  final String integratedCreatedOn;
  final String integratedroomId;
  final List integratedlatLng;
  final double radius;

  @override
  Widget build(BuildContext context) {
    Map<String, String> monthMap = {
      "01": "Jan",
      "02": "Feb",
      "03": "Mar",
      "04": "Apr",
      "05": "May",
      "06": "Jun",
      "07": "Jul",
      "08": "Aug",
      "09": "Sep",
      "10": "Oct",
      "11": "Nov",
      "12": "Dec"
    };
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListTile(
        contentPadding: const EdgeInsets.all(5),
        leading: GestureDetector(
          onTap: () {
            Get.to(() => HubInfo(roomName: integratedReliefRoomName));
          },
          child: CircleAvatar(
            radius: 30,
            child: Text(getLogoText(integratedReliefRoomName)),
          ),
        ),
        title: Text(
          integratedReliefRoomName,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Text(
          "Created on ${integratedCreatedOn.substring(8, 10)}th ${monthMap[integratedCreatedOn.substring(5, 7)]} ${integratedCreatedOn.substring(0, 4)}",
        ),
        trailing: const Icon(Icons.arrow_outward),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => TrackHelpPage()),
          );
        },
      ),
    );
  }
}
