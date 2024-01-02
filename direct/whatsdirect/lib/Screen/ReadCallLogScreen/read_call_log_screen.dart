
import 'package:direct_message/CommonWidget/app_colors.dart';
import 'package:direct_message/CommonWidget/textfield.dart';
import 'package:direct_message/ConstData/colors.dart';
import 'package:direct_message/Screen/ReadCallLogScreen/read_call_log_screen_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../ConstData/static_data.dart';


class ReadCallLogScreen extends StatelessWidget {
  ReadCallLogScreen({Key? key}) : super(key: key);

  final ReadCallLogsScreenController readCallLogsScreenController = Get.put(ReadCallLogsScreenController());

  @override
  Widget build(BuildContext context) {
    readCallLogsScreenController.buildContext = context;

    return WillPopScope(
      onWillPop: () {
        readCallLogsScreenController.showExitPopup();
        return Future.value(true);
      },
      child: RefreshIndicator(
        color: AppColors.circularColor,
        onRefresh: () => readCallLogsScreenController.permissionHandler(),
        child: SafeArea(
          child: Scaffold(
            appBar: AppBar(
              elevation: 5.0,
              shadowColor: Colors.grey.withOpacity(0.2),
              backgroundColor: likeWhiteColor,
              centerTitle: true,
              title: Text(
                  'Call log',
                  style: FontStyle.textBlack.copyWith(fontSize: 18,fontWeight: FontWeight.w600)
              ),
            ),

            body: Obx(
              () => !readCallLogsScreenController.isDataLoad.value
                  ? readCallLogsScreenController.callLogList.isEmpty
                      ? Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [

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
                      : Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12.0,vertical: 0),
                        child: ListView(
                            children: [

                              const SizedBox(height: 10,),

                              for (int index = (readCallLogsScreenController.callLogList.length >= 100
                                  ? 100
                                      : readCallLogsScreenController.callLogList.length - 1);
                                  index >= 0;
                                  index--)

                                Container(
                                  margin: const EdgeInsets.symmetric(horizontal: 10,vertical: 5.0),
                                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(15),
                                      border: Border.all(color: fieldBorder,width: 1.5)),
                                  child: ListTile(
                                    onTap: () {
                                      RegExp regExp = RegExp(
                                          r'^\+(?:998|996|995|994|993|992|977|976|975|974|973|972|971|970|968|967|966|965|964|963|962|961|960|886|880|856|855|853|852|850|692|691|690|689|688|687|686|685|683|682|681|680|679|678|677|676|675|674|673|672|670|599|598|597|595|593|592|591|590|509|508|507|506|505|504|503|502|501|500|423|421|420|389|387|386|385|383|382|381|380|379|378|377|376|375|374|373|372|371|370|359|358|357|356|355|354|353|352|351|350|299|298|297|291|290|269|268|267|266|265|264|263|262|261|260|258|257|256|255|254|253|252|251|250|249|248|246|245|244|243|242|241|240|239|238|237|236|235|234|233|232|231|230|229|228|227|226|225|224|223|222|221|220|218|216|213|212|211|98|95|94|93|92|91|90|86|84|82|81|66|65|64|63|62|61|60|58|57|56|55|54|53|52|51|49|48|47|46|45|44\\D?1624|44\D?1534|44\D?1481|44|43|41|40|39|36|34|33|32|31|30|27|20|7|1\D?939|1\D?876|1\D?869|1\D?868|1\D?849|1\D?829|1\D?809|1\D?787|1\D?784|1\D?767|1\D?758|1\D?721|1\D?684|1\D?671|1\D?670|1\D?664|1\D?649|1\D?473|1\D?441|1\D?345|1\D?340|1\D?284|1\D?268|1\D?264|1\D?246|1\D?242|1)\D?');
                                      addPhoneController.text =
                                          readCallLogsScreenController
                                              .getNumber(
                                                  readCallLogsScreenController
                                                      .callLogList.value
                                                      .elementAt(index))
                                              .toString()
                                              .replaceAll("Text", "")
                                              .replaceAll("(", "")
                                              .replaceAll(")", "")
                                              .replaceAll('"', "")
                                              .replaceAll(regExp, "")
                                              .removeAllWhitespace;
                                      readCallLogsScreenController
                                          .navigatorToHomeScreen();
                                    },

                                    leading: Container(
                                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                                        decoration: const BoxDecoration(
                                          shape: BoxShape.circle,
                                        ),
                                        child: Image.asset(
                                          'assets/person.png',
                                        ),
                                    ),

                                    title: Text(
                                      readCallLogsScreenController.getTitle(readCallLogsScreenController.callLogList.value
                                              .elementAt(index)),
                                      style: FontStyle.textGrey.copyWith(color: AppColors.blackColors),
                                    ),

                                    subtitle: Padding(
                                      padding: const EdgeInsets.only(top: 5.0),
                                      child: Row(
                                        children: [

                                          const Icon(
                                            Icons.access_time,
                                            color: blueColor,
                                            size: 15,
                                          ),

                                          const SizedBox(width: 2,),

                                          Text(
                                            readCallLogsScreenController.formatDate(
                                              DateTime.fromMillisecondsSinceEpoch(
                                                readCallLogsScreenController
                                                    .callLogList.value
                                                    .elementAt(index)
                                                    .timestamp!,
                                              ),
                                            ),
                                              style: FontStyle.textGrey.copyWith(fontSize: 12)
                                          ),
                                        ],
                                      ),
                                    ),
                                    // trailing: callLogScreenController.getAvator(callLogList.elementAt(index).callType!),
                                  ),
                                ),
                            ],
                          ),
                      )
                  : const Center(
                      child: Text(
                        "Please Wait...",
                        style: TextStyle(
                            fontFamily: "Inter-Regular", fontSize: 20.0),
                      ),
                    ),
            ),
          ),
        ),
      ),
    );
  }
}
