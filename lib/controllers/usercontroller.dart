
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UserController extends GetxController {
  RxString _uid = ''.obs;
  RxMap<dynamic, dynamic> userData = {}.obs;

  String get uid => _uid.value;


  Future<void> fetchUserData() async {
    final userUid = uid;
    try {
      final userDoc = await FirebaseFirestore.instance.collection('users').doc(userUid).get();
      if (userDoc.exists) {
        userData.value = userDoc.data() as Map<String, dynamic>;
      }
    } catch (e) {
      print('Error fetching user data: $e');
    }
  }

  void setUserUid(String uid) {
    _uid.value = uid;
  }
}



