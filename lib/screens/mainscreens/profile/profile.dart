import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:user_mitti/controllers/location_controller.dart';
import 'package:user_mitti/screens/mainscreens/profile/widgets/profile_widget.dart';

class Profile extends StatelessWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 0,
        backgroundColor: Colors.white,
        title: const Text('Profile'),
        actions: [
          const Icon(Icons.more_vert),
        ],
      ),
      // body: GetBuilder<LocationController>(builder: (_) {
      //   return _.userLocation.value == null
      //       ? const Center(child: CircularProgressIndicator())
      //       : Center(
      //           child: Column(
      //             mainAxisAlignment: MainAxisAlignment.center,
      //             children: <Widget>[
      //               Text(
      //                 _.userLocation.value!.toString(),
      //               ),
      //             ],
      //           ),
      //         );
      // }),

      body: Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                height: 20.h,
              ),
              const ProfileImage(),
              SizedBox(
                height: 20.h,
              ),
              ProfileTile(
                tileIcon: Icons.contact_emergency_outlined,
                title: "Emergency contacts",
                subtitle: "Make changes to contacts",
                function: () {
                  Navigator.pushNamed(context, 'EmergencyContactPage',
                      arguments: "editing");
                },
              ),
              ProfileTile(
                function: () {},
                tileIcon: Icons.person_outlined,
                title: "Account",
                subtitle: "Manage your account",
              ),
              ProfileTile(
                function: () {
                  Navigator.pushNamed(context, 'NotificationList');
                },
                tileIcon: Icons.notifications_outlined,
                title: "Notifications",
                subtitle: "Manage your notifications",
              ),
              ProfileTile(
                  function: () {},
                  tileIcon: Icons.lock_outline,
                  title: "Privacy",
                  subtitle: "manage privacy settings"),
              ProfileTile(
                function: () {},
                tileIcon: Icons.shield_outlined,
                title: "Security",
                subtitle: "manage security settings",
              ),
              ProfileTile(
                function: () {
                  Navigator.pushNamed(context, 'LanguageWidget');
                },
                tileIcon: Icons.language_outlined,
                title: "Language",
                subtitle: "manage language settings",
              ),
              ProfileTile(
                function: () {},
                tileIcon: Icons.info_outline,
                title: "About",
                subtitle: "About the app",
              ),
              ProfileTile(
                function: () {},
                tileIcon: Icons.logout_outlined,
                title: "Logout",
                subtitle: "Logout from the app",
              ),
            ],
          ),
        ),
      ),
    );
  }
}
