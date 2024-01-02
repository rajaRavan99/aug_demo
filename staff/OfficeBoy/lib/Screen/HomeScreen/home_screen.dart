import 'dart:developer';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:officeboy/CommonWidget/textfield.dart';
import 'package:officeboy/constData/AwesomeNotification/Awesome.dart';
import '../../CommonWidget/app_colors.dart';
import '../../constData/GlobalVariable/global_varible.dart';
import '../../constData/const.dart';
import '../../models/user_data_model.dart';
import '../../models/msg_get_model.dart';
import '../DrawerScreen/drawer_screen.dart';
import 'home_screen_controller.dart';

class HomeScreen extends StatelessWidget {
   HomeScreen({Key? key}) : super(key: key);

   HomeScreenController homePageController =  Get.put(HomeScreenController());

  @override
  Widget build(BuildContext context) {
    // homePageController.update();
    return Scaffold(
      drawer:  MyDrawer(),

      appBar: AppBar(
        centerTitle: true,
        title: GetBuilder(
          init: HomeScreenController(),
          builder: (controller) =>  Obx(() =>  Text(
              email.value.toString().split('@').first ?? 'u',
              style: FontStyle.appBarText.copyWith(fontSize: 15),
            ),
          )
        ),
        backgroundColor: AppColors.primaryColor,
      ),

      body: WillPopScope(
        onWillPop: () {
          homePageController.showExitPopup(context);
          return Future.value(true);
        },
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                    margin: const EdgeInsets.symmetric(vertical: 10,horizontal: 8),
                    child: GetBuilder(
                      init: HomeScreenController(),
                      builder: (homeScreenController) =>  StreamBuilder(
                          stream: homePageController.ref.onValue,
                          builder: (context,AsyncSnapshot<DatabaseEvent> snapshot) {

                            if(snapshot.data?.snapshot.value == null){
                                return const Center(
                                  child: CircularProgressIndicator(
                                    color: AppColors.primaryColor,
                                  ),
                                );
                              }

                              Map<String,dynamic> map = Map<String, dynamic>.from(snapshot.data?.snapshot.value as Map);
                              dataList.clear();
                              dataList.add(UserModel.fromJson(map));

                              return GetBuilder(
                                init: HomeScreenController(),
                                builder: (homePageController) {
                                  return Column(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [

                                      // GestureDetector(
                                      //   onTap: () {
                                      //   },
                                      //   child: Container(
                                      //     height: 100,width: 100,
                                      //     color: Colors.red,
                                      //     child: Text('sd'),
                                      //   ),
                                      // ),
                                      //
                                      // const SizedBox(height: 10,),

                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.center ,
                                        children: [
                                          GestureDetector(
                                            onTap: () {
                                              if(dataList.value[0].isOnline == false){
                                                homePageController.updateRecord(
                                                  isOnline: true,
                                                  key: dataList.value[0].recordId.toString(),
                                                );
                                              } else {
                                                homePageController.updateRecord(
                                                  isOnline: false,
                                                  key: dataList.value[0].recordId.toString(),
                                                );
                                              }
                                              homePageController.updateOfficeTimeRecord(
                                                  key: dataList.value[0].recordId.toString(),
                                                  isReason: true,
                                                  isOnline: false);

                                              Future.delayed(const Duration(seconds: 1)).then((value) => homePageController.update());
                                            },
                                            child: Container(
                                              margin: const EdgeInsets.all(5.0),
                                              alignment: Alignment.center,
                                              decoration: BoxDecoration(
                                                  // color: dataList.value[0].isOnline == true ? Colors.green : Colors.red,
                                                  color: AppColors.white_00.withOpacity(0.9),
                                                  borderRadius: BorderRadius.circular(12.0),
                                                  boxShadow: const [
                                                  BoxShadow(
                                                    blurRadius: 0.0,
                                                    spreadRadius: 0.1,
                                                    offset: Offset(0.0, 0.0)
                                                    ),
                                                  ],
                                              ),
                                              child:  Padding(
                                                padding:  const EdgeInsets.all(10.0),
                                                child:  Row(
                                                  children: [
                                                     Icon(dataList.value[0].isOnline == true ? Icons.logout : Icons.login,size: 22,color: AppColors.primaryColor),

                                                    SizedBox( width: dataList.value[0].isOnline == true ? 2 : 10, ),

                                                    Text(dataList.value[0].isOnline == true ? "Clock Out" : "Clock In",
                                                        style: FontStyle.textBlack.copyWith(fontSize: 15.0,color: AppColors.primaryColor)),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),

                                      const SizedBox(height: 5.0),

                                      GetBuilder(
                                        init: HomeScreenController(),
                                        builder: (homeScreenController) => dataList.value[0].isOnline == true ? Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: dataList.value[0].officeTime == true ? Row(
                                            children: [
                                              Expanded(
                                                child: TextFormField(
                                                  maxLines: 2,
                                                  controller: homePageController.officeReasonController,
                                                  decoration: InputDecoration(
                                                    contentPadding: const EdgeInsets.all(10.0),
                                                    hintText: 'Office Reason',
                                                    hintStyle: FontStyle.textBlack.copyWith(fontSize: 15.0,color: Colors.black.withOpacity(0.5)),
                                                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(12.0))
                                                  ),
                                                  keyboardType: TextInputType.emailAddress,
                                                  textInputAction: TextInputAction.next,
                                                  autovalidateMode: AutovalidateMode.onUserInteraction,
                                                ),
                                              ),

                                              const SizedBox(width: 10,),

                                               GestureDetector(
                                                onTap: () {
                                                  print('-----dataList.value[0].officeTime == true-> ${dataList.value[0].officeTime}');
                                                  if(dataList.value[0].officeTime == false) {
                                                    homePageController.updateOfficeTimeRecord(
                                                        key: dataList.value[0].recordId.toString(),
                                                        isReason: false,
                                                        isOnline: true);
                                                  } else {
                                                    homePageController.updateOfficeTimeRecord(
                                                        key: dataList.value[0].recordId.toString(),
                                                        isReason: false,
                                                        isOnline: false);
                                                  }
                                                },
                                                child: GetBuilder(
                                                  init: HomeScreenController(),
                                                  builder: (homeScreenController) => Container(
                                                    padding: const EdgeInsets.symmetric(horizontal: 8.0,vertical: 12.0),
                                                    alignment: Alignment.center,
                                                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(12.0),
                                                        color: AppColors.primaryColor.withOpacity(0.3)
                                                    ),
                                                    child:  Text(dataList.value[0].officeTime == true ? 'Going Out' : 'In Office' , style:FontStyle.textHeaderWhite.copyWith(fontSize: 15.0),),
                                                  ),
                                                ),
                                              )
                                            ],
                                          ) : GestureDetector(
                                            onTap: () {
                                              if(dataList.value[0].officeTime == false) {
                                                homePageController.updateOfficeTimeRecord(
                                                    key: dataList.value[0].recordId.toString(),
                                                    isReason: false,
                                                    isOnline: true);
                                              } else {
                                                homePageController.updateOfficeTimeRecord(
                                                    key: dataList.value[0].recordId.toString(),
                                                    isReason: false,
                                                    isOnline: false);
                                              }
                                            },
                                            child: GetBuilder(
                                              init: HomeScreenController(),
                                              builder: (homeScreenController) =>  Container(
                                                height: 50.0,
                                                alignment: Alignment.center,
                                                decoration: BoxDecoration(borderRadius: BorderRadius.circular(12.0),
                                                    color: AppColors.primaryColor.withOpacity(0.3)
                                                ),
                                                child:  Padding(
                                                  padding: const EdgeInsets.all(8.0),
                                                  child: Text(dataList.value[0].officeTime == true ? 'Office Out' : 'Office In' , style:FontStyle.textHeaderWhite,)
                                                ),
                                              ),
                                            ),
                                          ),
                                        )  : const SizedBox.shrink(),
                                      ),
                                    ],
                                  );
                                },
                              );
                              // SizedBox();
                            }
                          ),
                        )
                      ),

                    Container(
                      margin: const EdgeInsets.symmetric(vertical: 0,horizontal: 8),
                      child:   StreamBuilder(
                        stream: FirebaseDatabase.instance.ref('$type/${keyValue.value}').child('Messages').onValue,
                        builder: (context,AsyncSnapshot<DatabaseEvent> snapshot) {
                          if(snapshot.data?.snapshot.value == null){
                            return const SizedBox();
                          }

                          // log('----------keyValue.value---------> ${keyValue.value}');
                          Map<String,dynamic> map = Map<String, dynamic>.from(snapshot.data?.snapshot.value as Map);
                          List msgDataList = map.values.toList();
                          homePageController.msgGetList.clear();

                          for(int i = 0 ; i < msgDataList.length; i ++)
                          {
                            homePageController.msgGetList.add(
                                MsgGetModel(
                                    name: msgDataList[i]['name'],
                                    message: msgDataList[i]['message'],
                                    dateTime: msgDataList[i]['dateTime'],
                                    isCheck: msgDataList[i]['isCheck']
                                ),
                            );
                          }

                          // print('-----dataList-------> ${dataList.value[0].isOnline}');

                          homePageController.msgGetList.sort((a, b) => a.dateTime.toString().compareTo(b.dateTime.toString()));

                          return GetBuilder(
                            init: HomeScreenController(),
                            builder: (homePageController) {
                              return homePageController.msgGetList.isEmpty ?  const SizedBox.shrink() : Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                                child: Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Messages ',
                                          style: FontStyle.textLabelRed.copyWith(color: AppColors.black,fontSize: 15.0)),
                                      ],
                                    ),

                                    const SizedBox(
                                      height: 10.0,
                                    ),

                                    GetBuilder(
                                      init: HomeScreenController(),
                                      builder: (homeScreenController) =>  SizedBox(
                                        height:  dataList.value[0].isOnline == true ? Get.height * 0.63 : Get.height * 0.70,
                                        child: homePageController.msgGetList.isEmpty ? const SizedBox.shrink() : ListView.builder(
                                          itemCount: homePageController.msgGetList.length,
                                          shrinkWrap: true,
                                          physics: const ClampingScrollPhysics(),
                                          itemBuilder: (context, index) {
                                            return Container(
                                              margin: const EdgeInsets.symmetric(vertical: 2.0),
                                              decoration: BoxDecoration(borderRadius: BorderRadius.circular(12.0),
                                               border: Border.all(color: AppColors.primaryColor.withOpacity(0.2))) ,
                                              child: Padding(
                                                padding: const EdgeInsets.all(10.0),
                                                child: Row(
                                                  mainAxisAlignment: MainAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      '${homePageController.msgGetList[homePageController.msgGetList.length - 1 - index].name.toString()} : ',
                                                      style: FontStyle.textLabelRed.copyWith(color: AppColors.black,fontSize: 15.0),
                                                    ),
                                                    Expanded(
                                                      child: Text(
                                                        homePageController.msgGetList[homePageController.msgGetList.length - 1 -index].message.toString(),
                                                        style: FontStyle.textBlack,
                                                        overflow: TextOverflow.ellipsis,
                                                      ),
                                                    ),

                                                    // InkWell(
                                                    //   onTap: () {
                                                    //     homePageController.fetchMsg();
                                                    //   },
                                                    //     child: const Padding(
                                                    //       padding: EdgeInsets.symmetric(horizontal: 15.0,vertical: 8.0),
                                                    //       child: Icon(Icons.refresh,color: AppColors.primaryColor,),
                                                    //     ))
                                                  ],
                                                ),
                                              ),
                                            );
                                          },),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                          );
                          // SizedBox();
                        }
                    )
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}


