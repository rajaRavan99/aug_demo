import 'dart:io';
import 'package:call_log/call_log.dart';
import 'package:direct_message/CommonWidget/Utils.dart';
import 'package:direct_message/ConstData/colors.dart';
import 'package:direct_message/Routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import 'package:permission_handler/permission_handler.dart';

class ReadCallLogsScreenController extends GetxController with WidgetsBindingObserver{

  Future<Iterable<CallLogEntry>>? logs;
  BuildContext? buildContext;
  RxList<CallLogEntry> callLogList = RxList();
  RxBool isDataLoad = false.obs;
  RxBool isData = false.obs;
  Iterable<CallLogEntry> call = [];

  @override
  void onInit() {
    permissionHandler();
    WidgetsBinding.instance.addObserver(this);
    super.onInit();
  }

  getTitle(CallLogEntry entry) {
    if (entry.name == null) return entry.number!;
    if (entry.name!.isEmpty) {
      return entry.number!;
    } else {
      return entry.name!;
    }
  }

  getNumber(CallLogEntry entry) {
    if (entry.name == null) return entry.number!;
    if (entry.name!.isEmpty) {
      return entry.number!;
    }else{
      return entry.number!;
    }
  }

  navigatorToHomeScreen() {
    Get.toNamed(AppRoute.homeScreen);
  }

  showExitPopup(){
    return showDialog(
        context: buildContext!,
        barrierDismissible: false,
        builder: (context) {
          return AlertDialog(
            backgroundColor: textfieldfillColor,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(10.0),
              ),
            ),
            content: SizedBox(
              height: 160.0,
              width: MediaQuery.of(context).size.width - 50,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(top: 10.0),
                    child: Text(
                      'Exit App',
                      style: TextStyle(
                        fontFamily: 'Inter-Regular',
                        fontSize: 20.0,
                      ),
                    ),
                  ),
                  const Text(
                    'Are you sure you want to exit?',
                    style: TextStyle(
                        fontFamily: 'Inter-Regular',
                        fontSize: 17.0
                    ),
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            exit(0);
                          },
                          child: Utils().containerButton('Yes',)
                        ),
                      ),
                      const SizedBox(width: 15.0,),
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            Get.back();
                          },
                          child: Utils().containerButton('No',)
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        }
    );
  }

  openDialog(){
    Get.defaultDialog(
      titlePadding: const EdgeInsets.only(top: 10.0),
      title:
      "Permission",
      titleStyle: const TextStyle(
          fontFamily: "Inter-SemiBold",
          fontSize: 17.0
      ),
      radius:5.0,
      contentPadding: const EdgeInsets.symmetric(vertical: 0.0,horizontal: 20.0),
      content:  Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 10.0),
          const Align(
            alignment: Alignment.topLeft,
            child: Text(
              "Require Phone Permission",
              style: TextStyle(
                  fontFamily: "Inter-Regular"
              ),
            ),
          ),
          const SizedBox(height: 10.0),
          const Align(
            alignment: Alignment.topLeft,
            child: Text(
              "Select Permission -> Enable Permission",
              style: TextStyle(
                  fontFamily: "Inter-Regular"
              ),
            ),
          ),
          const SizedBox(height: 10.0),
          Row(
            children: [
              Expanded(
                child: GestureDetector(
                    onTap: () {
                      Get.back();
                    },
                    child: Utils().containerButton("CANCEL")
                ),
              ),
              const SizedBox(width: 15.0,),
              Expanded(
                child: GestureDetector(
                    onTap: () {
                      openAppSettings();
                      Get.back();
                    },
                    child: Utils().containerButton( "SETTINGS")
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Future<Iterable<CallLogEntry>> getCallLogs() async{
    return await CallLog.get();
  }

  String formatDate(DateTime dt) {
    return DateFormat('yyyy-MM-dd hh:mm a').format(dt);
  }

  getData(){
    isDataLoad.value = true;
    logs = getCallLogs();
    logs!.then((value) {
      call = value;
      for (int i = (call.length >= 100 ? 100 : call.length - 1) ; i >= 0; i--) {
        RxBool callListExists = false.obs;
        for (CallLogEntry callList in callLogList) {
          if (callList.number == call.elementAt(i).number && formatDate(DateTime.fromMillisecondsSinceEpoch(callList.timestamp!)) == formatDate(DateTime.fromMillisecondsSinceEpoch(call.elementAt(i).timestamp!),)) {
            callListExists.value = true;
          }
        }
        if (!callListExists.value) {
          callLogList.add(call.elementAt(i));
        }
      }
    }).then((value) {
      isDataLoad.value = false;
      update();
    });
  }

  permissionHandler() async {
    if (await Permission.phone.status.isDenied) {
      var status = await Permission.phone.request();
      if (status.isGranted) {
        await getData();
      } else if(status.isPermanentlyDenied){
        openDialog();
      }
    }
    else if (await Permission.phone.status.isGranted){
      await getData();
    }
  }
  
  @override
  didChangeAppLifecycleState(AppLifecycleState state) async {
    super.didChangeAppLifecycleState(state);
    if(state == AppLifecycleState.resumed) {
      if (await Permission.phone.status.isGranted) {
        getData();
      }
    }
  }
}
