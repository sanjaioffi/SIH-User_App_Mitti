import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  late String status;
  final auth = FirebaseAuth.instance;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    status = 'Not Authenticated';
  }

  void SignIn() async{
    try {
  final userCredential =
      await auth.signInAnonymously();
  print("Signed in with temporary account.");
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
    return Scaffold(
      appBar: AppBar(
        title: Text('SignIn Page'),
      ),
      body: Column(
        children: [
          Text('SignIn Page'),
          ElevatedButton(
            onPressed: SignIn,
            child: Text('SignIn'),
          ),
        ],
      ),
    );
  }
}
