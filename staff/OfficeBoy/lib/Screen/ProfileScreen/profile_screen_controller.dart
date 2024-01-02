// import 'dart:developer';
// import 'package:firebase_database/firebase_database.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:flutter/services.dart';
// import 'package:image_picker/image_picker.dart';
//
// // import '../../CommonWidget/api.dart';
// import '../../Routes/routes.dart';
// import '../../models/chat_user.dart';
// class ProfilePageController extends GetxController{
//
//   // static ProfilePageController get to => Get.find<ProfilePageController>();
//
//   ChatUser user = ChatUser();
//
//
//   String? _image;
//   String? pickedImage;
//
//   TextEditingController emailController = TextEditingController();
//   TextEditingController nameController = TextEditingController();
//
//   DatabaseReference reference = FirebaseDatabase.instance.ref().child('users');
//   DatabaseReference upDate = FirebaseDatabase.instance.ref();
//
//
//
//   @override
//   void onInit() {
//     // nameController.text = Get.find(tag: "name");
//     // emailController.text = Get.find(tag: "email");
//     super.onInit();
//   }
//
//   void updateData(){
//     print('----update----->');
//     reference.update({
//       'name': nameController.text,
//       'email': emailController.text,
//     });
//     print('----updateSuccessFull----->');
//
//   }
//
//
//   navigateToProfile() {
//     Get.toNamed(AppRoutes.profilePage);
//   }
//
//   navigateToUserProfile() {
//     Get.toNamed(AppRoutes.userProfile);
//   }
//
//   void showBottomSheet(context) {
//     showModalBottomSheet(
//         shape: const RoundedRectangleBorder(
//           borderRadius: BorderRadius.only(
//             topRight: Radius.circular(20),
//             topLeft: Radius.circular(20),
//           ),
//         ),
//         context: context,
//         builder: (_) {
//           return ListView(
//             shrinkWrap: true,
//             padding:
//             EdgeInsets.only(top: Get.height * .03, bottom: Get.height * .05),
//             children: [
//               const Text(
//                 "Pick Profile Picture",
//                 style: TextStyle(
//                   fontSize: 18,
//                   letterSpacing: 2,
//                   fontWeight: FontWeight.w500,
//                   color: Colors.black87,
//                 ),
//                 textAlign: TextAlign.center,
//               ),
//               SizedBox(
//                 height: Get.height * .02,
//               ),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                 children: [
//                   ElevatedButton(
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: Colors.white,
//                       shape: const CircleBorder(),
//                       fixedSize: Size(Get.width * .3, Get.height * .15),
//                     ),
//                     onPressed: () async {
//                       Get.back();
//                       final ImagePicker picker = ImagePicker();
//                       // Pick an image
//
//                       final XFile? image = await picker.pickImage(
//                           source: ImageSource.gallery, imageQuality: 80);
//                       if (image != null) {
//                         pickedImage = image.path.obs.toString();
//                         log('Image Path: ${image.path} -- MimeType: ${image.mimeType}');
//                         // Apis.updateProfilePicture(File(_image!));
//                       }
//                       update();
//                     },
//                     child: Image.asset('assets/images/image.png'),
//                   ),
//                   ElevatedButton(
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: Colors.white,
//                       shape: const CircleBorder(),
//                       fixedSize: Size(Get.width * .3, Get.height * .15),
//                     ),
//                     onPressed: () async {
//                       final ImagePicker picker = ImagePicker();
//                       // Pick an image
//                       final XFile? image = await picker.pickImage(
//                           source: ImageSource.camera, imageQuality: 80);
//                       if (image != null) {
//                         log('Image Path: ${image.path}');
//
//                         // Apis.updateProfilePicture(File(_image!));
//
//                         Get.back();
//                       }
//                     },
//                     child: Image.asset('assets/images/camera.png'),
//                   ),
//                 ],
//               ),
//             ],
//           );
//         });
//   }
// }