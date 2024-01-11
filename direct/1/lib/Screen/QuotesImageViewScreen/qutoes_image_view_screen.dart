import 'package:direct_message/CommonWidget/app_colors.dart';
import 'package:direct_message/ConstData/colors.dart';
import 'package:direct_message/Screen/QuotesImageViewScreen/qutoes_image_view_screen_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../CommonWidget/Utils.dart';

class QuotesViewScreen extends StatelessWidget {
   QuotesViewScreen({Key? key}) : super(key: key);

   final QuotesViewScreenController quotesViewScreenController = Get.put(QuotesViewScreenController());

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: (){
        if(quotesViewScreenController.isBackButton.value){
          return Future.value(false);
        } else{
          return Future.value(true);
        }
      },
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            elevation: 0.0,
            backgroundColor: likeWhiteColor,


            leading: Utils().arrowBackAppBar(),
            actions: [
              GestureDetector(
                onTap: () async {
                  // quotesViewScreenController.shareImages();
                  quotesViewScreenController.shareImage(context);
                },
                child: Padding(
                  padding: const EdgeInsets.only(left: 10.0,right: 0.0,top: 10.0,bottom: 10.0),
                  child: Image.asset("assets/quotesScreen/share1.png")
                ),
              ),
              GestureDetector(
                    onTap: () async {
                      quotesViewScreenController.permissionHandler();
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(left: 10.0,right: 10.0,top: 10.0,bottom: 10.0),
                      child: Image.asset("assets/quotesScreen/download1.png"),
                ),
              ),
            ],
          ),
          body:Center(
            child: SizedBox(
              child: Image.network(quotesViewScreenController.imageLink,
                loadingBuilder: (context, child, loadingProgress) {
                if(loadingProgress == null) return child;
                return const Center(
                  child: Padding(
                    padding: EdgeInsets.all(150.0),
                    child: CircularProgressIndicator(color: AppColors.circularColor,),
                  ),
                );
              },
                ),
            ),
          ),
        ),
      ),
    );
  }

}
