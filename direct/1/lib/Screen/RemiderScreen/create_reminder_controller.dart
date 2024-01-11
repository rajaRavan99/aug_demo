import 'dart:developer';

import 'package:direct_message/CommonWidget/flutter_toast.dart';
import 'package:direct_message/Screen/SqliteDatabase/reminder_sqflite.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../Model/reminder_model.dart';
import '../../Routes/routes.dart';
import 'Local_Notification_Reminder/nofication_class.dart';
import 'Reminder_List/reminder_list_controller.dart';


RxInt updateScheduleNotificationId  = 0.obs;
RxInt deleteScheduleNotificationId  = 0.obs;

class CreateReminderController extends GetxController {
  bool isStatus = Get.find<bool>(tag: "status");
  int id = Get.find(tag: "id");

  DateTime setNotificationDateTime = DateTime.now();
  RxInt increment = 0.obs;

  TextEditingController nameController = TextEditingController();
  TextEditingController addressController = TextEditingController();

  RxList<ReminderModel> reminderModelList = RxList();
  RxBool isLoading = false.obs;
  String selectDateConcat = DateFormat("yyyy-MM-dd").format(DateTime.now());
  // String ddmmyyyy = DateFormat("dd-MMMM-yyyy").format(DateTime.now());
  String selectTimeConcat = DateFormat("HH:mm:ss").format(DateTime.now());
  final formKey = GlobalKey<FormState>();
  DateTime? pickedDate;
  RxString time = DateFormat('HH:mm a').format(DateTime.now()).obs;
  RxString simpleDate = DateFormat('MMMM dd, yyyy').format(DateTime.now()).obs;


  @override
  void onInit() {
    nameController.text = Get.find(tag: "name");
    addressController.text = Get.find(tag: "address");
    simpleDate.value = Get.find(tag: "date");
    time.value = Get.find(tag: "time");
    if(!isStatus){
      time.value = DateFormat('h:mm a').format(DateTime.now());
      simpleDate.value = DateFormat('MMMM dd, yyyy').format(DateTime.now());
    }
    getAll();
    super.onInit();
  }

  @override
  void dispose() {
    nameController.dispose();
    addressController.dispose();
    super.dispose();
  }

  navigateToReminderScreen() {
    update();
    Get.toNamed(AppRoute.reminderScreen);
  }

  Future<DateTime?> datePicker(BuildContext context) async {
    pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
      helpText: 'Select Date',
      initialEntryMode: DatePickerEntryMode.calendarOnly,
    );
    if (pickedDate != null) {
      selectDateConcat = DateFormat("yyyy-MM-dd").format(pickedDate!);
      String formattedDate = DateFormat('MMMM dd, yyyy').format(pickedDate!);
      // ddmmyyyy = DateFormat('MMMM dd,yyyy').format(pickedDate!);
      simpleDate.value = formattedDate;
    } else {
      print("Date is not selected");
    }
    update();
  }



  selectTimeF(BuildContext context) async {
      TimeOfDay? pickedTime =  await showTimePicker(
      initialTime: TimeOfDay.now(),
      context: context,
      builder: (BuildContext context, Widget? child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: false),
          child: child!,
        );
      },
    );

    if(pickedTime != null ){
      DateTime tempTime = DateFormat("HH:mm").parse(pickedTime.hour.toString()+":"+pickedTime.minute.toString());
        selectTimeConcat = DateFormat("HH:mm:ss").format(tempTime);
        time.value = DateFormat("h:mm a").format(tempTime);
    } else{
        time.value = time.value;
    }
  }

  getAll() {
    isLoading.value = true;
    try{
      ReminderDBHelper.instance.getData().then((value) {
        reminderModelList.value = value;
        update();
      });
    }finally{
      isLoading.value = false;
    }

  }

  refreshMsg() {
    getAll();
  }

  Future addData() async {
    await ReminderDBHelper.instance.insert(ReminderModel(
        name: nameController.text,
        address: addressController.text,
        date: simpleDate.value,
        time: time.value,
      ),
    );
  }

  Future updateData() async {
    await ReminderDBHelper.instance.update(
      ReminderModel(
        id: id,
        name: nameController.text,
        address: addressController.text,
        date: simpleDate.value,
        time: time.value,
      ),
    );
    refreshMsg();

  }

  createNotification() {
      print('===========?>>>>>>>> ${reminderModelList.value.length}');
      var dateTime = DateTime.parse('$selectDateConcat $selectTimeConcat');
    for(int i = 0 ; i < reminderModelList.value.length; i++,)
      {
        NotificationService().sechduleNotification(
          id: (reminderModelList.value.length),
          schedule: dateTime,
          name: reminderModelList.value[i].name,
          address: reminderModelList.value[i].address,
        );
        log('---------create Notification id-----------------${reminderModelList.value.length}');
      }

  }

  updateNotification() {
      print('===========?>>>>>>>> ${reminderModelList.value.length}');
      var dateTime = DateTime.parse('$selectDateConcat $selectTimeConcat');
      print('--------------id--------------> ${id}');
    for(int i = 0 ; i < reminderModelList.value.length; i++,)
      {
        NotificationService().sechduleNotification(
          id: id,
          schedule: dateTime,
          name: reminderModelList.value[i].name,
          address: reminderModelList.value[i].address,
        );
      }
  }




  editMsg(){
    if (isStatus) {
      updateData().then((value) {

        reminderModelList.add(
            ReminderModel(
                name: nameController.text,
                address: addressController.text,
                date: selectDateConcat,
                time: selectTimeConcat));

        updateNotification();
        Get.back();

          // NotificationService().sechduleNotification(
          //   id: (reminderModelList.value.length),
          //   schedule: DateTime.parse("$selectDateConcat $selectTimeConcat"),
          //   name: nameController.text,
          //   address: addressController.text,
          // );

          flutterToast(text: "Update SuccessFully");
        }
      );
    } else {
      if(formKey.currentState!.validate()){
        addData().then((value) {
          reminderModelList.add(
              ReminderModel(
              name: nameController.text,
                  address: addressController.text,
                  date: selectDateConcat,
                  time: selectTimeConcat));

          createNotification();

          Get.back();
          RemindUsersController().getAll();
          // NotificationService().sechduleNotification(
          //   id: (reminderModelList.value.length),
          //   schedule: DateTime.parse("$selectDateConcat $selectTimeConcat"),
          //   name: nameController.text,
          //   address: addressController.text,
          // );
          });
        update();
      }
    }
  }

  navigationToReminderList() {
    Get.toNamed(AppRoute.remindUser);
  }

}
