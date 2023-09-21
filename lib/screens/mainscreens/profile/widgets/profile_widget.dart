import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:user_mitti/controllers/usercontroller.dart';

class ProfileTile extends StatelessWidget {
  final IconData? tileIcon;

  final String title;
  final String subtitle;

  final function;

  const ProfileTile(
      {super.key,
      required this.tileIcon,
      required this.title,
      required this.subtitle,
      required this.function});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: function,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 10.h),
        // height: 50.h,
        width: 400.w,
        margin: EdgeInsets.only(bottom: 2.h),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: Colors.grey[300]!,
              width: 1.0,
            ),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CircleAvatar(
              radius: 23.r,
              backgroundColor: Colors.grey.withOpacity(.2),
              child: Icon(
                tileIcon,
                size: 25.0.sp,
                color: Colors.red,
              ),
            ),
            // const Spacer(),
            SizedBox(
              width: 25.w,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  //
                  subtitle,
                  style: TextStyle(
                    fontSize: 12.sp,
                    color: Colors.grey[500],
                  ),
                ),
              ],
            ),
            const Spacer(),
            Icon(
              Icons.arrow_forward_ios_rounded,
              size: 20.sp,
              color: Colors.grey[500],
            ),
          ],
        ),
      ),
    );
  }
}

class ProfileImage extends StatelessWidget {
  const ProfileImage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Column(
          children: [
            Container(
              height: 125.h,
              width: 140.w,
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.grey[300]!,
                  width: 1,
                ),
                // shape: BoxShape.circle,
                // backgroundBlendMode: BlendMode.darken,
                // boxShadow: [
                //   BoxShadow(
                //     color: Colors.grey.withOpacity(0.5),
                //     spreadRadius: 1,
                //     blurRadius: 2,
                //     offset: const Offset(0, 2),
                //   ),
                // ],
                borderRadius: BorderRadius.circular(70.0.sp),
                image: const DecorationImage(
                  image: NetworkImage(
                    "https://picsum.photos/250?image=342",
                  ),
                  fit: BoxFit.cover,
                ),
              ),
              child: Stack(
                children: [
                  Positioned(
                    top: 5,
                    right: 5,
                    child: GestureDetector(
                      onTap: () {},
                      child: Container(
                        height: 25.h,
                        width: 25.w,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5.0.sp),
                          color: Colors.grey[300],
                        ),
                        child: const Icon(
                          Icons.add_photo_alternate_outlined,
                          color: Colors.red,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 10.h,
            ),
            Text(Get.find<UserController>().userData['name'] ?? "User Name",
                style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold)),
            // phone number
            Text(
              Get.find<UserController>().userData['phoneNumbers'][0] ??
                  "phone number",
              style: TextStyle(
                fontSize: 15.sp,
                color: Colors.grey[500],
              ),
            ),
          ],
        ),
      ],
    );
  }
}
