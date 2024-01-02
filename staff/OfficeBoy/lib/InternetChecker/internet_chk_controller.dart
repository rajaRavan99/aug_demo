import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../constData/Toast/toast.dart';
import '../constData/const.dart';


class Singleton extends GetxController {
  Singleton._privateConstructor();

  static final Singleton _instance = Singleton._privateConstructor();

  static Singleton get instance => _instance;

  // Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  final ConnectivityResult connectivityResult = ConnectivityResult.none;
  final Connectivity connectivity = Connectivity();

  late final StreamSubscription<ConnectivityResult> streamSubscription;

  @override
  void onInit() {
    isInternetConnected();
    super.onInit();
  }

  void showBottomSheet(BuildContext context, Widget childWidget) {
    showModalBottomSheet<dynamic>(
      isScrollControlled: true,
      // material: MaterialModalSheetData(
      //   useRootNavigator: true,
      //   isScrollControlled: true,
      // ),
      // cupertino: CupertinoModalSheetData(
      //   useRootNavigator: true,
      //   barrierDismissible: false,
      // ),
      context: context,
      builder: (BuildContext bc) {
        return Padding(
          padding: MediaQuery.of(context).viewInsets,
          child: Wrap(children: <Widget>[
            Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(25.0),
                  topRight: Radius.circular(25.0),
                ),
              ),
              child: childWidget,
            )
          ]),
        );
      },
    );
  }

  Future isInternetConnected() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    streamSubscription = connectivity.onConnectivityChanged.listen((result) {
      if (result == ConnectivityResult.mobile) {
        flutterToast(msg: 'Device connected with mobile');
      } else if (connectivityResult == ConnectivityResult.wifi) {
        flutterToast(msg: 'Device connected with wifi');
      } else if (connectivityResult == ConnectivityResult.none) {
        flutterToast(msg: 'No internet');
      }
    });

  }

  void hideKeyboard(BuildContext context) {
    FocusScopeNode currentFocus = FocusScope.of(context);
    if (!currentFocus.hasPrimaryFocus && currentFocus.focusedChild != null) {
      FocusManager.instance.primaryFocus?.unfocus();
    }
  }
}