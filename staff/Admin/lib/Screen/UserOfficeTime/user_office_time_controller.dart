import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class UserOfficeTimeController extends GetxController{
  RxList<String> time = RxList();
  String duration = '';
  RxString durationTime = ''.obs;
  RxBool isSameDate = false.obs;
  RxString newDate = ''.obs;
  String selectedUserName = Get.find<String>(tag: "SelectedUserName");
  RxString dayWiseData = DateFormat('dd-MM-yyyy').format(DateTime.parse(DateTime.now().toString())).obs;


  @override
  void onInit() {
    print('----->$selectedUserName');
    super.onInit();
  }

  // -------------------->  For Day lable  <----------------------- //
  DateTime returnDateAndTimeFormat(String time){
    // log('-----returnDateAndTimeFormat-----> ${time}');
    DateTime tempDate = DateFormat("dd-MM-yyyy").parse(time);
    var newDate = DateTime(tempDate.year, tempDate.month , tempDate.day);
    // update();
    return newDate;
  }

  // -------------------->  For Day lable  <----------------------- //
  groupMessageDateAndTime(String time){
    // log('-----groupMessageDateAndTime-----> ${time}');

    DateTime tempDate = DateFormat("dd-MM-yyyy").parse(time);
    final todayDate = DateTime.now();
    final today = DateTime(todayDate.year,todayDate.month,todayDate.day);
    final yesterday=DateTime(todayDate.year,todayDate.month,todayDate.day-1);
    RxString difference =''.obs;
    final aDate = DateTime(tempDate.year, tempDate.month, tempDate.day);
    if(aDate==today){
      difference="Today".obs;
      // update();
    }
    else if(
    aDate==yesterday
    ){
      difference="Yesterday".obs;
      // update();
    }
    else{
      difference.value = DateFormat.yMMMd().format(tempDate).toString();
      // update();
    }
    // update();
    return difference.value ;
  }

  // -------------------->  timeCalculate Of Day <----------------------- //
  timeCalculate({required List<String> timeList}) {
    List<DateTime> parsedTimestamps = timeList.map((timestamp) {
      return DateFormat('dd-MM-yyyy HH:mm:ss:SSS').parse(timestamp);
    }).toList();

    List<Duration> timeDifferences = [];

    for (int i = 0; i < parsedTimestamps.length - 1; i += 2) {
      Duration difference = parsedTimestamps[i + 1].difference(parsedTimestamps[i]);
      timeDifferences.add(difference);
    }
    Duration totalTimeDifference = timeDifferences.fold(Duration(), (a, b) => a + b);
    for (int i = 0; i < timeDifferences.length; i++) {
      print('Difference between ${i * 2} and ${i * 2 + 1}: ${timeDifferences[i]}');
    }
    print('Total Time Difference: $totalTimeDifference');
    Duration duration = Duration(hours: totalTimeDifference.inHours, minutes: totalTimeDifference.inMinutes, seconds: totalTimeDifference.inSeconds);
    String formattedDuration = DateFormat('HH:mm:ss').format(
        DateTime(0).add(duration)
    );
    // log('-----durationString------> ${formattedDuration}');
    // String durationString = duration.toString();
    String durationString = formattedDuration.toString();
    durationTime.value = durationString;

    Future.delayed(const Duration(seconds: 1)).then((value) => update());


  }

  DateTime selectedDate = DateTime.now();

  // -------------------->  Select Particular Date Wise Data Show  <----------------------- //
  Future<void> selectDate(context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (picked != null && picked != selectedDate) {
      selectedDate = picked;
      update();
    }
    durationTime.value = '';
    dayWiseData.value = DateFormat('dd-MM-yyyy').format(DateTime.parse(selectedDate.toString()));
    update();
    log('-----dayWiseData-------> $dayWiseData');
    log('-----durationTime-------> ${durationTime.value}');
  }

}