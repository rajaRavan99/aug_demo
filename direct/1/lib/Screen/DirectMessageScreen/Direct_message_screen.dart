import 'package:auto_size_text/auto_size_text.dart';
import 'package:country_pickers/country_pickers.dart';
import 'package:direct_message/CommonWidget/app_colors.dart';
import 'package:direct_message/CommonWidget/flutter_toast.dart';
import 'package:direct_message/ConstData/colors.dart';
import 'package:direct_message/ConstData/static_data.dart';
import 'package:direct_message/Screen/DirectMessageScreen/Direct_message_screen_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:direct_message/CommonWidget/textfield.dart';
import 'package:get/get.dart';

import '../../CommonWidget/Utils.dart';

enum Options { HowToUse, ShareApp, TermsAndConditions, PrivacyPolicy }

class DirectMessageScreen extends StatelessWidget {
  DirectMessageScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    DirectMessageScreenController directMessageScreenController =
        Get.put(DirectMessageScreenController());
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          elevation: 5.0,
          shadowColor: Colors.grey.withOpacity(0.2),
          backgroundColor: likeWhiteColor,
          centerTitle: true,
          leading: GestureDetector(
            onTap: () {
              Get.back();
              directMessageScreenController.clearText();
            },
            child: Container(
              padding: const EdgeInsets.all(18.0),
              color: Colors.transparent,
              child: Image.asset('assets/arrow_back.png'),
            ),
          ),
          title: Text("Direct Message",
              style: FontStyle.textBlack.copyWith(fontSize: 18)),
        ),
        body: GetBuilder(
          init: directMessageScreenController,
          builder: (directMessageScreenController) {
            return SingleChildScrollView(
              physics: const ClampingScrollPhysics(),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20.0, vertical: 15),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 15),
                    Center(
                      child: AutoSizeText(
                        'You can add any number and it will open in whatsapp without saving to your contacts.',
                        maxLines: 3,
                        style: FontStyle.textGrey
                            .copyWith(color: AppColors.blackColors),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    const SizedBox(height: 15),

                    const Text(
                      'Choose Country',
                      style: TextStyle(
                          fontFamily: "Inter-SemiBold",
                          fontSize: 16,
                          fontWeight: FontWeight.w800),
                    ),

                    const SizedBox(height: 15),

                    Form(
                      key: directMessageScreenController.formGlobalKey,
                      child: Column(
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              InkWell(
                                onTap: () {
                                  directMessageScreenController
                                      .openCountryPickerDialog(context);
                                },
                                child: Obx(
                                  () => Container(
                                    padding: const EdgeInsets.only(
                                        top: 5, bottom: 5, right: 0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: <Widget>[
                                        CountryPickerUtils.getDefaultFlagImage(phoneNumber.value),

                                        const SizedBox(width: 4.0),

                                        Text(
                                            '(${phoneNumber.value.isoCode})'),

                                        const SizedBox(width: 4.0),

                                        Text(
                                          '+${phoneNumber.value.phoneCode}',
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 1,
                                          style: FontStyle.textBlack
                                              .copyWith(fontSize: 12),
                                        ),

                                        const SizedBox(width: 4.0),

                                        SvgPicture.asset(
                                          'assets/homescreen/down_arrow.svg',
                                          width: 7,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),

                              const SizedBox(width: 5.0),

                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.only(right: 8.0),
                                  child: TextFormField(
                                    style: const TextStyle(fontSize: 14),
                                    keyboardType: TextInputType.number,
                                    textInputAction: TextInputAction.next,
                                    controller: addPhoneController,
                                    inputFormatters: <TextInputFormatter>[
                                      FilteringTextInputFormatter.allow(
                                          RegExp(r'[0-9]')),
                                      FilteringTextInputFormatter.digitsOnly
                                    ],
                                    validator: (String? value) {
                                      if (value!.isEmpty) {
                                        return 'Please enter number';
                                      }
                                      return null;
                                    },
                                    cursorColor: AppColors.greyText,
                                    decoration: const InputDecoration(
                                      counterText: "",
                                      enabledBorder: UnderlineInputBorder(
                                        borderSide:
                                            BorderSide(color: dividerColor),
                                      ),
                                      focusedBorder: UnderlineInputBorder(
                                        borderSide:
                                            BorderSide(color: dividerColor),
                                      ),
                                      isDense: true,
                                      contentPadding: EdgeInsets.symmetric(
                                          horizontal: 10, vertical: 8),
                                      errorStyle: TextStyle(
                                          fontFamily: 'Inter-Regular',
                                          fontSize: 15),
                                      hintText: 'Enter Number',
                                      hintStyle: TextStyle(
                                        fontSize: 14,
                                        color: dividerColor,
                                      ),
                                      // filled: true,
                                      fillColor: textfieldfillColor,
                                    ),
                                  ),
                                ),
                              ),

                              Padding(
                                padding: const EdgeInsets.only(right: 15.0),
                                child: GestureDetector(
                                  onTap: () async {
                                    directMessageScreenController
                                        .openContactAppSettings();
                                  },
                                  child: const ImageIcon(
                                    AssetImage("assets/homescreen/contact.png"),
                                    size: 20.0,
                                    color: contactColor,
                                  ),
                                ),
                              ),
                            ],
                          ),

                          const SizedBox(
                            height: 15,
                          ),

                          Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(11),
                                border: Border.all(color: AppColors.greyText)),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(11),
                              child: TextFormField(
                                controller: addMsgController,
                                style: const TextStyle(
                                  fontSize: 18,
                                ),
                                textInputAction: TextInputAction.done,
                                maxLines: 5,
                                cursorColor: blackColor,
                                decoration: const InputDecoration(
                                  contentPadding:
                                      EdgeInsets.only(left: 15.0, top: 10.0),
                                  hintText: 'Message (optional)',
                                  hintStyle: TextStyle(
                                    fontSize: 14,
                                    color: dividerColor,
                                  ),
                                  fillColor: textfieldfillColor,
                                  filled: true,
                                  border: InputBorder.none,
                                ),
                              ),
                            ),
                          ),

                          const SizedBox(height: 20),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                color: dividerColor,
                                height: 1.0,
                                width: Get.width * 0.10,
                              ),
                              const Padding(
                                padding: EdgeInsets.only(left: 7.0, right: 7.0),
                                child: Text(
                                  'OR',
                                  style: TextStyle(color: dividerColor),
                                ),
                              ),
                              Container(
                                color: dividerColor,
                                height: 1.0,
                                width: Get.width * 0.10,
                              ),
                            ],
                          ),

                          const SizedBox(height: 20),

                          GestureDetector(
                            onTap: () {
                              directMessageScreenController
                                  .navigateToCustomMessageScreen();
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                border: Border.all(color: gryColor, width: 1.0),
                                borderRadius: BorderRadius.circular(11.0),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.only(left: 15),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Image.asset(
                                      'assets/chatIcon.png',
                                      width: 30.0,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 8.0),
                                      child: Text(
                                        'Select from custom message',
                                        overflow: TextOverflow.ellipsis,
                                        style: FontStyle.textBlack.copyWith(
                                            color: blackText, fontSize: 13),
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        directMessageScreenController
                                            .navigateToCustomMessageScreen();
                                      },
                                      child: Container(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 13, vertical: 17),
                                        alignment: Alignment.center,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          color: Colors.blue,
                                          gradient: const LinearGradient(
                                            begin: Alignment.centerLeft,
                                            end: Alignment.centerRight,
                                            colors: [
                                              blueColor,
                                              linerSecondColor
                                            ],
                                          ),
                                        ),
                                        child: Image.asset(
                                          'assets/homescreen/rightsidearrow.png',
                                          width: 21,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),

                          SizedBox(height: Get.height / 10),

                          Row(
                            children: [
                              Expanded(
                                child: GestureDetector(
                                  onTap: () {
                                    FocusManager.instance.primaryFocus
                                        ?.unfocus();
                                    directMessageScreenController
                                        .sendMsg.value = true;
                                    if (addPhoneController.text.isEmpty) {
                                      flutterToast(text: 'Please Enter number');
                                    } else {
                                      directMessageScreenController
                                          .openWhatsapp();
                                      directMessageScreenController.addData();
                                    }
                                    // if (directMessageScreenController
                                    //         .formGlobalKey.currentState!
                                    //         .validate() &&
                                    //     addPhoneController.text != null) {
                                    //   directMessageScreenController.openWhatsapp();
                                    //   directMessageScreenController.addData();
                                    // }
                                  },
                                  child: Utils().containerButton('SEND'),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
