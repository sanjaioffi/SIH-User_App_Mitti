class User {
  final String uid;
  final String name;
  final List<String> phoneNumbers;
  final List<String> emergencyContacts;

  User({
    required this.uid,
    required this.name,
    required this.phoneNumbers,
    required this.emergencyContacts,
  });
}
