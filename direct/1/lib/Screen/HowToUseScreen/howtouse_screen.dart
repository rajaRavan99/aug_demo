import 'package:direct_message/CommonWidget/textfield.dart';
import 'package:direct_message/ConstData/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../ConstData/static_data.dart';
import 'howtouse_screen_controller.dart';

class HowToUseScreen extends StatelessWidget {
  HowToUseScreen({Key? key}) : super(key: key);

  final HowToUseScreenController howToUseScreenController = Get.put(HowToUseScreenController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white ,
        body: Column(
          children: [
            const SizedBox(height: 10.0),
            Stack(
              children: [
                const SizedBox(height: 10,),

                Container(
                  padding: const EdgeInsets.only(left: 50.0,right: 50.0,top: 30.0,bottom: 30.0),
                  // margin: const EdgeInsets.only(top: 25.0),
                  width: double.infinity,
                  child: Image.asset(
                    'assets/howtouseScreen/how_to_use.png',
                  ),
                ),

                isHowToUseScreen == false ? Positioned(
                  top: 35.0,
                  left: 12.0,
                  child: GestureDetector(
                    onTap: () {
                      Get.back();
                    },
                    child: Container(
                      padding: const EdgeInsets.all(5.0),
                      color: Colors.transparent,
                      child: Image.asset('assets/arrow_back.png',
                        width: 25,),
                    ),
                  ),
                ) : const SizedBox(),
              ],
            ),

            Expanded(
              child: Stack(
                fit: StackFit.expand,
                children: [

                  Image.asset(
                    'assets/howtouseScreen/curve.png',
                    fit: BoxFit.fill,
                  ),

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children:  [
                        // SizedBox(height: Get.height * 0.10),\
                        const Padding(
                          padding: EdgeInsets.only(bottom: 15),
                          child: Text(
                            'HOW TO USE',
                            style: TextStyle(
                                fontFamily: "Inter-SemiBold",
                                fontSize: 25,
                                color: Colors.white
                            ),
                          ),
                        ),

                        const SizedBox(height: 10),

                        Text(
                          'Direct Message provides you to send a whatsapp message without saving the contact number.',
                          style: FontStyle.textLabelWhite.copyWith(
                            fontWeight: FontWeight.w400,
                          ),
                          textAlign: TextAlign.center,
                        ),

                        const SizedBox(height: 10,),

                        Text(
                          'First select country code and enter whatsapp number to send whatsapp message.',
                          textAlign: TextAlign.center,
                          style: FontStyle.textLabelWhite.copyWith(
                            fontWeight: FontWeight.w400,
                          ),
                        ),

                        const SizedBox(height: 10,),

                      ],
                    ),
                  ),

                  isHowToUseScreen? Positioned(
                    bottom: 0.0,
                    right: 15.0,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        GestureDetector(
                          onTap: () {
                            howToUseScreenController.navigateToHomeScreen();
                          },
                          child: Container(
                            margin: const EdgeInsets.only(bottom: 20.0),
                            padding: const EdgeInsets.only(left: 9.0),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10.0),
                                border: Border.all(color: whiteColor, width: 2.0)),
                            child: Row(
                              children: const [
                                Text(
                                  "NEXT",
                                  style: TextStyle(
                                      fontFamily: "Inter-SemiBold",
                                      color: whiteColor,
                                      fontSize: 17.0),
                                ),
                                Icon(
                                  Icons.arrow_right_alt_sharp,
                                  color: whiteColor,
                                  size: 30.0,
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ) : const SizedBox(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
