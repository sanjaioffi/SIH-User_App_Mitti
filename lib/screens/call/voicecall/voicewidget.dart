// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:user_mitti/screens/call/voicecall/voicecall.dart';

class Voice extends StatelessWidget {
  var status;
  var leave;

  Voice({
    Key? key,
    required this.status,
    required this.leave,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Status text
            SizedBox(
                height: 40, child: Center(child: Text(VoiceCall.statusText))),
            // Button Row
            Row(
              children: <Widget>[
                const SizedBox(width: 10),
                Expanded(
                  child: IconButton(
                    icon: Icon(
                      Icons.call_end,
                      size: 32.sp,
                      color: Colors.red,
                    ),
                    onPressed: () => {leave(), Navigator.pop(context)},
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
