import 'dart:io';
import 'package:direct_message/CommonWidget/app_colors.dart';
import 'package:direct_message/ConstData/colors.dart';
import 'package:direct_message/Screen/BottombarScreen/bottombar_screen_controller.dart';
import 'package:direct_message/Screen/ReadCallLogScreen/read_call_log_screen_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BottomBarScreen extends StatelessWidget {
  BottomBarScreen({Key? key}) : super(key: key);

  final BottomBarScreenController bottomBarScreenController = Get.put(BottomBarScreenController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: Obx(
          () => bottomBarScreenController.pageIndex.value == 1 ||
                  bottomBarScreenController.pageIndex.value == 2 ||
                  bottomBarScreenController.pageIndex.value == 3
              ? const SizedBox(
                  height: 0,
                )
              : Padding(
                  padding: const EdgeInsets.only(bottom: 35.0),
                  child: Platform.isAndroid ? Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      GestureDetector(
                        onTap: () {
                          bottomBarScreenController.navigateToHowToUsePage();
                        },
                        child: Container(
                          margin: const EdgeInsets.symmetric(vertical: 5),
                          // padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 10),
                          decoration: const BoxDecoration(
                            color: Colors.blue,
                            shape: BoxShape.circle,
                            gradient: LinearGradient(
                              begin: Alignment.centerLeft,
                              end: Alignment.centerRight,
                              colors: [blueColor, linerSecondColor],
                            ),
                          ),
                          child: const Padding(
                            padding: EdgeInsets.all(18.0),
                            child: ImageIcon(
                              size: 30.0,
                              AssetImage(
                                "assets/homescreen/howtouse.png",
                              ),
                              color: whiteColor,
                            ),
                          ),
                        ),
                      ) ,

                      const Text(
                        "How to Use",
                        style: TextStyle(
                          color: blueColor,
                          fontFamily: "Inter-SemiBold",
                        ),
                      ),
                    ],
                  ) : const SizedBox.shrink(),
                ),
        ),

        body: Stack(
          children: [
            Obx(
              () => bottomBarScreenController
                  .pageList[bottomBarScreenController.pageIndex.value],
            ),
          ],
        ),

        bottomNavigationBar: Container(

          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(20), topRight: Radius.circular(20)),
            boxShadow: [
              BoxShadow(
                  color: AppColors.lightWhite.withOpacity(0.1),
                  blurRadius: 5.0,
                  spreadRadius: 10.0,
                offset: Offset(0, 7),
              ),
            ],
          ),

          padding: const EdgeInsets.symmetric(vertical: 15),

          child: Obx(
            () => Platform.isAndroid
                ? Row(
                    children: [

                      buildExpandedWidget(
                        onTap: () {
                          bottomBarScreenController.pageIndex.value = 0;
                        },
                        icon: "assets/homescreen/home_icon.png",
                        text: "Home",
                        color: bottomBarScreenController.pageIndex.value == 0
                            ? mixBlue
                            : bottomIconGrey,
                        textColor: bottomBarScreenController.pageIndex.value == 0
                            ? mixBlue
                            : bottomIconGrey,
                      ),

                      buildExpandedWidget(
                        onTap: () async {
                          bottomBarScreenController.pageIndex.value = 1;
                          ReadCallLogsScreenController().onInit();
                        },
                        icon: "assets/homescreen/callLog.png",
                        text: "Call",
                        color: bottomBarScreenController.pageIndex.value == 1
                            ? mixBlue
                            : bottomIconGrey,
                        textColor: bottomBarScreenController.pageIndex.value == 1
                            ? mixBlue
                            : bottomIconGrey,
                      ),
                      bottomBarScreenController.pageIndex.value == 0
                          ? SizedBox(
                              width: Get.width * 0.20,
                            )
                          : const SizedBox(
                              height: 0,
                      ),

                      buildExpandedWidget(
                        onTap: () {
                          bottomBarScreenController.pageIndex.value = 2;
                        },
                        icon: "assets/homescreen/history.png",
                        text: "History",
                        color: bottomBarScreenController.pageIndex.value == 2
                            ? mixBlue
                            : bottomIconGrey,
                        textColor: bottomBarScreenController.pageIndex.value == 2
                            ? mixBlue
                            : bottomIconGrey,
                      ),

                      buildExpandedWidget(
                        onTap: () {
                          bottomBarScreenController.pageIndex.value = 3;
                        },
                        icon: "assets/homescreen/setting.png",
                        text: "Setting",
                        color: bottomBarScreenController.pageIndex.value == 3
                            ? mixBlue
                            : bottomIconGrey,
                        textColor: bottomBarScreenController.pageIndex.value == 3
                            ? mixBlue
                            : bottomIconGrey,
                      ),
                    ],
                  )
                : Row(
                    children: [

                      buildExpandedWidget(
                        onTap: () {
                          bottomBarScreenController.pageIndex.value = 0;
                        },
                        icon: "assets/homescreen/home_icon.png",
                        text: "Home",
                        color: bottomBarScreenController.pageIndex.value == 0
                            ? blueColor
                            : dividerColor,
                        textColor: bottomBarScreenController.pageIndex.value == 0
                            ? blueColor
                            : dividerColor,
                      ),

                      buildExpandedWidget(
                        onTap: () {
                          bottomBarScreenController.pageIndex.value = 1;
                        },
                        icon: "assets/homescreen/history.png",
                        text: "History",
                        color: bottomBarScreenController.pageIndex.value == 1
                            ? blueColor
                            : dividerColor,
                        textColor: bottomBarScreenController.pageIndex.value == 1
                            ? blueColor
                            : dividerColor,
                      ),

                      buildExpandedWidget(
                        onTap: () {
                          bottomBarScreenController.pageIndex.value = 2;
                        },
                        icon: "assets/homescreen/setting.png",
                        text: "Setting",
                        color: bottomBarScreenController.pageIndex.value == 2
                            ? mixBlue
                            : bottomIconGrey,
                        textColor: bottomBarScreenController.pageIndex.value == 2
                            ? mixBlue
                            : bottomIconGrey,
                      ),
                    ],
                  ),
          ),
        ),
      ),
    );
  }

  Widget buildExpandedWidget({onTap, icon, text, color, textColor}) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          color: Colors.transparent,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ImageIcon(
                AssetImage(icon),
                size: 25.0,
                color: color,
              ),
              const SizedBox(
                height: 5.0,
              ),
              Text(
                text,
                style: TextStyle(color: textColor, fontFamily: "Inter-Regular"),
              )
            ],
          ),
        ),
      ),
    );
  }
}
