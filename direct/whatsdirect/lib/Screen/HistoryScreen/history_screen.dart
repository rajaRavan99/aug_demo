
import '../../CommonWidget/app_colors.dart';
import 'package:direct_message/ConstData/colors.dart';
import 'package:direct_message/CommonWidget/textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import '../../Utils/time_format.dart';
import '../DirectMessageScreen/Direct_message_screen_controller.dart';
import 'history_screen_controller.dart';

class HistoryScreen extends StatelessWidget {
  HistoryScreen({Key? key}) : super(key: key);

  final HistoryScreenController historyScreenController = Get.put(HistoryScreenController());
  final DirectMessageScreenController directMessageScreenController = Get.put(DirectMessageScreenController());

  @override
  Widget build(BuildContext context) {
    historyScreenController.buildContext = context;

    return WillPopScope(
      onWillPop: () {
        historyScreenController.showExitPopup();
        return Future.value(true);
      },
      child: SafeArea(
        child: Scaffold(

            appBar: AppBar(
              elevation: 5.0,
              shadowColor: Colors.grey.withOpacity(0.2),
              backgroundColor: likeWhiteColor,
              centerTitle: true,

              title: Text(
                  'History',
                  style: FontStyle.textBlack.copyWith(fontSize: 18)
              ),
            ),

            body: SafeArea(
              child: GetBuilder(
                  init: directMessageScreenController,
                builder: (controller) {
                  return SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(height: Get.height / 30,),
                        directMessageScreenController.taskData.value.isNotEmpty ?
                        Text('Here’s a list of all messages sent.\n Resend or copy to clipboard.',
                          style: FontStyle.textGrey.copyWith(color: AppColors.blackColors),) : const SizedBox.shrink(),

                        SizedBox(height: Get.height / 30,),

                        directMessageScreenController.taskData.isNotEmpty ?
                        ListView.builder(
                            reverse: true,
                            shrinkWrap: true,
                            physics: const ClampingScrollPhysics(),
                            itemCount: directMessageScreenController.taskData.length,
                            itemBuilder: (context, index) {
                              var data = directMessageScreenController.taskData[index];
                              print('============> ${directMessageScreenController.taskData[index].title}');

                              return Container(
                                margin: const EdgeInsets.symmetric(horizontal: 22,vertical: 5.0),
                                padding: const EdgeInsets.symmetric(
                                    vertical: 15, horizontal: 12),
                                decoration: BoxDecoration(borderRadius: BorderRadius.circular(15),
                                    border: Border.all(color: fieldBorder,width: 1.5)),
                                child: GestureDetector(onTap: () {
                                  var whatsapp = directMessageScreenController.taskData[index].title;
                                  directMessageScreenController.openWhatsappAddNumber(whatsapp: whatsapp);
                                },
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      
                                      Container(
                                        padding: const EdgeInsets.symmetric(vertical: 3.0,horizontal: 5),
                                        decoration: const BoxDecoration(
                                          shape: BoxShape.circle,
                                        ),
                                        child: Image.asset(
                                          'assets/person.png',
                                          width: 45,
                                        ),
                                      ),

                                      SizedBox(
                                        width: Get.width * 0.02,
                                      ),

                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [

                                            const SizedBox(
                                              height: 5,
                                            ),

                                            Text(
                                              directMessageScreenController.taskData[index].title.toString(),

                                              // '${directMessageScreenController.taskData[index].title.toString().substring(0,3)} '
                                              //     ' ${data.title.toString().substring(3,8)} '
                                              //     '${data.title.toString().substring(8,13)}',
                                              maxLines: 1,
                                              overflow:TextOverflow.ellipsis,
                                              style: FontStyle.textGrey.copyWith(color: AppColors.blackColors),
                                            ),

                                            const SizedBox(
                                              height: 10,
                                            ),

                                            Row(
                                              children: [
                                                const Icon(
                                                  Icons.access_time,
                                                  color: blueColor,
                                                  size: 15,
                                                ),

                                                const SizedBox(width: 2,),

                                                Text(
                                                    timeStampToTime(
                                                      directMessageScreenController.taskData[index].time.toString(),
                                                      'date',
                                                    ),
                                                    overflow: TextOverflow.ellipsis,
                                                    style: FontStyle.textGrey.copyWith(fontSize: 12)
                                                ),
                                              ],
                                            ),
                                            const SizedBox(
                                              height: 5,
                                            ),
                                          ],
                                        ),
                                      ),

                                      Row(
                                        children: [
                                          GestureDetector(
                                            onTap: () async {
                                              var number = directMessageScreenController.taskData[index].title.toString();
                                              FlutterShare.share(
                                                linkUrl: "https://wa.me/$number",
                                                title: "shareLink",
                                              );
                                            },
                                            child: Padding(
                                              padding:  const EdgeInsets.symmetric(horizontal: 3.0),
                                              child: SvgPicture.asset('assets/chain.svg',color: blueColor,width: 20),
                                            ),
                                          ),

                                          const SizedBox(width: 10,),


                                          GestureDetector(
                                            onTap: () {
                                              directMessageScreenController.deleteTask(directMessageScreenController.taskData[index].id!);
                                            },
                                            child: Padding(
                                              padding:  const EdgeInsets.symmetric(horizontal: 3.0),
                                              child: SvgPicture.asset('assets/delete.svg',width: 22),
                                            ),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              );
                            }) :

                        Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [

                              const SizedBox(height: 30,),

                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 70.0,vertical: 50
                                ),
                                child: Image.asset(
                                  "assets/CustomMessage/noMessage.png",
                                ),
                              ),

                              const Text(
                                'Records Not Found',
                                style: TextStyle(
                                  color: emptyColor,
                                  fontSize: 18,
                                  fontFamily: "Inter-Regular",
                                ),
                              ),
                            ],
                          ),
                        )


                      ],
                    ),
                  );
                }
              ),
            ),),
      ),
    );
  }
}


// record not found image : -

// Padding(
//   padding: const EdgeInsets.symmetric(
//       horizontal: 70.0,vertical: 50
//   ),
//   child: Image.asset(
//     "assets/CustomMessage/noMessage.png",
//   ),
// ),