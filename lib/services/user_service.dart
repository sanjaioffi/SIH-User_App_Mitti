import 'package:cloud_firestore/cloud_firestore.dart';

class UserService {
  final CollectionReference usersCollection =
      FirebaseFirestore.instance.collection('users');

  Future<void> updateEmergencyContacts(
    String uid,
    List<String> emergencyContacts,
  ) async {
    try {
      // Update the user's document with new emergency contacts
      await usersCollection.doc(uid).update({
        'emergencyContacts': emergencyContacts,
      });
    } catch (e) {
      print('Error updating emergency contacts: $e');
    }
  }
}
