import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:user_mitti/controllers/location_controller.dart';

class Profile extends StatelessWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
      ),
      body: GetBuilder<LocationController>(builder: (_) {
        return _.userLocation.value == null
            ? Center(child: CircularProgressIndicator())
            : Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      _.userLocation.value!.toString(),
                    ),
                  ],
                ),
              );
      }),
    );
  }
}
