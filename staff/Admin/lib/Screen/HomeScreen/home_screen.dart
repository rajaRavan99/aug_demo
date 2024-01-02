import 'dart:developer';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebasedemo/CommonWidget/dropDown.dart';
import 'package:firebasedemo/CommonWidget/textfield.dart';
import 'package:firebasedemo/Extension/extension.dart';
import 'package:firebasedemo/Routes/routes.dart';
import 'package:firebasedemo/models/time_model.dart';
  import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../CommonWidget/app_colors.dart';
import '../../ConstData/Global_Variable/global_variable.dart';
import '../../ConstData/PushNotification/pushNotification.dart';
import '../../ConstData/SqfliteHelper/sqlhelper_msg.dart';
import '../../ConstData/Toast/toast.dart';
import '../../ConstData/const.dart';
import '../../models/UsersModel.dart';
import '../../models/msg_get_model.dart';
import '../DrawerScreen/drawer_screen.dart';
import 'home_screen_controller.dart';

class HomeScreen extends StatelessWidget {
   HomeScreen({Key? key}) : super(key: key);

  HomePageController homePageController =  Get.put(HomePageController());
   final GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      key: scaffoldKey,
      drawer:  MyDrawer(),

      appBar: AppBar(
        toolbarHeight: 120,
        centerTitle: true,
        title: GetBuilder(
        init: HomePageController(),
        builder: (homePageController) => myDropDown(
          hint: 'Select User',
          dropDowns: homePageController.dropdownList.value,
          selectedValue: homePageController.selectedValue,
          onChanged: (v){
            homePageController.selectedValue.value = v;
            for(int index = 0 ; index < userList.value.length ; index++) {
              if(homePageController.selectedValue.value == userList.value[index].email.toString()){
                anotherList.add(
                  UserModel(
                    isOnline: userList.value[index].isOnline,
                    deviceToken: userList.value[index].deviceToken,
                    name:userList.value[index].name,
                    email: userList.value[index].email,
                  )
                );
                timingKey.value = userList.value[index].recordId.toString();
                homePageController.selectedUserIndex.value = index;
              }
            }
            print('------timingKey-------> ${timingKey.value}');

            homePageController.fetchMsg();
            homePageController.update();
          },
        )),
        
        leading: GestureDetector(
            onTap: () {
              scaffoldKey.currentState?.openDrawer();
              // MyDrawer();
            },
            child: const Icon(Icons.menu,size: 30,)),
      ),

      body: WillPopScope(
        onWillPop: () {
          homePageController.showExitPopup(context);
          return Future.value(true);
        },
        child: homePageController.ref.onValue == Null ? const Text('No User available') : SafeArea(
          child: SingleChildScrollView(
            child: GestureDetector(
              onTap: () {
                FocusManager.instance.primaryFocus?.unfocus();
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children:  [
                    const SizedBox(height: 10.0,),
                    /*GetBuilder(
                      init: HomePageController(),
                      builder: (homePageController) =>  homePageController.selectedValue.value == '' ? const SizedBox() : Container(
                        alignment: Alignment.center,
                        margin: const EdgeInsets.all(10.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12.0),
                          border: Border.all(color: AppColors.primaryColor.withOpacity(0.2)),
                          color: AppColors.white_00,
                        ),
                        padding: const EdgeInsets.all(5.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(left: 8.0),
                                      child: Text(
                                        'Status :',
                                        style: FontStyle.textBlack.copyWith(),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 8.0),
                                      child: Text(
                                        userList.value[homePageController.selectedUserIndex.value].isOnline == true ? 'Available' : 'Not Available',
                                        style: FontStyle.textBlack.copyWith(color: userList.value[homePageController.selectedUserIndex.value].isOnline == true ? AppColors.green_00 : AppColors.red_00),
                                      ),
                                    ),
                                  ],
                                ),

                                InkWell(
                                  onTap: () {
                                    Get.deleteAndPut<String>(userList.value[homePageController.selectedUserIndex.value].name.toString() , tag: "SelectedUserName");
                                    Get.toNamed(AppRoutes.userOfficeTime);
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                        color: AppColors.primaryColor.withOpacity(0.2),
                                        borderRadius: BorderRadius.circular(12.0)
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text('Timing',style: FontStyle.textBold.copyWith(fontSize: 12)),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),*/
                    // Main Stream :-
                    StreamBuilder(
                      stream: homePageController.ref.onValue,
                      builder: (context,AsyncSnapshot<DatabaseEvent> snapshot) {
                        if(!snapshot.hasData){
                          return const SizedBox.shrink();
                        } else {
                          if(snapshot.data?.snapshot.value == null){
                            return const Center(child: Text('No User available'));
                          }
                          homePageController.getUserData();
                          Map<dynamic,dynamic> map = snapshot.data?.snapshot.value as Map;
                          RxList<dynamic> dataList = RxList();
                          dataList.value = map.values.toList();
                          userList.value.clear();
                          // homePageController.selectedValue.value = '';
                          homePageController.dropdownList.clear();
                          // homePageController.update();
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

                            // homePageController.selectedValue = ''.obs;
                            homePageController.dropdownList.value.add(dataList[i]['email'].toString());
                          }

                          // homePageController.update();
                          for (int index = 0 ; index < userList.value.length ; index++){
                            if(homePageController.selectedValue.value == userList.value[index].email.toString()){
                              homePageController.selectedUserIndex.value = index;
                            }
                          }
                          // print('-----email-----> ${userList.value[homePageController.selectedUserIndex.value].email}');
                          // print('-----homePageController.selectedValue.value-----> ${homePageController.selectedValue.value}');
                          return GetBuilder(
                            init: HomePageController(),
                            builder: (homePageController) =>  homePageController.selectedValue.value == '' ? const SizedBox() : Container(
                              alignment: Alignment.center,
                              margin: const EdgeInsets.all(10.0),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12.0),
                                border: Border.all(color: AppColors.primaryColor.withOpacity(0.2)),
                                color: AppColors.white_00,
                              ),
                              padding: const EdgeInsets.all(5.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: [
                                          const Padding(
                                            padding: EdgeInsets.only(left: 8.0),
                                            child: Text(
                                              'Status :',
                                              style: FontStyle.textBlack,
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(left: 8.0),
                                            child: Text(
                                              userList.value[homePageController.selectedUserIndex.value].isOnline == true ? 'Available' : 'Not Available',
                                              style: FontStyle.textBlack.copyWith(color: userList.value[homePageController.selectedUserIndex.value].isOnline == true ? AppColors.green_00 : AppColors.red_00),
                                            ),
                                          ),
                                        ],
                                      ),

                                      InkWell(
                                        onTap: () {
                                          Get.deleteAndPut<String>(userList.value[homePageController.selectedUserIndex.value].name.toString() , tag: "SelectedUserName");
                                          Get.toNamed(AppRoutes.userOfficeTime);
                                        },
                                        child: Container(
                                          decoration: BoxDecoration(
                                              color: AppColors.primaryColor.withOpacity(0.2),
                                              borderRadius: BorderRadius.circular(12.0)
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text('Timing',style: FontStyle.textBold.copyWith(fontSize: 12)),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              ),
                          );
                          }
                        }
                      ),
                    //for last reason Stream Builder :-
                    GetBuilder(
                      init: HomePageController(),
                      builder: (homePageController) =>
                      userList.isEmpty ? const SizedBox() : userList.value[homePageController.selectedUserIndex.value].isOnline == true ?
                      StreamBuilder(
                        stream: FirebaseDatabase.instance.ref().child('$typeData/${timingKey.value}/OfficeTime').child(todayDateFormat).limitToLast(5).onValue,
                        // stream: FirebaseDatabase.instance.ref().child('$typeData/${timingKey.value}/Timing').limitToLast(5).onValue,
                        builder: (context,AsyncSnapshot<DatabaseEvent> snapshot) {
                            if(!snapshot.hasData){
                              return const SizedBox.shrink();
                            } else {
                              if(homePageController.selectedValue.isEmpty)
                                {
                                  return  const Center(
                                      child: SizedBox.shrink()
                                  );
                                } else if(snapshot.data?.snapshot.value == null){
                                  return  const Center(
                                      child: SizedBox.shrink()
                                  );
                              } else {
                                Map<dynamic,dynamic> map = snapshot.data?.snapshot.value as dynamic;
                                // log('map-------------$map');
                                print('map.values.toList-------------${map.values.toList()}');
                                RxList<dynamic> dataTimeList = [].obs;
                                dataTimeList.value.clear();
                                dataTimeList.value = map.values.toList();

                                RxList<TimeModel> timeList = RxList();
                                timeList.clear();

                                for(int i = 0; i < dataTimeList.length;i++){
                                  // print('last-------------${dataTimeList[i]['reason']}');
                                  timeList.value.add(
                                    TimeModel(
                                      inTime: dataTimeList[i]['InTime'] ?? '',
                                      outTime: dataTimeList[i]['OutTime'] ?? '',
                                      reason:dataTimeList[i]['reason'] ?? '',
                                    ),
                                  );
                                }

                                timeList.value.sort((a, b) {
                                  if (a.inTime != '' && b.inTime != '') {
                                    return a.inTime!.compareTo(b.inTime.toString());
                                  }
                                  else {
                                    return a.outTime!.compareTo(b.outTime.toString());
                                  }
                                });

                                log('timeList.value.last.reason.toString()------------------${timeList.value.last.reason.toString()}');

                                return timeList.value.last.reason!.isEmpty ? const SizedBox.shrink():
                                Padding(
                                  padding: const EdgeInsets.only(left: 10.0,bottom: 2.0),
                                  child: RichText(
                                      text:  TextSpan(
                                      text: 'Reason : ',
                                          style: FontStyle.textLabelRed.copyWith(color: AppColors.black,fontSize: 15.0),
                                          children: [
                                          TextSpan(
                                            text: timeList.value.last.reason.toString(),
                                            style: FontStyle.textBlack.copyWith(),
                                          ),
                                        ]

                                  )),
                                );
                              }
                            }
                          }
                      )
                          :const SizedBox.shrink(),
                    ),
                    // : const SizedBox.shrink(),

                    //Custom Message start
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12.0,vertical: 2.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children:  [
                           Text(
                            'Messages',
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                            style: FontStyle.textLabelRed.copyWith(color: AppColors.black,fontSize: 15.0),
                          ),

                        GestureDetector(
                            onTap: () {
                              homePageController.showAddDataDialog(context);
                            },
                            child: Container(
                              padding: const EdgeInsets.all(2.0),
                              decoration: BoxDecoration(borderRadius: BorderRadius.circular(5.0),color: AppColors.primaryColor),
                              child: const Icon(
                                Icons.add,
                                color: Colors.white,
                                size: 25,
                              ),
                            )
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 5.0,),

                    GetBuilder(
                      init: HomePageController(),
                      builder: (homePageController) {
                      return  msgDataList.isEmpty ? SizedBox(
                        height: Get.height * 0.60,
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CircularProgressIndicator(color: AppColors.primaryColor,),
                          ],
                        ),
                      ): Obx(() => ListView.builder(
                        shrinkWrap: true,
                        physics: const ClampingScrollPhysics(),
                        itemCount: msgDataList.value.length ,
                        itemBuilder: (context, index) {
                          return msgDataList.value.isNotEmpty ? GestureDetector(
                            onTap: () async {
                              print('----deviceToken--${userList.value[homePageController.selectedUserIndex.value].deviceToken.toString()}');
                              if(homePageController.selectedValue.isNotEmpty){
                                if(userList.value[homePageController.selectedUserIndex.value].isOnline == true) {
                                  List<dynamic> tokenList = await homePageController.fetchUserCloud(email: homePageController.selectedValue.value);
                                  print('-------list---> ${tokenList

                                      .length}');
                                  // print('-------list---> ${list}');

                                  // flutterToast(msg: '${msgData[index].title.toString()} Selected');
                                  for(int i  = 0 ; i < tokenList.length; i++) {
                                    sendPushNotification(
                                      deviceToken: tokenList[i]['deviceToken'].toString(),
                                      user: email.value.isNotEmpty ? email.toString() : email.value.toString(),
                                      msg: msgDataList[index].title.toString(),
                                    );
                                  }
                                  homePageController.msgGetList.add(
                                    MsgGetModel(
                                      name: tokenList[index]['email'],
                                      message: msgDataList[index].title.toString(),
                                    ),
                                  );
                                  print('-------msgGetList---> ${homePageController.msgGetList.length}');
                                  flutterToast(msg: '${msgDataList[index].title.toString() } Sent to ${homePageController.selectedValue.value}');
                                  tokenList.clear();
                                } else {
                                  flutterToast(msg: 'User not active');
                                }
                              } else {
                                flutterToast(msg: 'Please select user ');
                              }

                            },
                            child: Container(
                              margin: const EdgeInsets.symmetric(vertical: 5.0,horizontal: 8.0),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                border: Border.all(
                                    width: 0.2,
                                    color: AppColors.primaryColor
                                ),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                        msgDataList[index].title,
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 1,
                                        style: FontStyle.textBlack),

                                    GestureDetector(
                                        onTap: () {
                                          SqlDatabaseHelper.instance.delete(msgDataList[index].id ?? 0);
                                          msgDataList.removeAt(index);
                                          homePageController.update();
                                          // flutterToast(msg: 'Delete');
                                        },
                                        child: const Icon(Icons.delete,color: Colors.black,size: 25,))
                                  ],
                                ),
                              ),
                            ),
                          ) : const Center(child: Text('No Message Available'));
                        },
                      ));
                    },),

                    // ------------------------> Sended Data get :- ------------------------------>

                    // GetBuilder(
                    //   init: HomePageController(),
                    //   builder: (homePageController) =>
                    //     homePageController.selectedValue.isEmpty ? const SizedBox.shrink() : StreamBuilder(
                    //         stream: FirebaseDatabase.instance.ref('TestUsers/${timingKey.value}').child('Messages').onValue,
                    //
                    //         builder: (context,AsyncSnapshot<DatabaseEvent> snapshot) {
                    //         if(!snapshot.hasData){
                    //           return const SizedBox.shrink();
                    //         } else {
                    //           if(homePageController.selectedValue.isEmpty)
                    //           {
                    //             return  const Center(
                    //                 child: SizedBox.shrink()
                    //             );
                    //           } else if(snapshot.data?.snapshot.value == null){
                    //             return  const Center(
                    //                 child: SizedBox.shrink()
                    //             );
                    //           } else {
                    //             log('----------timingKey.value---------> ${timingKey.value}');
                    //             Map<dynamic, dynamic> data = snapshot.data?.snapshot.value as dynamic;
                    //             List list = data.values.toList();
                    //             // log('----list-----> ${list}');
                    //             // log('----list-----> ${list.last['message']}');
                    //             // log('----homePageController.msgGetList-----> ${homePageController.msgGetList.length}');
                    //             log('----last-----> ${homePageController.msgGetList.last.message.toString()}');
                    //
                    //             // List adminFind = [];
                    //             // adminFind = list.where((element) => element.last['message'] == homePageController.msgGetList.last.message.toString()).toList();
                    //             //
                    //             // String msgRecordId = adminFind.last['recordKey'];
                    //             // log('----adminFind-----> $adminFind');
                    //             // log('----msgRecordId-----> $msgRecordId');
                    //             // log('----adminFind-----> $adminFind');
                    //             // if(adminFind.last['isCheck'] == true)
                    //             // {
                    //             //   //  FirebaseDatabase.instance.ref('$typeData/${timingKey.value}/Messages').child(msgRecordId).update({
                    //             //   //   "isCheck": true,
                    //             //   // });
                    //             //   flutterToast(msg: 'Last message seen by user');
                    //             // }
                    //             return const SizedBox.shrink();
                    //           }
                    //         }
                    //       }
                    //   ),
                    // ),



                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

