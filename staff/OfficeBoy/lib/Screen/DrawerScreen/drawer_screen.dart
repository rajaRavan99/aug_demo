import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:officeboy/CommonWidget/textfield.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../CommonWidget/app_colors.dart';
import '../../Routes/routes.dart';
import '../../constData/GlobalVariable/global_varible.dart';
import '../HomeScreen/home_screen_controller.dart';

class MyDrawer extends StatelessWidget {
  MyDrawer({Key? key}) : super(key: key); 

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 0),

      child: Drawer(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(20),
            bottomRight: Radius.circular(20),
          ),
        ),
        elevation: 10.0,
        // ignore: avoid_unnecessary_containers
        child: ListView(
          children: [

            const ClipRect(child: Icon(Icons.account_circle_outlined,
              color: AppColors.grey_00,
              size: 100,),
            ),

            const SizedBox(height: 10,),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [

                  const SizedBox(height: 10),

                  Text(
                    email.toString().split('@').first,
                    style: FontStyle.textBlack,
                  ),
                ],
              ),
            ),

            const SizedBox(height: 10,),

            ListTile(
              onTap: () {
                Get.back();
                Get.toNamed(AppRoutes.timeScreen);
              },
              leading: const  Icon(
                Icons.timer,
              ),
              title: const Text(
                "Timing",
                textScaleFactor: 1.2,
                style: TextStyle(
                ),
              ),
            ),

            ListTile(
              onTap: () async {
                SharedPreferences preferences = await SharedPreferences.getInstance();
                preferences.remove('isLogin');
                Get.offNamed(AppRoutes.signInScreen);
              },
              leading: const Icon(
                Icons.logout_outlined,
                // color: Colors.black,
              ),
              title: const Text(
                "Logout",
                textScaleFactor: 1.2,
                style: TextStyle(
                  // color: Colors.black,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}