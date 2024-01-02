import 'dart:developer';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebasedemo/CommonWidget/textfield.dart';
import 'package:firebasedemo/Screen/HomeScreen/home_screen_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../CommonWidget/app_colors.dart';
import '../../ConstData/Global_Variable/global_variable.dart';
import '../../ConstData/const.dart';
import '../../models/time_model.dart';
import 'user_office_time_controller.dart';
class UserOfficeTime extends StatelessWidget {
   UserOfficeTime({super.key});

   UserOfficeTimeController userOfficeTimeController = Get.put(UserOfficeTimeController());

  @override
  Widget build(BuildContext context) {

    print('----timingKey.value------${timingKey.value}');
    print('----userOfficeTimeController.selectedUserName------${userOfficeTimeController.selectedUserName}');
    return Scaffold(

        appBar: AppBar(
          centerTitle: true,
          title: Text(userOfficeTimeController.selectedUserName.toString(),
          ),
          actions: [
            GetBuilder(
            init: UserOfficeTimeController(),
            builder: (userOfficeTimeController) => Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: GestureDetector(
                      onTap: () {
                        userOfficeTimeController.selectDate(context).then((value) {
                          userOfficeTimeController.update();
                        });
                      },
                      child: const Icon(Icons.date_range,color: AppColors.white_00,size: 25.0,)),
                ),

                // const SizedBox(width: 15.0,),

                // GestureDetector(
                //     onTap: () {
                //       userOfficeTimeController.update();
                //     },
                //     child: const Padding(
                //       padding: EdgeInsets.all(8.0),
                //       child: Icon(Icons.refresh,color: AppColors.white_00,size: 25.0,),
                //     )),

              ],
            ),
          ),],
        ),

        bottomNavigationBar: GetBuilder(
          init: UserOfficeTimeController(),
          builder: (userOfficeTimeController) =>
          userOfficeTimeController.durationTime.isEmpty ?  const SizedBox.shrink() : userOfficeTimeController.time.value.length >= 1 ? Container(
            height: Get.height * 0.08,
            alignment: Alignment.center,
            decoration:  const BoxDecoration(
                color:  AppColors.primaryColor,
                borderRadius:  BorderRadius.only(
                  topLeft: Radius.circular(15.0),
                  topRight: Radius.circular(15.0),
                )
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Total Time  :  ' ,
                  style: FontStyle.buttonBoldWhite,),
                Text(
                  userOfficeTimeController.durationTime.value,
                  style: FontStyle.buttonBoldWhite,),
              ],
            ),
          ) : const SizedBox.shrink() ,
        ),

        body: SafeArea(
              child: SingleChildScrollView(
                child: Column(
                  children: [

                    GetBuilder(
                      init: UserOfficeTimeController(),
                      builder: (userOfficeTimeController) => StreamBuilder(
                        stream: FirebaseDatabase.instance.ref('$typeData/${timingKey.value}/Timing').child(userOfficeTimeController.dayWiseData.value).onValue,

                          builder: (context,AsyncSnapshot<DatabaseEvent> snapshot) {
                          List<TimeModel> timeListData;
                          if(!snapshot.hasData){
                            return const Center(
                              child: CircularProgressIndicator(
                                color: AppColors.primaryColor,
                              ),
                            );
                          } else {
                            if(snapshot.data?.snapshot.value == null){
                              return  Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  GetBuilder(
                                    init: UserOfficeTimeController(),
                                    builder: (userOfficeTimeController) =>

                                    userOfficeTimeController.dayWiseData.value.isNotEmpty ? Padding(padding: const EdgeInsets.only(top: 10, bottom: 10),
                                      child: GestureDetector(
                                        onTap: () {
                                          userOfficeTimeController.selectDate(context);
                                          userOfficeTimeController.update();
                                        },
                                        child: Container(
                                          decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(10),
                                              color: AppColors.primaryColor.withOpacity(0.2)),
                                          padding: const EdgeInsets.all(10),
                                          child: Text(
                                            userOfficeTimeController.dayWiseData.value,
                                            style: FontStyle.textBold.copyWith(fontSize: 15.0),
                                            // timeScreenController.newDate.value,
                                          ),
                                        ),
                                      ),
                                    )
                                        : const SizedBox(),
                                  ),
                                  const Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Center(
                                          heightFactor: 25,
                                          child: Text('No record available',
                                            style: FontStyle.textBlack,)),
                                    ],
                                  ),
                                ],
                              );
                            }
                            Map map = snapshot.data?.snapshot.value as Map;
                            print('----map------> $map');
                            timeListData = map.entries.map((entry) => TimeModel.fromJson({entry.key: entry.value})).toList();

                            timeListData.sort((a, b) {
                              if (a.inTime != '' && b.inTime != '') {
                                return a.inTime!.compareTo(b.inTime.toString());
                              } else if (a.inTime != '' && b.inTime == '' && b.outTime != '') {
                                return a.inTime!.compareTo(b.outTime.toString());
                              } else if (a.inTime == '' && b.inTime != '' && a.outTime != '') {
                                return a.outTime!.compareTo(b.inTime.toString());
                              } else {
                                return a.outTime!.compareTo(b.outTime.toString());
                              }
                            });

                            userOfficeTimeController.time.value.clear();

                            for(int i = 0 ; i < timeListData.length ; i++){
                              if(timeListData[i].inTime!.isNotEmpty){
                                userOfficeTimeController.time.add(timeListData[i].inTime.toString());
                              }
                              if(timeListData[i].outTime!.isNotEmpty){
                                userOfficeTimeController.time.add(timeListData[i].outTime.toString());
                              }
                            }

                            // log('-----userOfficeTimeController.time.first-----> ${userOfficeTimeController.time.first}');
                            // log('-----userOfficeTimeController.time.last-----> ${userOfficeTimeController.time.last}');

                            userOfficeTimeController.timeCalculate(
                                timeList: userOfficeTimeController.time
                            );
                            // userOfficeTimeController.update();
                            // print('-----userOfficeTimeController.time[index]------${userOfficeTimeController.time}');
                          }
                          return Column(
                            children: [


                              GetBuilder(
                                init: UserOfficeTimeController(),
                                builder: (userOfficeTimeController) => userOfficeTimeController.dayWiseData.value.isNotEmpty
                                // timeScreenController.newDate.value.isNotEmpty
                                    ? Padding(
                                  padding: const EdgeInsets.only(
                                      top: 15, bottom: 10),
                                  child: GestureDetector(
                                    onTap: () {
                                      userOfficeTimeController.selectDate(context);
                                      userOfficeTimeController.update();
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(10),
                                          color: AppColors.primaryColor.withOpacity(0.2)),
                                      padding: const EdgeInsets.all(10),
                                      child: Text(
                                        userOfficeTimeController.dayWiseData.value,
                                        style: FontStyle.textBlack.copyWith(fontSize: 15.0),
                                        // timeScreenController.newDate.value,
                                      ),
                                    ),
                                  ),
                                )
                                    : const SizedBox(),
                              ),

                               Padding(
                                padding: const EdgeInsets.only(top: 5.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  children: [
                                    Text('Clock In',style: FontStyle.textBlack.copyWith(
                                        fontSize: 17,
                                        fontFamily: 'SemiBold',
                                        color: AppColors.primaryColor
                                    ),),
                                    Text('Clock Out',style: FontStyle.textBlack.copyWith(
                                        fontSize: 17,
                                        fontFamily: 'SemiBold',
                                        color: AppColors.primaryColor
                                    ),),
                                  ],
                                ),
                              ),

                              GetBuilder(
                                  init: UserOfficeTimeController(),
                                  builder: (userOfficeTimeController) {
                                    return Container(
                                      padding: const EdgeInsets.only(top: 10.0,right: 10.0,left: 10.0,bottom: 10.0),
                                      child: GridView.builder(
                                          shrinkWrap: true,
                                          // reverse: true,
                                          primary: true,physics: const ClampingScrollPhysics(),
                                          scrollDirection: Axis.vertical,
                                          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                            crossAxisCount: 2,
                                            crossAxisSpacing: 10.0,
                                            mainAxisExtent: 50.0,
                                            mainAxisSpacing: 10.0,
                                            childAspectRatio: 3 / 2,
                                          ),
                                          itemCount: timeListData.length,
                                          itemBuilder: (BuildContext ctx, index) {

                                            // if (index == 0 && timeListData.length == 1) {
                                            //   userOfficeTimeController.newDate.value = userOfficeTimeController.groupMessageDateAndTime(userOfficeTimeController.time.first.toString());
                                            //   // userOfficeTimeController.update();
                                            // } else if (index == timeListData.length - 1) {
                                            //   userOfficeTimeController.newDate.value = userOfficeTimeController.groupMessageDateAndTime(userOfficeTimeController.time.first.toString());
                                            // }
                                            // else {
                                            //   final DateTime date = userOfficeTimeController.returnDateAndTimeFormat(userOfficeTimeController.time.first.toString());
                                            //   final DateTime prevDate = userOfficeTimeController.returnDateAndTimeFormat(userOfficeTimeController.time.first.toString());
                                            //   userOfficeTimeController.isSameDate.value = date.isAtSameMomentAs(prevDate);
                                            //   userOfficeTimeController.newDate.value = userOfficeTimeController.isSameDate.value ? '' : userOfficeTimeController.groupMessageDateAndTime(userOfficeTimeController.time.first.toString()).toString();
                                            // }

                                            DateTime parsedDateTime = DateFormat("dd-MM-yyyy HH:mm:ss:SSS").parse(userOfficeTimeController.time[index]);
                                            String outputDateTime = DateFormat("hh:mm:ss a").format(parsedDateTime);

                                            // DateTime parsedDateTime = DateFormat("dd-MM-yyyy hh:mm:ss:SSS a").parse(userOfficeTimeController.time[index]);
                                            // String outputDateTime = DateFormat("hh:mm:ss a").format(parsedDateTime);
                                            return Container(
                                              padding: const EdgeInsets.all(5.0),
                                              alignment: Alignment.center,
                                              decoration: BoxDecoration(
                                                  color: AppColors.primaryColor.withOpacity(0.2),
                                                  borderRadius: BorderRadius.circular(10)),
                                              child: Center(child: Text(outputDateTime,
                                                style: FontStyle.textBlack.copyWith(fontSize: 14.0,color: Colors.black.withOpacity(0.8)),
                                              )),
                                            );
                                          }),
                                    );
                                  },
                                ),

                              ],
                            );
                          }

                      ),
                    ),
                  ],
                ),
              )
      ),
    );
  }
}
