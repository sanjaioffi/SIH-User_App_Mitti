import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:user_mitti/controllers/usercontroller.dart';

class PostHelpPage extends StatefulWidget {
  PostHelpPage({super.key, required this.roomId});
  String roomId;
  @override
  _PostHelpPageState createState() => _PostHelpPageState();
}

class _PostHelpPageState extends State<PostHelpPage> {
  final TextEditingController _nameController = TextEditingController(
      text: Get.find<UserController>().userData['name'] ?? '');
  final TextEditingController _mobileController = TextEditingController(
      text: Get.find<UserController>().userData['phoneNumbers'][0] ?? '');
  String _selectedHelpType = 'Food';
  int _numberOfPeople = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Post Help Request'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            TextFormField(
              controller: _nameController,
              decoration: InputDecoration(
                  border: OutlineInputBorder(), labelText: 'Name'),
            ),
            SizedBox(
              height: 30,
            ),
            TextFormField(
              controller: _mobileController,
              decoration: InputDecoration(
                  border: OutlineInputBorder(), labelText: 'Mobile Number'),
            ),
            SizedBox(
              height: 30,
            ),
            Text('Select the Type of Help'),
            SizedBox(
              height: 10,
            ),
            DropdownButtonFormField<String>(
              decoration: InputDecoration(border: OutlineInputBorder()),
              value: _selectedHelpType,
              items: ['Food', 'Boat', 'Shelters'].map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              onChanged: (String? newValue) {
                setState(() {
                  _selectedHelpType = newValue!;
                });
              },
            ),
            SizedBox(
              height: 30,
            ),
            TextFormField(
              initialValue: '1',
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                  labelText: 'Number of People', border: OutlineInputBorder()),
              onChanged: (value) {
                _numberOfPeople = int.tryParse(value) ?? 1;
              },
            ),
            SizedBox(height: 16),
            Align(
              alignment: Alignment.center,
              child: ElevatedButton(
                onPressed: () async {
                  await _postHelpRequest(widget.roomId);
                },
                child: Text('Submit Help Request'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _postHelpRequest(String roomId) async {
    try {
      final CollectionReference roomsCollection =
          FirebaseFirestore.instance.collection('rooms');
      final DocumentReference roomDoc = roomsCollection.doc(roomId);

      await roomDoc.collection('helpRequests').add({
        'name': _nameController.text,
        'mobile': _mobileController.text,
        'helpType': _selectedHelpType,
        'numberOfPeople': _numberOfPeople,
        'status': 'Pending', // Initial status
        'timestamp': FieldValue.serverTimestamp(),
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content:
              Text('Help request submittet. refresh to see the updated list.'),
        ),
      );
      Navigator.pop(context);
      setState(() {});
    } catch (e) {
      print('Error posting help request: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content:
              Text('Error submitting help request. Please try again later.'),
        ),
      );
    }
  }
}
