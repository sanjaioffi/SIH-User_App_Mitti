import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:user_mitti/screens/help_page.dart';

class TrackHelpPage extends StatefulWidget {
  @override
  _TrackHelpPageState createState() => _TrackHelpPageState();
}

class _TrackHelpPageState extends State<TrackHelpPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () => Get.to(() => PostHelpPage())),
      appBar: AppBar(
        title: Text('Track Help Requests'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('helps').snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return CircularProgressIndicator();
          }
          final helps = snapshot.data!.docs;
          return ListView.builder(
            itemCount: helps.length,
            itemBuilder: (context, index) {
              final help = helps[index].data() as Map<String, dynamic>;
              return ExpansionTile(
                children: [
                  Text('Request By: ${help['name']}'),
                  Text('Contact: ${help['mobile']}'),
                ],
                title: Text('Help Type: ${help['helpType']}'),
                subtitle: Text('Status: ${help['status']}'),
              );
            },
          );
        },
      ),
    );
  }
}
