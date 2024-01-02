import 'dart:io';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import '../../Screen/HomeScreen/home_screen.dart';
import '../../Screen/Login/SignUp/sign_up_screen.dart';
import '../AwesomeNotification/Awesome.dart';
import '../CallKitReminder/call_kit_reminder.dart';
import '../GetCustomeMessageAddMessageToDatabase/add_to_msg_list_get.dart';

Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
}

Future<void> setupFirebaseNotification() async {
  await flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()?.createNotificationChannel(channel);
  await flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()?.createNotificationChannel(channel);

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
        NotificationController.createNewNotification();
        // sendVibrationToUser(name: value.notification!.title.toString(),msg: '');
        if (kDebugMode) {
          print("-------1--------> ON INITIAL MESSAGE TITLE ==> ${value.notification?.title}");
          print("=====1==> ${value.notification?.body}");
        }
      }
      if (kDebugMode) {
        print("======> 1=======>  $value");
      }
    });

    //when app is opened : -
    FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
      RemoteNotification? notification = message.notification;

      if (notification != null) {
        //when app is opened : -

        // NotificationController.createNewNotification();

        sendVibrationToUser(
            name: message.notification!.title.toString(),
            msg: message.notification!.body.toString());

        addToMsgListGet(
          name: message.notification!.title.toString(),
          message: message.notification!.body.toString(),
        );

        if (kDebugMode) {
          print("---- when app is opened TITLE ==> ${message.notification?.title}");
          print(" =======> when app is opened BODY ==> ${message.notification?.body}");
        }

        String? title;
        String? body;
        if (Platform.isIOS) {
          title = notification.title;
          body = notification.body;
        } else if (Platform.isAndroid) {
          title = message.notification?.title;
          body = message.notification?.body;
          await FirebaseMessaging.instance.requestPermission(
            alert: true,
            announcement: false,
            badge: true,
            carPlay: false,
            criticalAlert: false,
            provisional: true,
            sound: true,
          );

          var androidSettings = const AndroidInitializationSettings('ion_notification');

          var initSetttings = InitializationSettings(android: androidSettings);

          flutterLocalNotificationsPlugin.initialize(initSetttings,
              onDidReceiveNotificationResponse: (payload){
                handleMessage(message);
                print('object------${message.data}');
              });

          flutterLocalNotificationsPlugin.show(
              notification.hashCode,
              notification.title,
              notification.body,
              NotificationDetails(
                android: AndroidNotificationDetails(
                  channel.id,
                  channel.name,
                  channelDescription: channel.description,
                  color: Colors.red,
                  playSound: true,
                  icon: '@drawable/ion_notification',
                ),
              ));
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

    //Handle the background notifications (the app is closed but not termianted)
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      if(message != null)
      {
        // NotificationController.createNewNotification();
        sendVibrationToUser(name: message.notification!.title.toString(),msg: '');
        addToMsgListGet(
            message: message.notification!.body.toString(),
            name: message.notification!.title.toString());

        if (kDebugMode) {
          print('3');
          print("----------3----------> ON MESSAGEOPEN APP TITLE ==> ${message.notification?.title}");
          print("==========> 3 ==> ${message.notification?.body}");
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

    print("TOKEN ==> $token");
    deviceToken.value = token ?? '';
    print('--------deviceToken----------> $deviceToken');

  }).onError((error, stackTrace) {
    print('-------eoror----> $error');
  });
  handleMessageWhileAppIsTerminateAndPause();
}

void handleMessageWhileAppIsTerminateAndPause()async{

  ///app is terminated
  RemoteMessage? initialMessage= await FirebaseMessaging.instance.getInitialMessage();
  if(initialMessage  != null ){
    handleMessage(initialMessage);
  }

  ///app is on background
  FirebaseMessaging.onMessageOpenedApp.listen((event) {
    handleMessage(event);
  });
}

handleMessage(RemoteMessage message) async {
  if(message.data['name'].toString().toLowerCase() == 'user'){
    Get.to( HomeScreen());
  }
}

void requestPermissionss() {
  try {
    flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
        IOSFlutterLocalNotificationsPlugin>()
        ?.requestPermissions(
      alert: true,
      badge: true,
      sound: true,
    )
        .then((value) {
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