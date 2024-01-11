import 'package:direct_message/CommonWidget/app_colors.dart';
import 'package:direct_message/ConstData/colors.dart';
import 'package:direct_message/Screen/Private_Note/private_note_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:direct_message/CommonWidget/textfield.dart';
import '../../../CommonWidget/Utils.dart';
import '../../CommonWidget/flutter_toast.dart';

class PrivateNote extends StatelessWidget {
  PrivateNote({Key? key}) : super(key: key);

  PrivateNoteController privateNoteController = Get.put(PrivateNoteController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        bottomNavigationBar: GestureDetector(
          onTap: () {
            privateNoteController.navigateToCreateNote();
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(height: 5.0),
                Utils().containerButton(
                  'CREATE',
                ),
                const SizedBox(height: 5.0),
              ],
            ),
          ),
        ),

        appBar: AppBar(
          elevation: 5.0,
          shadowColor: Colors.grey.withOpacity(0.2),
          backgroundColor: likeWhiteColor,
          centerTitle: true,
          title: const Text(
            'Private Notes',
            style: TextStyle(
              color: blackColor,
              fontWeight: FontWeight.w600,
              fontFamily: "Inter-SemiBold",
              fontSize: 15.0,
            ),
          ),
          leading: Utils().arrowBackAppBar(),
        ),

        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0,vertical: 20),
          child: Obx(() => privateNoteController.loading.value ?
          privateNoteController.noteModel.isNotEmpty ?
          ListView.builder(
            shrinkWrap: true,
            itemCount: privateNoteController.noteModel.length,
            physics: const ClampingScrollPhysics(),
            itemBuilder: (context, index) {
              var data = privateNoteController.noteModel[index];
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 10),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: fieldBorder,
                      border: Border.all(
                          color:  AppColors.lightWhite ,width: 1.5)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 5.0),
                              child: Column(
                                crossAxisAlignment:
                                CrossAxisAlignment.start,
                                children: [

                                  Text(
                                    data.title.toString(),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: FontStyle.textBlack,
                                  ),

                                  const SizedBox(height: 8),

                                  Text(
                                    data.subtitle.toString(),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                      style: FontStyle.textLabelGrey.copyWith(
                                      fontSize: 14,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),

                          PopupMenuButton<int>(
                            onSelected: (value) {
                            if(value == 1){
                              // Get.back();
                              privateNoteController.navigateToUpdateData(
                                id: data.id ?? 0,
                                title :data.title,
                                description: data.subtitle ,
                              );
                            } else{
                              // Get.back();
                              privateNoteController.deleteMsg(data.id!);
                              flutterToast(text: "Successfully Deleted");
                            }
                          },
                            itemBuilder: (context) => [
                              PopupMenuItem(
                                value: 1,
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children:  [

                                    SvgPicture.asset(
                                      'assets/reminderScreen/remindersvg.svg',
                                      height: 15,width: 15,
                                    ),

                                    const SizedBox(
                                      width: 15,
                                    ),

                                    Text("Update",style: FontStyle.textBlack.copyWith(
                                        fontSize: 12,color: lightBlack),)
                                  ],
                                ),
                              ),

                              PopupMenuItem(
                                value: 2,
                                child: SizedBox(


                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      SizedBox(
                                        child: SvgPicture.asset(
                                          'assets/reminderScreen/deletesvg.svg',
                                          height: 20,width: 20,
                                        ),
                                      ),

                                      const SizedBox(
                                        width: 15,
                                      ),

                                      Text("Delete",style: FontStyle.textBlack.copyWith(
                                          fontSize: 12,color: lightBlack),)
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
                              child: Icon(Icons.more_vert,
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
                ),
              );
            },
          ) : const Center(child: Text('Add Your Notes',style: FontStyle.greyText),
          ) : const Center(child: CircularProgressIndicator(color: AppColors.circularColor,))
          ),
        ),
      ),
    );
  }
}
