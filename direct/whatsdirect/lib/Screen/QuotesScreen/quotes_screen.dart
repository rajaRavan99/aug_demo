
import 'package:direct_message/CommonWidget/app_colors.dart';
import 'package:direct_message/CommonWidget/textfield.dart';
import 'package:direct_message/ConstData/colors.dart';
import 'package:direct_message/Screen/QuotesScreen/quotes_screen_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../CommonWidget/Utils.dart';

class QuotesScreen extends StatelessWidget {
   QuotesScreen({Key? key}) : super(key: key);

  final QuotesScreenController quotesScreenController = Get.put(QuotesScreenController());

  @override
  Widget build(BuildContext context) {

    quotesScreenController.buildContext = context;

    return SafeArea(
      child: Scaffold(
        backgroundColor: whiteColor,
        appBar: AppBar(
            elevation: 5.0,
            shadowColor: Colors.grey.withOpacity(0.2),
            backgroundColor: likeWhiteColor,
            centerTitle: true,
            title: const Text(
              'Quotes',
              style: FontStyle.textBlack
          ),
          leading: Utils().arrowBackAppBar()
        ),

        body: SafeArea(
          child: Obx(() => Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 10),
            child: quotesScreenController.quotesList.isEmpty ? const Center(child: CircularProgressIndicator(color:  AppColors.circularColor,)):
            GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 15.0,
                  mainAxisSpacing: 15.0),
              itemCount: quotesScreenController.quotesList.value.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                onTap: () {
                  print('On ta[');
                  var imageLink = "http://phpstack-165541-2007025.cloudwaysapps.com/public/${quotesScreenController.quotesList[index]["image"]}";
                  quotesScreenController.navigatorToQuotesViewScreen(image: imageLink);
                },
                child:  ClipRRect(
                  borderRadius: BorderRadius.circular(15.0),
                  child: Container(
                    color: grayColor,
                    child: Image.network(
                      "http://phpstack-165541-2007025.cloudwaysapps.com/public/${quotesScreenController.quotesList[index]["thumbnail_image"]}",
                      fit: BoxFit.cover,
                      loadingBuilder: (context, child, loadingProgress) {
                        if(loadingProgress == null) return child;
                        return const Center(child: CircularProgressIndicator(color: AppColors.circularColor,));
                      },
                    ),
                  ),
                ),
                );
              },
            ),
          )),
        ),
      ),
    );
  }
}
