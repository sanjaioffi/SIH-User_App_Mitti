import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mobile_number/mobile_number.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:user_mitti/controllers/usercontroller.dart';
import 'package:user_mitti/screens/onboarding/emergency_contacts_page.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final CollectionReference _usersCollection =
      FirebaseFirestore.instance.collection('users');
  late String status;
  final auth = FirebaseAuth.instance;
  List<String> selectedValues = [];
  List<String> items = [];
  TextEditingController nameController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

        getPhoneNumbers();
    status = 'Not Authenticated';
  }

  void SignIn() async {
    try {
      final userCredential = await auth.signInAnonymously();
      // Create a user document in Firestore
      await _usersCollection.doc(userCredential.user!.uid).set({
        'name': nameController.text,
        'phoneNumbers': selectedValues,
        'emergencyContacts': [],
      });
      final prefs = await SharedPreferences.getInstance();
      prefs.setString('uid', userCredential.user!.uid);
      Get.find<UserController>().setUserUid(userCredential.user!.uid);
      print("Signed in with temporary account.");
      Navigator.push(context, MaterialPageRoute(builder: (_) {
        return const EmergencyContactPage();
      }));
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case "operation-not-allowed":
          print("Anonymous auth hasn't been enabled for this project.");
          break;
        default:
          print("Unknown error.");
          print(e);
      }
    }
    setState(() {
      status = 'Authenticated';
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Align(
                alignment: Alignment.center,
                child:
                    Text('Welcome to Mitti', style: TextStyle(fontSize: 30))),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: nameController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Name',
                ),
                onSubmitted: (value) {
                      getPhoneNumbers();
                },
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text('Choose your Mobile Numbers'),
            ),
            SizedBox(
              height: 100,
              child: ListView.builder(
                itemCount: items.length,
                itemBuilder: (context, index) {
                  final item = items[index];
                  final isChecked = selectedValues.contains(item);

                  return CheckboxListTile(
                    title: Text(item),
                    value: isChecked,
                    onChanged: (bool? value) {
                      setState(() {
                        if (value != null && value) {
                          selectedValues.add(item);
                        } else {
                          selectedValues.remove(item);
                        }
                      });
                    },
                  );
                },
              ),
            ),
            Align(
              alignment: Alignment.center,
              child: ElevatedButton(
                onPressed: SignIn,
                child: const Text('Sign-In Anonymously'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void getPermission() async {
    bool isPermissionGranted = await MobileNumber.hasPhonePermission;
    if (isPermissionGranted) {
    } else {
      await MobileNumber.requestPhonePermission;
      setState(() {});
      print('permission granted');
    }
  }

  Future<void> getPhoneNumbers() async {
    List<String> phoneNumbers = [];

    final List<SimCard>? simCards = await MobileNumber.getSimCards;
    for (var i = 0; i < simCards!.length; i++) {
      String number = simCards[i].number ?? '';
      phoneNumbers.add(number);
    }

    print(phoneNumbers);
    setState(() {
      items = phoneNumbers;
    });
  }
}
