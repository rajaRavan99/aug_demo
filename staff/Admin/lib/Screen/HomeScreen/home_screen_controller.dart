import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebasedemo/CommonWidget/app_colors.dart';
import 'package:firebasedemo/CommonWidget/textfield.dart';
import 'package:firebasedemo/models/msg_model.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebasedemo/CommonWidget/Utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../ConstData/Global_Variable/global_variable.dart';
import '../../ConstData/SqfliteHelper/sqlhelper_msg.dart';
import '../../ConstData/const.dart';
import '../../models/UsersModel.dart';
import '../../models/msg_get_model.dart';


class HomePageController extends GetxController {
  final popupKey = GlobalKey<FormState>();
  TextEditingController titleController = TextEditingController();
  DatabaseReference ref = FirebaseDatabase.instance.ref(typeData);
  RxString selectedValue = ''.obs;
  RxInt selectedUserIndex = 0.obs;
  RxList<String> dropdownList = RxList();

  @override
  void onInit() {
    getUserData();
    getAllStaticMessageList();
    super.onInit();
  }

  List adminFind = [];
  List<MsgGetModel> msgGetList = [];

  Future fetchMsg() async {
    // log('----msgGetList.length-----> ${msgGetList.length}');
    // // log('----timingKey.value-----> ${timingKey.value}');
    //
    // DatabaseReference ref = FirebaseDatabase.instance.ref('$typeData/${timingKey.value}').child('Messages');
    // DatabaseEvent event = await ref.once();
    // if(event.snapshot.value == null){
    //   log('-----event----> ${event.snapshot.value}');
    // }
    // Map<dynamic, dynamic> data = event.snapshot.value as dynamic;
    // List list = data.values.toList();
    // log('----list-----> ${list}');
    // log('----last-----> ${msgGetList.last.message.toString()}');
    //
    // adminFind = list!.where((element) => element['message'] == msgGetList.last.message.toString()).toList();
    // String msgRecordId = adminFind.last['recordKey'];
    // log('----msgRecordId-----> ${msgRecordId}');
    // if(adminFind.last['isCheck'] == false)
    //   {
    //     await FirebaseDatabase.instance.ref('$typeData/${timingKey.value}/Messages').child(msgRecordId).update({
    //       "isCheck": true,
    //     });
    //   }
  }

  getUserData() async {
    final snapshot = await FirebaseDatabase.instance.ref(typeData).get();
    RxList<dynamic> dataList = RxList();
    Map<dynamic, dynamic> values = snapshot.value as Map;
    dataList.value = values.values.toList();
    dropdownList.clear();
    for(int i=0;i<dataList.length;i++){
      userList.value.add(
        UserModel(
          email: dataList[i]['email'],
          uId: dataList[i]['recordID'],
          isOnline: dataList[i]['is_online'],
          name: dataList[i]['name'],
          deviceToken: dataList[i]['deviceToken'],
          recordId: dataList[i]['recordID']
        ),
      );
      dropdownList.value.add(
          dataList[i]['email'].toString()
      );
    }
    update();
  }

  // -------------------->  For get multiple Token of one single user   <----------------------- //
  Future<List> fetchUserCloud({required String email}) async {
    List<dynamic> tokenListPush = [];
    QuerySnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore.instance.collection("deviceToken").where('email', isEqualTo: email).get();
    final List<QueryDocumentSnapshot<Object?>> documents = snapshot.docs;
    final Map<String, dynamic> dataMap = {};

    for (final doc in documents) {
      final Object? documentData = doc.data();
      final String documentId = doc.id;
      dataMap[documentId] = documentData;
    }
    tokenListPush = dataMap.values.toList();
    print('-------------> tokenListPush ${tokenListPush.length}');
    return tokenListPush;
  }

  // -------------------->  Custom Message List Get   <----------------------- //
  getAllStaticMessageList() async {
    print('msgData.value-}');
    Future.delayed(const Duration(seconds: 1)).then((value) async {
      msgDataList.value.clear();
      await SqlDatabaseHelper.instance.queryAllRow().then((value) {
        msgDataList.value = value;
        update();
      });
    });
    print('msgData.value----${msgDataList.length}');
  }

  // -------------------->  Add to Custom Message List <----------------------- //
  showAddDataDialog(BuildContext context) {
    // set up the buttons
    Widget cancelButton = TextButton(
      child: const Text("Cancel"),
      onPressed:  () {
        Get.back();
      },
    );
    Widget continueButton = TextButton(
      child: Text("Continue"),
      onPressed:  () {
        if(popupKey.currentState!.validate())
          {
            addMsgToList(message: titleController.text.toString());
            titleController.clear();
            Get.back();
          }
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
      title: const Text("Add Message",style: FontStyle.textBold,),
      content: Form(
        key: popupKey,
        child: TextFormField(
          controller: titleController,
          decoration: Utils.inputDecoration('Message'),
          keyboardType: TextInputType.emailAddress,
          textInputAction: TextInputAction.next,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          validator: (value) {
            if (value!.isEmpty) {
              return "Message can not be empty";
            }
            return null;
          },
        ),
      ),
      actions: [
        cancelButton,
        continueButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  // -------------------->  Exist Confirmation Popup <----------------------- //
  showExitPopup(BuildContext context){
    return showDialog(
        context: context,
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
                                style: FontStyle.textHeaderWhite.copyWith(fontSize: 15.0),
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
                                  style: FontStyle.textHeaderWhite.copyWith(fontSize: 15.0),
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

  // -------------------->  Add Message to list <----------------------- //
  addMsgToList({required String message}) async {
    MsgData firstMsg = MsgData(title: message,subtitle: '', isSelected: 0);
    List<MsgData> listOfUsers = [firstMsg];
    await SqlDatabaseHelper.instance.customInsert(listOfUsers);
    getAllStaticMessageList();
    update();
    print('-----addMsgToListmsgData--> ${msgDataList.length}');
  }
}



