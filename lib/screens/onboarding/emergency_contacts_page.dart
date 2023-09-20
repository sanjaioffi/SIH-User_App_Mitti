import 'package:flutter/material.dart';
import 'package:contacts_service/contacts_service.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:user_mitti/controllers/usercontroller.dart';
import 'package:user_mitti/screens/mainscreens/main_page.dart';
import 'package:user_mitti/services/user_service.dart';

class EmergencyContactPage extends StatefulWidget {
  @override
  _EmergencyContactPageState createState() => _EmergencyContactPageState();
}

class _EmergencyContactPageState extends State<EmergencyContactPage> {
  List<Contact> _selectedContacts = [];
  List<Contact> _contacts = [];

  Future<void> _loadContacts() async {
    bool isPermissionGranted = await Permission.contacts.isGranted;
    if (!isPermissionGranted) {
      PermissionStatus permissionStatus = await Permission.contacts.request();
      if (permissionStatus != PermissionStatus.granted) {
        return;
      }
    }
    final Iterable<Contact> contacts = await ContactsService.getContacts();
    setState(() {
      _contacts = contacts.toList();
    });
  }

  @override
  void initState() {
    super.initState();
    _loadContacts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Emergency Contacts',
        ),
      ),
      body: _contacts.isEmpty
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: _contacts.length,
              itemBuilder: (context, index) {
                final contact = _contacts[index];
                final bool isSelected = _selectedContacts.contains(contact);
                return InkWell(
                  onTap: () {
                    setState(() {
                      isSelected
                          ? _selectedContacts.remove(contact)
                          : _selectedContacts.add(contact);
                    });
                  },
                  child: ListTile(
                    title: Text(contact.displayName ?? ''),
                    subtitle: Text(contact.phones!.isNotEmpty
                        ? contact.phones!.first.value!
                        : ''),
                    trailing: isSelected
                        ? Icon(Icons.check_circle, color: Colors.green)
                        : Icon(Icons.check_circle_outline),
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          print(_selectedContacts);
          UserService().updateEmergencyContacts(
            Get.find<UserController>().uid,
            _selectedContacts
                .map((contact) => contact.phones!.first.value!)
                .toList(),
          );
          Get.to(MainPage());
        },
        child: Icon(Icons.arrow_forward_ios),
      ),
    );
  }
}
