import 'dart:developer';
import 'dart:io';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:officeboy/CommonWidget/textfield.dart';
import '../../CommonWidget/app_colors.dart';
import '../../constData/GlobalVariable/global_varible.dart';
import '../../constData/const.dart';
import '../../models/msg_get_model.dart';



class HomeScreenController extends GetxController {
  List<MsgGetModel> msgGetList = [];
  TextEditingController reasonController = TextEditingController();
  TextEditingController officeReasonController = TextEditingController();
  DatabaseReference ref = FirebaseDatabase.instance.ref('$type/${keyValue.value}');
  DateTime date = DateTime.now();

  @override
  void onInit() {
    super.onInit();
  }

  // -------------------->  Admin Data who send officeBoy to message   <----------------------- //
  Future fetchAdminData() async {
    DatabaseReference ref = FirebaseDatabase.instance.ref(adminTest);
    DatabaseEvent event = await ref.once();
    if(event.snapshot.value == null){
      log('-----event----> ${event.snapshot.value}');
    }
    Map<dynamic, dynamic> data = event.snapshot.value as dynamic;
    List list = data.values.toList();
    log('----list-----> ${list}');
    log('----msgGetList.last.name.toString()-----> ${msgGetList.last.name.toString()}');

    adminFind = list!.where((element) => element['email'] == msgGetList.last.name.toString()).toList();
    log('----adminFind-----> ${adminFind}');
    log('----adminFind-----> ${adminFind.length}');
  }

  Future fetchMsg() async {
    DatabaseReference ref = FirebaseDatabase.instance.ref('$type/${keyValue.value}').child('Messages');
    DatabaseEvent event = await ref.once();
    if(event.snapshot.value == null){
      log('-----event----> ${event.snapshot.value}');
    }
    Map<dynamic, dynamic> data = event.snapshot.value as dynamic;
    List list = data.values.toList();
    // log('----list-----> ${list}');

    adminFind = list!.where((element) => element['message'] == msgGetList.last.message.toString()).toList();
    log('----adminFind-----> ${adminFind}');
    log('----msgGetList.last.message.toString()-----> ${msgGetList.last.message.toString()}');
    // log('----adminFind-----> ${adminFind.length}');

    String msgKey = '';
    for(int i = 0 ; i < adminFind.length ; i++)
      {
        msgKey = adminFind[i]['recordKey'];
      }
    log('----msgKey-----> $msgKey');
    // log('----msgKey-----> ${keyValue.value}');

    // if(msgKey.isNotEmpty)
    //   {
    //     await FirebaseDatabase.instance.ref('$type/${keyValue.value}/Messages').child(msgKey).update({
    //       "isCheck": true,
    //     });
    //   }


  }

  // -------------------->  For add Main Timing of user to table   <----------------------- //
  void updateRecord({required bool isOnline, required String key}) async {
    await FirebaseDatabase.instance.ref('$type/$key').update({
      "is_online": isOnline,
      "last_active": DateTime.now().toString()
    });
    addTime(key: key, isOnline: isOnline);
  }

  void addTime({required String key, required bool isOnline}) async {
    Map<String, String> time = {"": ""};
    if (isOnline == true) {
      time = {
        'InTime': DateFormat("dd-MM-yyyy HH:mm:ss:S").format(DateTime.now()),
        // 'InTime': DateFormat("dd-MM-yyyy hh:mm:ss:S a").format(DateTime.now()),
      };
    } else {
      time = {
        'reason': reasonController.text.toString(),
        'OutTime': DateFormat("dd-MM-yyyy HH:mm:ss:S").format(DateTime.now()),
      };
      reasonController.clear();
    }
    if(DateTime.now().toString() != todayDateFormat)
      {
        await FirebaseDatabase.instance.ref('$type/$key').child('Timing').child(todayDateFormat).push().set(time);
      }
    // await FirebaseDatabase.instance.ref('$type/$key').child('Timing').push().set(time);
  }

  // -------------------->  Office Time DataBase   <----------------------- //
  void updateOfficeTimeRecord({required bool isOnline,required bool isReason, required String key}) async {
    await FirebaseDatabase.instance.ref('$type/$key').update({
      "officeTime": isOnline,
    });
    addTimeForOffice(key: key, isOfficeOnline: isOnline,isReason : isReason);
  }

  void addTimeForOffice({required String key, required bool isOfficeOnline, required bool isReason}) async {
    Map<String, String> time = {"": ""};
    if (isOfficeOnline == true) {
      time = {
        'InTime': DateFormat("dd-MM-yyyy hh:mm:ss:S").format(DateTime.now()),
        // 'InTime': DateFormat("dd-MM-yyyy hh:mm:ss:S a").format(DateTime.now()),
      };
    } else {
      time = {
        'reason': isReason ? '' : officeReasonController.text.toString(),
        'OutTime': DateFormat("dd-MM-yyyy hh:mm:ss:S a").format(DateTime.now()),
      };
      officeReasonController.clear();
    }
    if(DateTime.now().toString() != todayDateFormat)
    {
      await FirebaseDatabase.instance.ref('$type/$key').child('OfficeTime').child(todayDateFormat).push().set(time);
    }
    // await FirebaseDatabase.instance.ref('$type/$key').child('OfficeTime').push().set(time);
  }

  showExitPopup(BuildContext context) {
    return showDialog(
        context: context!,
        barrierDismissible: false,
        builder: (context) {
          return AlertDialog(
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(10.0),
              ),
            ),
            content: SizedBox(
              height: 160.0,
              width: MediaQuery
                  .of(context)
                  .size
                  .width - 50,
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
                            child: Container(
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                color: AppColors.primaryColor,
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: Text(
                                  'Exit',
                                  style: FontStyle.textHeaderWhite.copyWith(
                                      fontSize: 15.0),
                                ),
                              ),
                            )
                        ),
                      ),
                      const SizedBox(width: 15.0,),
                      Expanded(
                        child: GestureDetector(
                            onTap: () {
                              Get.back();
                            },
                            child: Container(
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                  color: AppColors.primaryColor,
                                  borderRadius: BorderRadius.circular(8.0)),
                              child: Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: Text(
                                  'Cancel',
                                  style: FontStyle.textHeaderWhite.copyWith(
                                      fontSize: 15.0),
                                ),
                              ),
                            )
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
}
