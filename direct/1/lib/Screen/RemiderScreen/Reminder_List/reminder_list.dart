
import 'dart:developer';
import 'dart:io';
import 'package:direct_message/CommonWidget/Utils.dart';
import 'package:direct_message/CommonWidget/app_colors.dart';
import 'package:direct_message/CommonWidget/textfield.dart';
import 'package:direct_message/ConstData/colors.dart';
import 'package:direct_message/Routes/routes.dart';
import 'package:direct_message/Screen/RemiderScreen/Reminder_List/reminder_list_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import '../Local_Notification_Reminder/nofication_class.dart';
import '../create_reminder_controller.dart';

class RemindUser extends StatelessWidget {
  RemindUser({Key? key}) : super(key: key);

  final RemindUsersController remindUsersController = Get.put(RemindUsersController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(

        // floatingActionButton: GestureDetector(
        //   onTap: () {
        //     NotificationService().sendNotification();
        //   },
        //   child: Container(
        //     height: 100,width: 100,decoration: BoxDecoration(color: AppColors.black.withOpacity(0.2),shape: BoxShape.circle),
        //     child: const Center(child: Text('Tap')),
        //   ),
        // ),

        appBar: AppBar(
          elevation: 5.0,
          shadowColor: Colors.grey.withOpacity(0.2),
          backgroundColor: likeWhiteColor,
          centerTitle: true,
          title:
              const Text('Reminder to send message', style: FontStyle.textBlack),
          leading: GestureDetector(
            onTap: () {
              payload.value == 'RemindUser' ? Get.offNamed(AppRoute.bottomBarScreen) :  Get.back();
              payload.value = '';
            },
            child: Container(
              padding: const EdgeInsets.all(18.0),
              color: Colors.transparent,
              child: Image.asset('assets/arrow_back.png'),
            ),
          ),

        ),

        bottomNavigationBar: Column(
          mainAxisSize: MainAxisSize.min,
          children: [

            const SizedBox(height: 5.0),

            GestureDetector(
                onTap: () {
                  remindUsersController.navigateToReminderScreen();
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Utils().containerButton('CREATE',),
                )),

            const SizedBox(height: 5.0),
          ],
        ),
        body: Obx(() =>!remindUsersController.isLoading.value ?
        reminderModelList.isNotEmpty ?
        ListView.builder(
          shrinkWrap: true,
          physics: const ClampingScrollPhysics(),
          itemCount: reminderModelList.length,
          itemBuilder: (context, index) {
            var list = reminderModelList[index];
            print('------------------> ${list.date}');
            var date = remindUsersController.getFormatedDate(list.date);
            return Container(
              margin: EdgeInsets.fromLTRB(25.0, index == 0 ? 25.0 : 5.0, 25.0, 5.0),
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: fieldBorder,
                  border: Border.all(color: AppColors.lightWhite, width: 1.5)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 5.0,vertical: 5.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [

                              Text(
                                list.name,
                                overflow: TextOverflow.ellipsis,
                                style: FontStyle.textBlack,
                              ),

                              const SizedBox(height: 10.0),

                              Text(
                                "$date ${list.time}",
                                style: FontStyle.textBlack.copyWith(color: blackText,fontSize: 12),
                              ),
                            ],
                          ),
                        ),
                      ),

                      PopupMenuButton<int>(
                        onSelected: (value) {
                          if(value == 1){
                            print('------UpdateIdCall------> ${list.id!}');
                            updateScheduleNotificationId.value = index;
                            remindUsersController.navigateToUpdateData(
                              id: list.id ?? 0,
                              name: list.name,
                              address: list.address,
                              date: list.date,
                              time: list.time,
                            );
                          } else{
                            deleteScheduleNotificationId.value = list.id!;
                            remindUsersController.deleteMsg(list.id!);

                            NotificationService().stopNotificationId(reminderModelList.value.length);
                            log('-------deleted id =============> ${reminderModelList.value.length}' );

                          }
                        },
                        itemBuilder: (context) => [

                          PopupMenuItem(
                            value: 1,
                            child: SizedBox(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children:  [
                                  SvgPicture.asset(
                                    'assets/reminderScreen/remindersvg.svg',
                                    height: 15,width: 15,
                                  ),

                                  const SizedBox(width: 10),

                                  Text("Update",style: FontStyle.textBlack.copyWith(
                                      fontSize: 13,color: lightBlack),)
                                ],
                              ),
                            ),
                          ),

                          PopupMenuItem(
                            value: 2,
                            child: SizedBox(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SizedBox(
                                      child: SvgPicture.asset(
                                        'assets/reminderScreen/deletesvg.svg',
                                        height: 20,width: 20,
                                      ),
                                  ),

                                  const SizedBox(width: 10,),

                                  Text("Delete",style: FontStyle.textBlack.copyWith(
                                      fontSize: 13,color: lightBlack),)
                                ],
                              ),
                            ),
                          ),
                        ],
                        offset: const Offset(0, 30.0),
                        color: Colors.white,
                        padding: const  EdgeInsets.symmetric(horizontal: 15),
                        elevation: 2,
                        shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                          ),
                        child: const Padding(
                          padding:  EdgeInsets.only(bottom: 15),
                          child:  Icon(Icons.more_vert,
                              color: Colors.black),
                        ),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                ],
              ),
            );
          },
        )
            : const Center(child: Text('Add Your Reminder',style: FontStyle.greyText),)
            : const Center(child: CircularProgressIndicator(color: AppColors.circularColor,),)
            ),
      ),
    );
  }
}
