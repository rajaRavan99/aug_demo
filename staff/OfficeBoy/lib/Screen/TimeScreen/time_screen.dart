import 'dart:developer';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:officeboy/CommonWidget/textfield.dart';
import '../../CommonWidget/app_colors.dart';
import '../../constData/GlobalVariable/global_varible.dart';
import '../../constData/const.dart';
import '../HomeScreen/home_screen_controller.dart';
import '../../models/time_model.dart';
import 'time_screen_controller.dart';

class TimeScreen extends StatelessWidget {
   TimeScreen({Key? key}) : super(key: key);

   TimeScreenController timeScreenController =  TimeScreenController();

  @override
  Widget build(BuildContext context) {
    // log('timeScreenController.duration.isEmpty---------->${timeScreenController.duration}');
    // log('timeScreenController.time---------->${timeScreenController.time}');
    // log('timeScreenController.time---------->${timeScreenController.time.length}');

  return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Time Card',
          style: FontStyle.appBarText.copyWith(fontSize: 18),
        ),
        actions: [
          GetBuilder(
            init: TimeScreenController(),
            builder: (timeScreenController) => Row(
              children: [

                Padding(
                  padding: const EdgeInsets.only(right: 15.0),
                  child: GestureDetector(
                      onTap: () {
                        timeScreenController.selectDate(context).then((value) {
                          timeScreenController.update();
                        });
                      },
                      child: const Icon(Icons.date_range,color: AppColors.white_00,size: 25.0,),
                  ),
                ),
                // Padding(
                //   padding: const EdgeInsets.only(right: 15.0),
                //   child: GestureDetector(
                //       onTap: () {
                //         timeScreenController.update();
                //       },
                //       child: const Icon(Icons.refresh,color: AppColors.white_00,size: 25.0),
                //   ),
                // ),
              ],
            ),
          )
        ],
        backgroundColor: AppColors.primaryColor,
      ),
      bottomNavigationBar: GetBuilder(
        init: TimeScreenController(),
        builder: (timeScreenController) {
            return timeScreenController.durationTime.isEmpty ?  const SizedBox.shrink() : timeScreenController.time.value.length <= 1 ? const SizedBox.shrink(): Container(
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
                    timeScreenController.durationTime.value,
                    style: FontStyle.buttonBoldWhite,),
                ],
              ),
            );
        },
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: GetBuilder(
            init: TimeScreenController(),
              builder: (timeScreenController) =>  StreamBuilder(
              stream: FirebaseDatabase.instance.ref('$type/${keyValue.value}/Timing').child(timeScreenController.dayWiseData.value).onValue,
              builder: (context,AsyncSnapshot<DatabaseEvent> snapshot) {
                List<TimeModel> timeListData;
                if (snapshot.data?.snapshot.value == null) {
                  timeScreenController.durationTime.value = '';
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      timeScreenController.formatWithMonthName.value.isNotEmpty
                          ? Padding(
                        padding: const EdgeInsets.only(top: 15, bottom: 0,),
                        child: GestureDetector(
                          onTap: () {
                            timeScreenController.selectDate(context);
                            timeScreenController.update();
                          },
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius:
                                BorderRadius.circular(10),
                                color: AppColors.primaryColor.withOpacity(0.2)),
                            padding: const EdgeInsets.all(10),
                            child: Text(
                              timeScreenController.formatWithMonthName.value,
                              style: FontStyle.textBlack.copyWith(fontSize: 15.0),
                            ),
                          ),
                        ),
                      )
                          : const SizedBox(),
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Center(
                            heightFactor: 30.0,
                            child: Text('No record available',
                              style: FontStyle.textBlack,
                            ),
                          ),
                        ],
                      ),
                    ],
                  );
                }

                Map map = snapshot.data?.snapshot.value as Map;
                print('-----map-----> ${map.values.toList().length}');
                timeListData = map.entries.map((entry) => TimeModel.fromJson({entry.key: entry.value})).toList();
                timeListData.sort((a, b) {
                  if (a.inTime != '' && b.inTime != '') {
                    return a.inTime!.compareTo(b.inTime.toString());
                  } else
                  if (a.inTime != '' && b.inTime == '' && b.outTime != '') {
                    return a.inTime!.compareTo(b.outTime.toString());
                  } else
                  if (a.inTime == '' && b.inTime != '' && a.outTime != '') {
                    return a.outTime!.compareTo(b.inTime.toString());
                  } else {
                    return a.outTime!.compareTo(b.outTime.toString());
                  }
                });

                timeScreenController.time.value.clear();

                for (int i = 0; i < timeListData.length; i++) {
                  if (timeListData[i].inTime!.isNotEmpty) {
                    timeScreenController.time.value.add(timeListData[i].inTime.toString());
                  }
                  if (timeListData[i].outTime!.isNotEmpty) {
                    timeScreenController.time.value.add(timeListData[i].outTime.toString());
                  }
                }

                log('----------->timeScreenController.time.first------------>${timeScreenController.time.first} ');

                log('----------->timeScreenController.time.last------------>${timeScreenController.time.last } ');

                // DateFormat format = DateFormat("h:mm:ss a");
                // var date = format.parse(timeScreenController.time.first.toString());
                // log('----------->12to24------------>${date} ');

                timeScreenController.timeCalculate(
                  timeList: timeScreenController.time                );

                return GetBuilder(
                  init: HomeScreenController(),
                  builder: (homeScreenController) {
                    return Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            timeScreenController.formatWithMonthName.value.isNotEmpty
                              ? Padding(
                                  padding: const EdgeInsets.only(top: 15, bottom: 0,),
                                  child: GestureDetector(
                                    onTap: () {
                                      timeScreenController.selectDate(context);
                                      timeScreenController.update();
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          color: AppColors.primaryColor.withOpacity(0.2)),
                                      padding: const EdgeInsets.all(10),
                                      child: Text(
                                        timeScreenController.formatWithMonthName.value,
                                        style: FontStyle.textBlack.copyWith(fontSize: 15.0),
                                      ),
                                    ),
                                  ),
                                )
                              : const SizedBox(),
                          ],
                        ),

                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Text(
                                'Clock In',
                                style: FontStyle.textBlack.copyWith(
                                    fontSize: 17,
                                    fontFamily: 'SemiBold',
                                    color: AppColors.primaryColor
                                ),
                              ),

                              Text(
                                'Clock Out',
                                style: FontStyle.textBlack.copyWith(
                                    fontSize: 17,
                                    fontFamily: 'SemiBold',
                                    color: AppColors.primaryColor
                                ),
                              ),
                            ],
                          ),
                        ),

                        SizedBox(
                          height: Get.height * 0.69,
                          child: GetBuilder(
                            init: TimeScreenController(),
                            builder: (timeScreenController) =>  GridView.builder(
                                shrinkWrap: true,
                                // reverse: true,
                                primary: true,
                                physics: const ClampingScrollPhysics(),
                                scrollDirection: Axis.vertical,
                                padding: const EdgeInsets.all(10.0),
                                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  crossAxisSpacing: 10.0,
                                  mainAxisExtent: 50.0,
                                  mainAxisSpacing: 10.0,
                                  childAspectRatio: 3 / 2,
                                ),
                                itemCount: timeListData.length,
                                itemBuilder: (BuildContext ctx, index) {

                                  DateTime parsedDateTime = DateFormat("dd-MM-yyyy HH:mm:ss:SSS").parse(timeScreenController.time[index]);
                                  String outputDateTime = DateFormat("hh:mm:ss a").format(parsedDateTime);

                                  return Container(
                                    padding: const EdgeInsets.all(15.0),
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                      color: AppColors.primaryColor.withOpacity(0.2),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Center(
                                        child: Text(outputDateTime,
                                          style: FontStyle.textBlack.copyWith(fontSize: 14.0,color: Colors.black.withOpacity(0.8)),
                                        )
                                    ),
                                  );
                                },
                              ),
                          ),
                        ),
                      ],
                    );
                  },
                );
              }
            ),
          ),
        ),
      ),
    );
  }
}

///cloud dataFetch
// Container(
// margin: const EdgeInsets.symmetric(vertical: 10,horizontal: 8),
// child: StreamBuilder(
// // stream: FirebaseFirestore.instance.collection("UsersData").doc(modelList[0].uId).collection('Timing').snapshots(),
// stream: FirebaseDatabase.instance.ref('users').onValue,
// builder: (context, snapshot) {
// List<Map<String, dynamic>?>? cloudUserList = snapshot.data?.docs.map((e) => e.data()).toList();
// List<TimeModel> timeList = [];
//
//
//
// for(int i = 0;i < cloudUserList!.length;i++)
// {
// timeList.add(
// TimeModel(
// inTime: cloudUserList[i]!['InTime'],
// outTime: cloudUserList[i]!['OutTime']
// ),
// );
// }
//
// print('-----timelist----> ${timeList.length}');
//
// ///////////////////////////////////////////////////////////////////////
// return ListView.builder(
// itemCount: timeList.length,
// shrinkWrap: true,
// itemBuilder: (context, index) {
// String inTime = DateFormat("yyyy-MM-dd hh:MM:ss").format(DateTime.parse(timeList[index].inTime.toString()));
// String outTime = DateFormat("yyyy-MM-dd hh:MM:ss").format(DateTime.parse(timeList[index].outTime.toString()));
// return  timeList.isNotEmpty ? Padding(
// padding: const EdgeInsets.all(8.0),
// child: Column(
// crossAxisAlignment: CrossAxisAlignment.start,
// children: [
// Text('InTime :- $inTime',style: const TextStyle(color: Colors.black,fontSize: 15.0),),
// Text('OutTime :- $outTime',style: const TextStyle(color: Colors.black,fontSize: 15.0),),
//
// ],
// ),
// ) : const Center(child: CircularProgressIndicator(color: Colors.black,));
// },
// );
// },
// ),
// ),