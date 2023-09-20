import 'package:flutter/material.dart';
import 'package:user_mitti/screens/call/voicecall/voicecall.dart';

class TextPage extends StatefulWidget {
  TextPage({super.key});

  @override
  State<TextPage> createState() => _TextPageState();
}

class _TextPageState extends State<TextPage> {
  List PageName = [
    "channel1",
    "channel2",
    "channel3",
    "channel4",
    "channel5",
    "channel6",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: ListView.builder(
          itemCount: PageName.length,
          itemBuilder: (BuildContext context, int index) {
            return ListTile(
              title: Text(PageName[index]),
              onTap: () {
            
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return VoiceCall(PageName[index]);
                }));
              },
            );
          },
        ),
      ),
    );
  }
}
