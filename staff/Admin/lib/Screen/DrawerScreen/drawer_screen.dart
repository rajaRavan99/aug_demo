import 'package:firebasedemo/CommonWidget/app_colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebasedemo/CommonWidget/textfield.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../ConstData/Global_Variable/global_variable.dart';
import '../../Routes/routes.dart';

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

        child: ListView(
          children: [

            const SizedBox(height: 10,),


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

                  const SizedBox(height: 10,),

                  Obx(() => Text(email.value.toString().split('@').first,
                        style: FontStyle.textBlack.copyWith(fontSize: 18)),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 10,),

            ListTile(
              onTap: () async {
                SharedPreferences preferences = await SharedPreferences.getInstance();
                preferences.remove('isLogin');
                Get.offNamed(AppRoutes.signInScreen);

              },
              leading: const Icon(
                Icons.logout_outlined,color: AppColors.primaryColor,
              ),
              title: const Text(
                "Logout",
                textScaleFactor: 1.2,

              ),
            ),
          ],
        ),
      ),
    );
  }
}