import 'dart:io';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import '../../Screen/Login/SignUp/sign_up_screen.dart';

Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
}

Future<void> setupFirebaseNotification() async {
  await flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()?.createNotificationChannel(channel);
  // await flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()?.createNotificationChannel(channel);
  FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);
  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true,
  );

  try {
    if (defaultTargetPlatform == TargetPlatform.iOS) {
      requestPermissionss();
    }

    //Handle the background notifications (the app is termianted)
    FirebaseMessaging.instance.getInitialMessage().then((value) {
      if (value != null) {
        // sendVibrationToUser(name: '',msg: '');
        if (kDebugMode) {
          print("-------1--------> ON INITIAL MESSAGE TITLE ==> ${value.notification?.title}");
          print("ON INITIAL MESSAGE BODY==> ${value.notification?.body}");
        }
      }
      if (kDebugMode) {
        print("messages handleed in background $value");
      }
    });

    //Handle the notification if the app is in Foreground(opened)
    FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
      RemoteNotification? notification = message.notification;

      if (notification != null) {
        //when app is opened :-
        // sendVibrationToUser(name: message.notification!.title.toString(), msg: message.notification!.body.toString());
        if (kDebugMode) {
          print("---- ON ANDROID FOREGROUND MESSAGE TITLE ==> ${message.notification?.title}");
          print("ON ANDROID FOREGROUND MESSAGE BODY ==> ${message.notification?.body}");
        }

        String? title;
        String? body;
        if (Platform.isIOS) {
          title = notification.title;
          body = notification.body;
        } else if (Platform.isAndroid) {
          title = message.notification?.title;
          body = message.notification?.body;
        }

        if (kDebugMode) {
          print(title);
        }
        if (kDebugMode) {
          print(body);
        }
        //
      } else {
        if (kDebugMode) {
          print("data not available");
        }
      }
    });

    FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(alert: true, badge: true, sound: true);

    //Handle the background notifications (the app is closed but not terminated)
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      if(message != null)
      {
        if (kDebugMode) {
          print('A new onMessageOpenedApp event was published!');
          print("----------3----------> ON MESSAGEOPEN APP TITLE ==> ${message.notification?.title}");
          print("ON MESSAGEOPEN APP BODY ==> ${message.notification?.body}");
        }
      }
    });
  } on PlatformException catch (e) {
    if (kDebugMode) {
      print("message------ PlatformException $e");
    }
  } catch (e) {
    if (kDebugMode) {
      print("message------ Exception $e");
    }
  }

  _firebaseMessaging.getToken().then((token) {
    // if (kDebugMode) {
    print("TOKEN ==> $token");
    deviceToken.value = token ?? '';
    print('--------deviceToken----------> $deviceToken');
    // }
  });
}

void requestPermissionss() {
  try {
    flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<IOSFlutterLocalNotificationsPlugin>()?.requestPermissions(
      alert: true,
      badge: true,
      sound: true,
    ).then((value) {
      if (value!) {
        print("Please allow permission from settings");
      }
    });
  } catch (e) {
    if (kDebugMode) {
      print("===exception$e");
    }
  }
}

final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
bool permissionAllowed = false;
AndroidNotificationChannel channel = const AndroidNotificationChannel(
    '1',
    'tellme_build',
    importance: Importance.high,
    playSound: true,
    enableVibration: true,
    enableLights: true,
    ledColor: Colors.blue,
    showBadge: true
);