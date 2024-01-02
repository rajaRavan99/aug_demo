import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart';

Future<void> sendPushNotification({required String deviceToken, required String user,required String msg}) async {
  try {
    final body = {
      "to": deviceToken,
      "notification": {
        "title": user,
        "body": msg,
        "android_channel_id": "chats",
      },
      // "data": {
      //   "some_data": "User ID: ${'459629982918'}",
      // },
    };
    var res = await post(Uri.parse("https://fcm.googleapis.com/fcm/send"),
        headers: <String,String>{
          'Content-Type': 'application/json',
          'Authorization': 'key=AAAAawQU9MY:APA91bFKVwNKTXePuhYrDIhUTtxEAgD9xNgcMUaR1F3pm60fX1aHgZiVLes4RipwqRV4Q5xIrFfQkoMnkLpzgs1zUEgbYzVesB0By_MHQ1NdSOiBW1j5_-85PuHrllJpTDFoFw21vrkc',
        },
        body: jsonEncode(body));
    log('Response status: ${res.statusCode}');
    log('Response body: ${res.body}');
  } catch (e) {
    log('\nsendPushNotificationE : $e');
  }
}
