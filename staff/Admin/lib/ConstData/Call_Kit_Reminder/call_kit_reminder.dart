import 'package:flutter_callkit_incoming/entities/android_params.dart';
import 'package:flutter_callkit_incoming/entities/call_kit_params.dart';
import 'package:flutter_callkit_incoming/entities/ios_params.dart';
import 'package:flutter_callkit_incoming/flutter_callkit_incoming.dart';


sendVibrationToUser({required String name,required String msg,}) async {
  CallKitParams params = CallKitParams(
      id: "21232dgfgbcbgb",
      nameCaller: name,
      appName: "Demo",
      avatar: "https://i.pravata.cc/100",
      handle: msg,
      type: 0,
      textAccept: "Accept",
      textDecline: "Decline",
      textMissedCall: "Missed call",
      textCallback: "Call back",
      duration: 30000,
      extra: {'userId':"s"},
      android: const AndroidParams(
          isCustomNotification: true,
          isShowLogo: false,
          isShowCallback: false,
          isShowMissedCallNotification: true,
          ringtonePath: 'system_ringtone_default',
          backgroundColor: "#0955fa",
          backgroundUrl: "https://i.pravata.cc/500",
          actionColor: "#4CAF50",
          incomingCallNotificationChannelName: "Incoming call",
          missedCallNotificationChannelName: "Missed call"
      ),
      ios: IOSParams(
          iconName: "Call Demo",
          handleType: 'generic',
          supportsVideo: true,
          maximumCallGroups: 2,
          maximumCallsPerCallGroup: 1,
          audioSessionMode: 'default',
          audioSessionActive: true,
          audioSessionPreferredSampleRate: 44100.0,
          audioSessionPreferredIOBufferDuration: 0.005,
          supportsDTMF: true,
          supportsHolding: true,
          supportsGrouping: false,
          ringtonePath: 'system_ringtone_default'
      )
  );
  await FlutterCallkitIncoming.showCallkitIncoming(params);
}