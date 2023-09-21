import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:user_mitti/screens/help_page.dart';

class TrackHelpPage extends StatefulWidget {
  TrackHelpPage({super.key, required this.roomId});
  String roomId;

  @override
  _TrackHelpPageState createState() => _TrackHelpPageState();
}

class _TrackHelpPageState extends State<TrackHelpPage> {
  List<Map<String, dynamic>> helps = [];
  @override
  void initState() {
    fetchHelpRequestsInRoom(widget.roomId).then((value) {
      helps = value;
      setState(() {});
    });
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
            child: Icon(Icons.add),
            onPressed: () => Get.to(() => PostHelpPage(
                  roomId: widget.roomId,
                ))),
        appBar: AppBar(
          title: Text('Track Help Requests'),
        ),
        body: RefreshIndicator(
          onRefresh: () async {
            helps = await fetchHelpRequestsInRoom(widget.roomId);
            setState(() {});
          },
          child: ListView.builder(
            itemCount: helps.length,
            itemBuilder: (context, index) {
              Map<String, dynamic> help = helps[index];
              return ExpansionTile(
                children: [
                  Text('Request By: ${help['name']}'),
                  Text('Contact: ${help['mobile']}'),
                ],
                title: Text('Help Type: ${help['helpType']}'),
                subtitle: Text('Status: ${help['status']}'),
              );
            },
          ),
        ));
  }

  Future<List<Map<String, dynamic>>> fetchHelpRequestsInRoom(
      String roomId) async {
    final CollectionReference roomsCollection =
        FirebaseFirestore.instance.collection('rooms');
    final DocumentReference roomDoc = roomsCollection.doc(roomId);
    final CollectionReference helpRequestsCollection =
        roomDoc.collection('helpRequests');

    try {
      final QuerySnapshot querySnapshot = await helpRequestsCollection.get();

      final List<Map<String, dynamic>> helpRequests = [];

      for (final doc in querySnapshot.docs) {
        final data = doc.data() as Map<String, dynamic>;
        helpRequests.add(data);
      }

      return helpRequests;
    } catch (e) {
      print('Error fetching help requests in room: $e');
      return [];
    }
  }
}
