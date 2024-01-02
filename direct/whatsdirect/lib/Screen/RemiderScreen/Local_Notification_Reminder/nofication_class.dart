import 'dart:developer';

import 'package:direct_message/Routes/routes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

import '../create_reminder_controller.dart';

RxString payload = ''.obs;
class NotificationService{

  int id = 0;

  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
  final AndroidInitializationSettings androidInitializationSettings = const AndroidInitializationSettings('notification');

  Future<void> initialiseNotification() async {

    final NotificationAppLaunchDetails? notificationAppLaunchDetails =
    await flutterLocalNotificationsPlugin.getNotificationAppLaunchDetails();
    payload.value = notificationAppLaunchDetails!.notificationResponse?.payload ?? '';
    print('-------payload-----------> $payload');
    if(payload.value == 'RemindUser')
    {
      navigateToReminderScreenList();
    }

    InitializationSettings initializationSettings = InitializationSettings(
        android: androidInitializationSettings,
        iOS: iosInitializationSettings
    );

    await flutterLocalNotificationsPlugin.initialize(
        initializationSettings,
        onDidReceiveNotificationResponse:(payload){
        if(payload.payload=="RemindUser"){
          navigateToReminderScreenList();
        }
      }
    );
  }


  final DarwinInitializationSettings iosInitializationSettings = DarwinInitializationSettings(
    requestSoundPermission: true,
    requestBadgePermission: true,
    requestAlertPermission: true,
    onDidReceiveLocalNotification: (int? id,String? title,String? body,String? payload,) async {
      CupertinoAlertDialog(
        title: const Text('title'),
        content: const Text('body'),
        actions: [
          CupertinoDialogAction(
            isDefaultAction: true,
            child: const Text('Ok'),
            onPressed: () {
            },
          )
        ],
      );
    },

  );

  void requestIOSPermissions(
      FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin) {
    flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
        IOSFlutterLocalNotificationsPlugin>()
        ?.requestPermissions(
      alert: true,
      badge: true,
      sound: true,
    );
  }

  navigateToReminderScreenList() {
    Get.toNamed(AppRoute.remindUser);
  }

  void permission() async {
    flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation
          <AndroidFlutterLocalNotificationsPlugin>()?.requestPermission();
  }

  //Send Custom Notification :-
  void sendNotification({String? title, String? body}) async {
    AndroidNotificationDetails androidNotificationDetails = const AndroidNotificationDetails(
      'your channel id',
      'your channel name',
      channelDescription: 'your channel description',
      importance: Importance.max,
      playSound: true,
      priority: Priority.high,
      ticker: 'ticker',
    );

    NotificationDetails notificationDetails = NotificationDetails(
        android: androidNotificationDetails,
        iOS: const DarwinNotificationDetails(
            subtitle: 'title',
            presentSound: true,
            presentBadge: true,
            presentAlert: true,
        ),
    );

    await flutterLocalNotificationsPlugin.show(id, title, body, notificationDetails,payload: 'RemindUser');
  }

  //Send Sechdule Notification :-
  void sechduleNotification({
    required int id,required DateTime schedule, String? name,String? address}) async {
    print('Notification Sending');
    tz.initializeTimeZones();

    AndroidNotificationDetails androidNotificationDetails = const AndroidNotificationDetails(
      'your channel id',
      'your channel name',
      channelDescription: 'your channel description',
      importance: Importance.max,
      priority: Priority.high,
      ticker: 'ticker',
      color: Color(0xff007BD0),

    );

    NotificationDetails notificationDetails = NotificationDetails(
      android: androidNotificationDetails,
        iOS: const DarwinNotificationDetails(),
    );

    await flutterLocalNotificationsPlugin.zonedSchedule(
        id,
        name,
        address,
        tz.TZDateTime.from(schedule,tz.local),
        notificationDetails,
        androidAllowWhileIdle: true,
        payload: 'RemindUser',
        matchDateTimeComponents: DateTimeComponents.dateAndTime,
        uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime);
  }

  //Stop Notification:-
  void stopNotificationALl() async {
    log('---------> Stop Notification  ALL<----------');
    // await flutterLocalNotificationsPlugin.cancel(0);
    await flutterLocalNotificationsPlugin.cancelAll();
  }

  //Stop Notification by ID:-
  void stopNotificationId(int id) async {
    log('---------> Stop Notification Deleted<-----${id}-----');
    await flutterLocalNotificationsPlugin.cancel(id);
  }

}