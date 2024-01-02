import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'CommonWidget/app_colors.dart';
import 'InternetChecker/internet_chk_controller.dart';
import 'Routes/routes.dart';
import 'constData/AwesomeNotification/Awesome.dart';
import 'constData/GetNotification/get_notification.dart';
import 'constData/sharedPreference/check_user_in_or_not.dart';
import 'constData/sharedPreference/fetch_data.dart';

  bool? userCheck;

  void main() async {
    WidgetsFlutterBinding.ensureInitialized();
    // WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
    // FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
    await NotificationController.initializeLocalNotifications();
    await Firebase.initializeApp();
    await setupFirebaseNotification();

    Singleton.instance.isInternetConnected();
    userCheck = await getLoginUser();
    getSharedPreferenceData().then((value) {
      runApp(const MyApp());
    });
  }

  class MyApp extends StatelessWidget {
    const MyApp({Key? key}) : super(key: key);

      @override
      Widget build(BuildContext context) {
        return GetMaterialApp(
          title: 'Office Boy',
          theme: ThemeData(
              colorScheme: ColorScheme.fromSwatch()
                  .copyWith(primary: AppColors.primaryColor)),
          debugShowCheckedModeBanner: false,
          initialRoute: userCheck == true ? AppRoutes.homeScreen : AppRoutes.signInScreen,
          // initialRoute: userCheck == true ? AppRoutes.notificationPage : AppRoutes.signInScreen,
          getPages: AppRoutes.routeList,
        );
      }
  }



