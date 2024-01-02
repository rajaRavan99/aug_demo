import 'package:direct_message/Extension/getx_extension.dart';
import 'package:direct_message/Screen/RemiderScreen/create_reminder_controller.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../../CommonWidget/flutter_toast.dart';
import '../../../Model/reminder_model.dart';
import '../../../Routes/routes.dart';
import '../../SqliteDatabase/reminder_sqflite.dart';
import '../Local_Notification_Reminder/nofication_class.dart';

RxList<ReminderModel> reminderModelList = RxList();

class RemindUsersController extends GetxController{

  RxBool isLoading = true.obs;

  NotificationService notificationService = NotificationService();

  @override
  void onInit() {
    notificationService.initialiseNotification;
    Future.delayed(const Duration(milliseconds: 300)).then((value) {
      getAll();
    });
    super.onInit();
  }



  getAll() {
    ReminderDBHelper.instance.getData().then((value) {
      reminderModelList.value = value;
      isLoading.value = false;
    });
  }

  refreshMsg() {
    getAll();
  }

  Future deleteMsg(int id) async {
    await ReminderDBHelper.instance.delete(id);

    reminderModelList.removeWhere((element) => element.id == id);
    // NotificationService().stopNotificationId(deleteScheduleNotificationId.value);
    flutterToast(text: "Successfully Deleted");
    update();
  }

  navigateToReminderScreen() {
    Get.deleteAndPut(false ,tag: "status");
    Get.deleteAndPut(0 , tag: "id");
    Get.deleteAndPut('' , tag: "name");
    Get.deleteAndPut('' , tag: "address");
    Get.deleteAndPut('' , tag: "time");
    Get.deleteAndPut('' , tag: "date");
    Get.toNamed(AppRoute.reminderScreen)!.then((value){
      getAll();
    });
  }

  navigateToReminderList(){
    Get.toNamed(AppRoute.remindUser);
  }

  navigateToUpdateData({required int id,
    required String name ,required String address,required String date,required String time}){

    Get.deleteAndPut(true ,tag: "status");
    Get.deleteAndPut(id ,tag: "id");
    Get.deleteAndPut(name ,tag: "name");
    Get.deleteAndPut(address ,tag: "address");
    Get.deleteAndPut(date ,tag: "date");
    Get.deleteAndPut(time ,tag: "time");
    Get.toNamed(AppRoute.reminderScreen)?.then((value) {
      getAll();
    });
  }

  getFormatedDate(_date) {
    var inputFormat = DateFormat().add_yMMMMd();
    var inputDate = inputFormat.parse(_date);
    var outputFormat = DateFormat('dd MMMM, yyyy');
    return outputFormat.format(inputDate);
  }
}




