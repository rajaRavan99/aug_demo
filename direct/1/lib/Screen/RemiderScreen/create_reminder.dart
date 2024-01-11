
import 'package:direct_message/CommonWidget/Utils.dart';
import 'package:direct_message/CommonWidget/app_colors.dart';
import 'package:direct_message/CommonWidget/textfield.dart';
import 'package:direct_message/ConstData/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'create_reminder_controller.dart';

class RemindScreen extends StatelessWidget {
  RemindScreen({Key? key}) : super(key: key);

  final CreateReminderController createReminderController =
      Get.put(CreateReminderController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        bottomNavigationBar: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 5.0),
            GestureDetector(
                onTap: () {
                  createReminderController.editMsg();
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Utils().containerButton(
                      createReminderController.isStatus ? 'UPDATE' : 'DONE'),
                )),
            const SizedBox(height: 5.0),
          ],
        ),

        appBar: AppBar(
          elevation: 5.0,
          shadowColor: Colors.grey.withOpacity(0.2),
          backgroundColor: likeWhiteColor,
          centerTitle: true,
          title: Text(
              createReminderController.isStatus
                  ? 'Update Reminder'
                  : 'Create Reminder',
              style: FontStyle.textBlack),
          leading: Utils().arrowBackAppBar(),
        ),

        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Form(
            key: createReminderController.formKey,
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Column(
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      controller: createReminderController.nameController,
                      textAlign: TextAlign.start,
                      textInputAction: TextInputAction.next,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please Enter name';
                        }
                        return null;
                      },
                      decoration: Utils.inputDecoration('Name').copyWith(
                        fillColor: fieldBorder,
                        contentPadding: const EdgeInsets.all(15),
                        filled: true,
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(11),
                          borderSide:  const BorderSide(
                              width: 1, color: AppColors.greyText), //<-- SEE HERE
                        ),

                        errorBorder:  OutlineInputBorder(borderRadius: BorderRadius.circular(11),
                          borderSide:  const BorderSide(
                              width: 1, color: AppColors.greyText), //<-- SEE HERE
                        ),

                        focusedBorder:  OutlineInputBorder(
                          borderRadius: BorderRadius.circular(11),
                          borderSide:  const BorderSide(
                              width: 1, color: AppColors.greyText), //<-- SEE HERE
                        ),

                        focusedErrorBorder:  OutlineInputBorder(
                          borderRadius: BorderRadius.circular(11),
                          borderSide:  const BorderSide(
                              width: 1, color: AppColors.greyText), //<-- SEE HERE
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      controller: createReminderController.addressController,
                      textAlign: TextAlign.start,
                      maxLines: 5,
                      textInputAction: TextInputAction.done,
                      decoration: Utils.inputDecoration('Detail').copyWith(
                        fillColor: fieldBorder,
                        filled: true,
                        contentPadding: const EdgeInsets.all(15),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(11),
                          borderSide:  const BorderSide(
                              width: 1, color: AppColors.greyText), //<-- SEE HERE
                        ),

                        errorBorder:  OutlineInputBorder(borderRadius: BorderRadius.circular(11),
                          borderSide:  const BorderSide(
                              width: 1, color: AppColors.greyText), //<-- SEE HERE
                        ),

                        focusedBorder:  OutlineInputBorder(
                          borderRadius: BorderRadius.circular(11),
                          borderSide:  const BorderSide(
                              width: 1, color: AppColors.greyText), //<-- SEE HERE
                        ),

                        focusedErrorBorder:  OutlineInputBorder(
                          borderRadius: BorderRadius.circular(11),
                          borderSide:  const BorderSide(
                              width: 1, color: AppColors.greyText), //<-- SEE HERE
                        ),
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please Enter detail';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              createReminderController.datePicker(context);
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                  color: fieldBorder,
                                  borderRadius: BorderRadius.circular(12),
                                  border:
                                      Border.all(color: Colors.grey, width: 0.5)),
                              child: Row(
                                // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 6, vertical: 6),
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(12),
                                      color: Colors.blue,
                                      gradient: const LinearGradient(
                                        begin: Alignment.centerLeft,
                                        end: Alignment.centerRight,
                                        colors: [blueColor, linerSecondColor],
                                      ),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Image.asset(
                                        'assets/reminderScreen/calender2.png',
                                        width: 25,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 10),
                                  Expanded(
                                    child: Obx(
                                      () => Text(
                                        createReminderController.simpleDate.value
                                            .toString(),
                                        maxLines: 2,
                                        style: FontStyle.textBlack.copyWith(
                                          color: blackText,
                                          fontSize: 13,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: Container(
                            decoration: BoxDecoration(
                                color: fieldBorder,
                                borderRadius: BorderRadius.circular(12),
                                border:
                                    Border.all(color: Colors.grey, width: 0.5)),
                            child: GestureDetector(
                              onTap: () {
                                createReminderController.selectTimeF(context);
                              },
                              child: Row(
                                children: [
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 6, vertical: 6),
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(12),
                                      color: Colors.blue,
                                      gradient: const LinearGradient(
                                        begin: Alignment.centerLeft,
                                        end: Alignment.centerRight,
                                        colors: [blueColor, linerSecondColor],
                                      ),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Image.asset(
                                        'assets/reminderScreen/reminder.png',
                                        width: 25,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 10),
                                  Obx(
                                    () => Text(
                                      createReminderController.time.value,
                                      style: FontStyle.textBlack.copyWith(
                                          color: blackText, fontSize: 13),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),

        // floatingActionButton: FloatingActionButton(onPressed: () async {
        //   print('==============> id <================');
        //   createReminderController.checkPendingId = await NotificationService().pendingNotificationList();
        //   print('=====checkPendingId===========>${createReminderController.checkPendingId}');
        // },),
      ),
    );
  }
}
