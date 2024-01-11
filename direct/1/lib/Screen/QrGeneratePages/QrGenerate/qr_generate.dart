import 'package:direct_message/CommonWidget/Utils.dart';
import 'package:direct_message/CommonWidget/textfield.dart';
import 'package:direct_message/ConstData/colors.dart';
import 'package:direct_message/Screen/QrGeneratePages/QrGenerate/qr_generate_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class QrGenerate extends StatelessWidget {
  QrGenerate( {Key? key,}) : super(key: key);

  final QrGenerateController qrGenerateController = Get.put(QrGenerateController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          elevation: 5.0,
          shadowColor: Colors.grey.withOpacity(0.2),
          backgroundColor: likeWhiteColor,
          centerTitle: true,
          title:  Text(
              qrGenerateController.name,
            style: FontStyle.textBlack
          ),
          leading: Utils().arrowBackAppBar(),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          child: Form(
            key: qrGenerateController.formKey,
            child: SingleChildScrollView(
              child: GetBuilder(
                init: qrGenerateController,
                builder: (QrGenerateController controller) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[

                        SizedBox(
                          height: Get.height / 25,
                        ),

                        listOfWidget(),

                        SizedBox(
                          height: Get.height / 5,
                        ),

                      ],
                    ),
                  );
                },
              ),
            ),
          ),
        ),

        bottomNavigationBar: GestureDetector(
            onTap: () {
              if(qrGenerateController.formKey.currentState!.validate())
                {
                  qrGenerateController.generateQr();
                }
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 5,horizontal: 15),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [

                  Utils().containerButton('GENERATE QR CODE',),

                ],
              ),
            ),
        ),
      ),
    );
  }

  Widget textWidget () {
    return Utils.textFormField('Text:', qrGenerateController.textController,TextInputAction.done);
  }

  Widget urlWidget () {
    return Utils.textFormField('https://', qrGenerateController.urlController,TextInputAction.done);
  }

  Widget contactWidget () {
    return Column(
      children: [

        Utils.textFormField('Full Name:', qrGenerateController.cFullNameController,TextInputAction.next),

        const SizedBox(height: 10,),

        Utils.textFormField('Address:', qrGenerateController.cAddressController,TextInputAction.next),

        const SizedBox(height: 10,),

        Utils.textFormField('Phone:', qrGenerateController.cPhoneController,TextInputAction.next),

        const SizedBox(height: 10,),

        Utils.textFormField('Email:', qrGenerateController.cEmailController,TextInputAction.next),

        const SizedBox(height: 10,),

        Utils.textFormField('Note:', qrGenerateController.cNoteController,TextInputAction.done),

      ],
    );
  }

  Widget emailWidget () {
    return Column(
      children: [
        Utils.textFormField('Email:', qrGenerateController.emailController,TextInputAction.next),

        const SizedBox(height: 10,),

        Utils.textFormField('Subject:', qrGenerateController.subjectController,TextInputAction.next),

        const SizedBox(height: 10,),

        Utils.textFormField('Body:', qrGenerateController.bodyController,TextInputAction.done),
      ],
    );
  }

  Widget smsWidget () {
    return Column(
      children: [

        Utils.textFormField('Phone:', qrGenerateController.sPhoneController,TextInputAction.next),

        const SizedBox(height: 10,),

        Utils.textFormField('Message', qrGenerateController.sMessageController,TextInputAction.done),

      ],
    );
  }

  Widget geoWidget () {
    return Column(
      children: [
        Utils.textFormField('Latitude:', qrGenerateController.latitudeController,TextInputAction.next),

        const SizedBox(height: 10,),

        Utils.textFormField('Longitude:', qrGenerateController.longitudeController,TextInputAction.done),

      ],
    );
  }

  Widget phoneWidget () {
    return Column(
      children: [
        Utils.textFormField('Phone:', qrGenerateController.phoneController,TextInputAction.done),
      ],
    );
  }

  Widget wifiWidget () {
    return Column(
      children: [
        Utils.textFormField('SSID/Network name:', qrGenerateController.networkNameController,TextInputAction.next),

        const SizedBox(height: 10,),

        Utils.textFormField('Password:', qrGenerateController.passwordController,TextInputAction.done),

      ],
    );
  }

  listOfWidget() {
    String name = qrGenerateController.name;
    switch(name){
      case'Text' : return textWidget();
      case'URL' : return urlWidget();
      case'Contact' : return contactWidget();
      case'Email' : return emailWidget();
      case'SMS' : return smsWidget();
      case'Geo' : return geoWidget();
      case'Phone' : return phoneWidget();
      case'wifi' : return wifiWidget();
    }
  }
}

