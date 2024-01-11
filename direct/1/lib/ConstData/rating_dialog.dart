import 'dart:io';
import 'package:direct_message/CommonWidget/flutter_toast.dart';
import 'package:direct_message/Screen/NewHomeScreen/new_home_screen_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animated_dialog/flutter_animated_dialog.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import 'colors.dart';

Future ratingDialog(BuildContext? homebuildContext) {
  RxDouble ratings = 0.0.obs;
  bool openPlayStore = false;
  return showAnimatedDialog(
      context: homebuildContext!,
      barrierDismissible: true,
      animationType: DialogTransitionType.slideFromLeft,
      curve: Curves.fastOutSlowIn,
      duration: const Duration(milliseconds: 500),
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(10.0),
                ),
              ),
              contentPadding: const EdgeInsets.all(20.0),
              content: Obx(() => Container(
                    width: double.infinity,
                    child: SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          ratings.value == 0.0
                              ? Image.asset(
                                  'assets/dialogImage/rate_emoji_rate_4.png',
                                  height: 60.0)
                              : ratings.value == 5.0
                                  ? Image.asset(
                                      'assets/dialogImage/rate_emoji_5star.png',
                                      height: 60.0)
                                  : ratings.value == 4.0
                                      ? Image.asset(
                                          'assets/dialogImage/rate_emoji_4star.png',
                                          height: 60.0)
                                      : ratings.value == 3.0
                                          ? Image.asset(
                                              'assets/dialogImage/rate_emoji_3star.png',
                                              height: 60.0)
                                          : ratings.value == 2.0
                                              ? Image.asset(
                                                  'assets/dialogImage/rate_emoji_2star.png',
                                                  height: 60.0)
                                              : ratings.value == 1.0
                                                  ? Image.asset(
                                                      'assets/dialogImage/rate_emoji_1star.png',
                                                      height: 60.0)
                                                  : Container(),
                          const SizedBox(height: 10.0),
                          ratings.value == 0.0
                              ? const Text(
                                  'We are working hard for a better user experience.',
                                  style: TextStyle(
                                    fontFamily: 'Inter-Regular',
                                    fontWeight: FontWeight.w500,
                                  ),
                                  textAlign: TextAlign.center,
                                )
                              : Center(
                                  child: Text(
                                    ratings.value > 3.0
                                        ? 'We like you too!'
                                        : 'Oh, no!',
                                    style: const TextStyle(
                                      fontFamily: 'Inter-Regular',
                                      fontWeight: FontWeight.w500,
                                      fontSize: 25.0,
                                    ),
                                  ),
                                ),
                          const SizedBox(height: 10.0),
                          ratings.value == 0.0
                              ? const Text(
                                  'We had greatly appreciate if you can rate us.',
                                  style: TextStyle(
                                    fontFamily: 'Inter-Regular',
                                    fontWeight: FontWeight.w500,
                                  ),
                                  textAlign: TextAlign.center,
                                )
                              : Text(
                                  ratings.value > 3.0
                                      ? 'Thank you for your feedback.'
                                      : 'Please leave us some feedback.',
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                      fontSize: 17.0,
                                      fontFamily: 'Inter-Regular',
                                      fontWeight: FontWeight.w500),
                                ),
                          const SizedBox(height: 15.0),
                          FittedBox(
                            fit: BoxFit.fitWidth,
                            child: RatingBar.builder(
                              initialRating: 0,
                              minRating: 0,
                              direction: Axis.horizontal,
                              allowHalfRating: false,
                              itemCount: 5,
                              itemPadding: const EdgeInsets.symmetric(horizontal: 7.0),
                              itemBuilder: (context, _) => const Icon(
                                Icons.star,
                                color: Colors.amber,
                              ),
                              onRatingUpdate: (rating) {
                                ratings.value = rating;
                                print('ratings======>$ratings');
                              },
                            ),
                          ),
                          const SizedBox(height: 15.0),
                          ratings.value == 5.0
                              ? Text(
                                  Platform.isAndroid
                                      ? 'Please leave your review \n on Google Play'
                                      : 'Please leave your review \n on App Store',
                                  style: const TextStyle(
                                    fontSize: 18.0,
                                    fontFamily: 'Inter-Regular',
                                    fontWeight: FontWeight.w500,
                                  ),
                                  textAlign: TextAlign.center,
                                )
                              : Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Text(
                                      'The best we can get.',
                                      style: TextStyle(
                                          fontSize: 18.0,
                                          fontFamily: 'Inter-Regular',
                                          fontWeight: FontWeight.w500),
                                    ),
                                    const SizedBox(width: 15.0),
                                    Image.asset(
                                        'assets/dialogImage/ic_arrow_rate.png',
                                        height: 30.0)
                                  ],
                                ),
                          const SizedBox(height: 15.0),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8.0, vertical: 5.0),
                            child: InkWell(
                              onTap: () {
                                if(ratings.value != 0){
                                  setState(() {
                                    Get.back();
                                    print('openPlayStore');
                                    ratings.value == 5.0
                                        ? openPlayStore = true
                                        : openPlayStore = false;
                                    if (openPlayStore == true) {
                                      saveBoolStoreOpen(openPlayStore).then((value) {
                                        NewHomeScreenController().checkAppUpdate();
                                      });
                                    } else {
                                      NewHomeScreenController().checkAppUpdate();
                                    }
                                    ratings.value == 5.0
                                        ? Platform.isAndroid
                                        ? launchURL(
                                        'https://play.google.com/store/apps/details?id=com.directmessage.directchat')
                                        : Container()
                                        : reviewDialog(context);
                                  });
                                }
                              },
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20.0, vertical: 15.0),
                                decoration: BoxDecoration(
                                  gradient: const LinearGradient(
                                    begin: Alignment.centerLeft,
                                    end: Alignment.centerRight,
                                    colors: [blueColor, linerSecondColor],
                                  ),
                                  color: greenColor,
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                child: Center(
                                  child: FittedBox(
                                    fit: BoxFit.fitWidth,
                                    child: Text(
                                      ratings.value == 5.0
                                          ? (Platform.isAndroid
                                              ? 'RATE ON GOOGLE PLAY'
                                              : 'RATE ON APP STORE')
                                          : 'RATE',
                                      style: TextStyle(
                                        color: ratings.value == 0 ? Colors.white.withOpacity(0.5) : Colors.white,
                                        fontSize: 18.0,
                                        fontFamily: 'Inter-Regular',
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  )),
            );
          },
        );
      });
}

launchURL(String url) async {
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}

RxBool playStoreOpen = false.obs;

Future<void> getBoolStoreOpen() async {
  final prefs = await SharedPreferences.getInstance();
  playStoreOpen.value = await prefs.getBool('playStoreOpen') ?? false;
}

Future<void> saveBoolStoreOpen(playStore) async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.setBool('playStoreOpen', playStore);
}

Future reviewDialog(BuildContext context) {
  TextEditingController feedBackController = TextEditingController();
  List checkListItems = [
    {
      'id': 0,
      'value': false,
      'title': "I don't like the design",
    },
    {
      'id': 1,
      'value': false,
      'title': "It doesn't have the function I need",
    },
    {
      'id': 2,
      'value': false,
      'title': "It's not easy to use",
    },
    {
      'id': 3,
      'value': false,
      'title': "It's too complicated",
    },
  ];

  List addFeedBackList = [];
  
  checkListItems.where((element) {
    print("value =====>${element["value"] != false}");
   return element["value"] != false;
  } );
  
  return showAnimatedDialog(
      context: context,
      barrierDismissible: true,
      animationType: DialogTransitionType.slideFromLeft,
      curve: Curves.fastOutSlowIn,
      duration: const Duration(milliseconds: 500),
      builder: (BuildContext context) {
        return StatefulBuilder(builder: (context, setState) {
          return AlertDialog(
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10.0))),
              contentPadding: const EdgeInsets.all(20.0),
              content: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: const [
                      Text(
                        'Your feedback is useful.',
                        style: TextStyle(
                          fontFamily: 'Inter-Regular',
                          fontSize: 21.0,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10.0),
                  Column(
                      children: List.generate(
                        checkListItems.length,
                            (index) => Column(
                          children: [
                            CheckboxListTile(
                              checkColor: Colors.white,
                              activeColor: blueColor,
                              controlAffinity: ListTileControlAffinity.leading,
                              contentPadding: EdgeInsets.zero,
                              dense: true,
                              title: Text(
                                checkListItems[index]["title"],
                                style: const TextStyle(
                                  fontSize: 16.0,
                                ),
                              ),
                              value: checkListItems[index]["value"],
                              onChanged: (bool? value) {
                                setState(() {
                                  checkListItems[index]["value"] = value;
                                  if (addFeedBackList.contains(checkListItems[index])) {
                                    addFeedBackList.remove(checkListItems[index]);
                                  } else {
                                    addFeedBackList.add(checkListItems[index]);
                                  }
                                });
                              },
                            ),
                          ],
                        ),
                      ),
                  ),
                  const SizedBox(height: 10.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: const [
                      Text(
                        'Others :',
                        style: TextStyle(
                          fontFamily: 'Inter-Regular',
                          fontSize: 20.0,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10.0),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    child: TextField(
                      controller: feedBackController,
                      maxLines: 4,
                      minLines: 4,
                      style: const TextStyle(
                        fontFamily: 'Inter-Regular',
                        fontSize: 20.0,
                        fontWeight: FontWeight.w400,
                      ),
                      decoration: const InputDecoration(
                        contentPadding: EdgeInsets.all(5.0),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            width: 1.0,
                            // color: context.t.dividerColor.withOpacity(0.6)
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(width: 1.0),
                        ),
                      ),
                      onChanged: (str) {},
                    ),
                  ),
                  const SizedBox(height: 15.0),
                  Row(
                    children: [
                      Expanded(
                        child: InkWell(
                          onTap: () {
                            Get.back();
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(vertical: 10.0),
                            decoration: BoxDecoration(
                              gradient: const LinearGradient(
                                begin: Alignment.centerLeft,
                                end: Alignment.centerRight,
                                colors: [blueColor, linerSecondColor],
                              ),
                              color: grayColor,
                              borderRadius: BorderRadius.circular(5.0),
                            ),
                            child: const Center(
                              child: Text(
                                'CANCEL',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18.0,
                                  fontFamily: 'Inter-Regular',
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 10.0),
                      Expanded(
                        child: InkWell(
                          onTap: () {
                            playStoreOpen.value = true;
                            addFeedBackList.isEmpty ? flutterToast(text: 'Please Give Feedback') : Get.back();
                            // addFeedBackList.isNotEmpty && feedBackController.text.isEmpty && feedBackController.text != ""? flutterToast(text: 'Enter Your FeedBack') : Get.back();
                            // if(addFeedBackList.isEmpty){
                            //   flutterToast(text: 'Enter Your FeedBack');
                            // }
                            // else if(addFeedBackList.isNotEmpty && feedBackController.text.isEmpty){
                            //   Get.back();
                            // }
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(vertical: 10.0),
                            decoration: BoxDecoration(
                              gradient: const LinearGradient(
                                begin: Alignment.centerLeft,
                                end: Alignment.centerRight,
                                colors: [blueColor, linerSecondColor],
                              ),
                              color: greenColor,
                              borderRadius: BorderRadius.circular(5.0),
                            ),
                            child: const Center(
                              child: Text(
                                'SUBMIT',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18.0,
                                  fontFamily: 'Inter-Regular',
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        });
      });
}

