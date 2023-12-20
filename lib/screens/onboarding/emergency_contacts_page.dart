import 'package:flutter/material.dart';
import 'package:contacts_service/contacts_service.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:user_mitti/controllers/usercontroller.dart';
import 'package:user_mitti/screens/mainscreens/main_page.dart';
import 'package:user_mitti/services/user_service.dart';

class EmergencyContactPage extends StatefulWidget {
  const EmergencyContactPage({super.key});

  @override
  _EmergencyContactPageState createState() => _EmergencyContactPageState();
}

class _EmergencyContactPageState extends State<EmergencyContactPage> {
  List<dynamic> _selectedContacts = [];
  List<Contact> _contacts = [];

  var title = "";

  Future<void> _loadContacts() async {
    print('loading contacts');
    bool isPermissionGranted = await Permission.contacts.isGranted;
    print(isPermissionGranted);
    if (!isPermissionGranted) {
      PermissionStatus permissionStatus = await Permission.contacts.request();
      if (permissionStatus != PermissionStatus.granted) {
        return;
      }
    }
    final Iterable<Contact> contacts = await ContactsService.getContacts();
    print(contacts.length);
    setState(() {
      _contacts = contacts.toList();
      print(_contacts.length);
    });
  }

  @override
  void initState() {
    super.initState();

    _loadContacts();
    print(Get.find<UserController>().uid);
    _selectedContacts =
        Get.find<UserController>().userData['emergencyContacts'] ?? [];

    print(_selectedContacts);

    // print(_selectedContacts);
    print(Get.find<UserController>().userData);
  }

  @override
  Widget build(BuildContext context) {
    final ModalRoute<Object?>? currentRoute = ModalRoute.of(context);
    final args = currentRoute?.settings.arguments.toString();
    print(args);

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Emergency Contacts',
        ),
      ),
      body: _contacts.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: _contacts.length,
              itemBuilder: (context, index) {
                final contact = _contacts[index];
                final bool isSelected = _selectedContacts.contains(
                    contact.phones!.length > 0
                        ? contact.phones!.first.value!
                        : '');
                return contact.phones!.length > 0
                    ? InkWell(
                        onTap: () {
                          setState(() {
                            isSelected
                                ? _selectedContacts
                                    .remove(contact.phones!.first.value!)
                                : _selectedContacts
                                    .add(contact.phones!.first.value!);
                          });
                        },
                        child: ListTile(
                          title: Text(contact.displayName ?? ''),
                          subtitle: Text(contact.phones!.isNotEmpty
                              ? contact.phones!.first.value!
                              : ''),
                          trailing: isSelected
                              ? const Icon(Icons.check_circle,
                                  color: Colors.green)
                              : const Icon(Icons.check_circle_outline),
                        ),
                      )
                    : SizedBox();
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          print(_selectedContacts);
          UserService().updateEmergencyContacts(
              Get.find<UserController>().uid, _selectedContacts);
          if (args == "editing") {
            Navigator.pop(context);
          } else {
            Get.to(const MainPage());
          }
        },
        child: Icon(args == "editing" ? Icons.check : Icons.arrow_forward_ios),
      ),
    );
  }
}
