import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: ExpansionTile(
                  backgroundColor: Colors.grey[200],
                  title: Text('Help Type: ${help['helpType']}'),
                  subtitle: stepProgressIndicator(progress: help['status']),
                  children: [
                    SizedBox(height: 10.h),
                    Text('Request By: ${help['name']}'),
                    SizedBox(height: 5.h),
                    Text('Contact: ${help['mobile']}'),
                    SizedBox(height: 10.h),
                  ],
                ),
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

Widget stepProgressIndicator({required String progress}) {
  int status = 1;
  if (progress == "Pending") {
    status = 1;
  } else if (progress == "InProgress") {
    status = 2;
  } else {
    status = 3;
  }
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      SizedBox(
        height: 10.h,
      ),
      Text(
        'Status: $progress',
        style: TextStyle(
            color: status == 3
                ? Colors.green
                : status == 2
                    ? Colors.red
                    : Colors.blue),
      ),
      SizedBox(
        height: 10.h,
      ),
      SizedBox(
        width: 450.w,
        height: 10.h,
        child: LinearProgressIndicator(
          borderRadius: BorderRadius.circular(10.dm),
          value: status / 3,
          backgroundColor: Colors.grey[200],
          valueColor: AlwaysStoppedAnimation<Color>(status == 3
              ? Colors.green
              : status == 2
                  ? Colors.red
                  : Colors.blue),
        ),
      ),
    ],
  );
}
