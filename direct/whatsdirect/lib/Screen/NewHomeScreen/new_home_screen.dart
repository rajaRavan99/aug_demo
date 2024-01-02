import 'dart:io';
import 'package:direct_message/CommonWidget/textfield.dart';
import 'package:direct_message/ConstData/colors.dart';
import 'package:direct_message/Screen/NewHomeScreen/new_home_screen_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NewHomeScreen extends StatelessWidget {
  NewHomeScreen({Key? key}) : super(key: key);

  final NewHomeScreenController newHomeScreenController = Get.put(NewHomeScreenController());

  @override
  Widget build(BuildContext context) {
    newHomeScreenController.buildContext = context;

    return WillPopScope(
      onWillPop: () {
        newHomeScreenController.showExitPopup();
        return Future.value(true);
      },
      child: SafeArea(
        child: Scaffold(
          backgroundColor: whiteColor,
          appBar: AppBar(
            elevation: 5.0,
            shadowColor: Colors.grey.withOpacity(0.2),
            backgroundColor: likeWhiteColor,
            centerTitle: true,
            title: Text(
              "What's Tools",
              style: FontStyle.textBlack.copyWith(fontSize: 18)
            ),
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 10.0,left: 15,right: 10),
              child: Column(
                children: [
                  SizedBox(
                    height: Get.height / 40,
                  ),

                  GridView.builder(
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 15.0,
                      mainAxisSpacing: 15.0,
                      childAspectRatio: 1.6,
                    ),
                    // padding: const EdgeInsets.only(left:20,right: 15),
                    itemCount: newHomeScreenController.homeList.length,
                    shrinkWrap: true,
                    physics: const ClampingScrollPhysics(),
                    itemBuilder: (context, index) {
                      var data = newHomeScreenController.homeList[index];
                      return GestureDetector(
                        onTap: () {
                          newHomeScreenController.isSelected[index] = !newHomeScreenController.isSelected[index];
                          newHomeScreenController.onTapIndex(index);
                          Future.delayed(const Duration(milliseconds: 200)).then((value) => newHomeScreenController.isSelected[index] = false);
                        },
                        child: Stack(
                          children: [

                            Container(
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                child: Image.asset(
                                  data.background.toString(),
                                  fit: BoxFit.fill,
                                ),
                            ),

                            Padding(
                              padding: EdgeInsets.only(top: 10.0, left: index == 0 ? 14.0 : 10.0),
                              child: SizedBox(
                                height: Get.height * 0.08,
                                child: Image.asset(
                                  data.icon.toString(),
                                ),
                              ),
                            ),

                            Positioned(
                              bottom: 10.0,
                              right: 20.0,
                              child: Text(
                                  data.title.toString(),
                                style: FontStyle.textLabelWhite.copyWith(fontSize: 16),
                                textAlign: TextAlign.right,
                              ),
                            ),

                          ],
                        ),
                      );
                    },
                  ),

                  Platform.isAndroid ? const SizedBox(
                    height: 20.0,
                  ) : const SizedBox(
                    height: 40.0,
                  ),

                  Platform.isIOS ? GestureDetector(
                    onTap: () {
                      newHomeScreenController.navigateToHowToUsePage();
                      },
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(11),
                        gradient: const LinearGradient(
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                          colors: [blueColor, linerSecondColor],
                        ),
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 35,vertical: 15),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text('How to use',
                            style: FontStyle.textBlack.copyWith(color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                  ) : const SizedBox.shrink()
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

