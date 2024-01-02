// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:officeboy/CommonWidget/textfield.dart';
// import 'package:officeboy/Screen/Profile/profile_screen_controller.dart';
//
// import '../../CommonWidget/app_colors.dart';
// import '../Login/SignUp/sign_up_screen_controller.dart';
//
// class ProfilePage extends StatelessWidget {
//
//    ProfilePage({Key? key, required this.email,required this.name, }) : super(key: key);
//    final String email;
//    final String name;
//
//   ProfilePageController profilePageController  = ProfilePageController();
//
//   @override
//   Widget build(BuildContext context) {
//     profilePageController.emailController.text =  email;
//     profilePageController.nameController.text = name;
//
//     return Scaffold(
//
//       bottomNavigationBar: InkWell(
//         onTap: () async{
//           // Get.off(AppRoutes.loginPageFirebase);
//         },
//         child: Container(
//           height: context.height / 15,
//           width: context.width * 0.60 ,
//           margin: const EdgeInsets.symmetric(horizontal: 15,vertical: 10),
//           decoration:  BoxDecoration(
//             color: AppColors.primaryColor,
//               borderRadius: BorderRadius.circular(15),
//           ),
//           child:  Center(
//               child:  Text('Log Out',
//                 style: FontStyle.statusTextGreen,
//               ),
//           ),
//         ),
//       ),
//
//       appBar: AppBar(
//         centerTitle: true,
//           title: Text('Profile',style: FontStyle.appBarText.copyWith(fontSize: 20),
//           ),
//       ),
//
//       body: SafeArea(
//         child: Padding(
//           padding: const EdgeInsets.symmetric(horizontal:   8.0),
//           child: SingleChildScrollView(
//             child: Column(
//               children: [
//
//                 const SizedBox(height: 15),
//
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//
//                     Stack(
//                       children: [
//
//                         CachedNetworkImage(
//                           imageUrl: "${FirebaseAuth.instance.currentUser?.photoURL}",
//                           placeholder: (context, url) => const CircularProgressIndicator(),
//                           errorWidget: (context, url, error) =>  Icon(Icons.account_circle_outlined,
//                             size: Get.height *  0.15,),
//                         ),
//
//                          Positioned(
//                           bottom: 0,
//                           right: 10,
//                           child: Card(
//                             shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50),),
//                             child: const Padding(
//                               padding:  EdgeInsets.all(5.0),
//                               child:  Icon(
//                                 Icons.edit,size: 15,
//                                 color: Colors.blue,
//                               ),
//                             ),
//                           ),
//                         )
//                         ,
//                       ],
//                     ),
//
//
//
//                   ],
//                 ),
//
//
//                 const SizedBox(height: 10),
//
//                 TextFormField(
//                   // initialValue: email,
//                   controller: profilePageController.emailController,
//                   // onSaved: (val) => Apis.chatUser.email = val ?? "",
//                   validator: (val) =>
//                   val != null && val.isNotEmpty ? null : 'Required Field',
//                   decoration: InputDecoration(
//                     prefixIcon: const Icon(
//                       Icons.person,
//                       color: Colors.green,
//                     ),
//                     border: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(12),
//                     ),
//                     hintText: 'eg: Kapil Sharma',
//                     label: const Text("Email"),
//                   ),
//                 ),
//
//                 const SizedBox(height: 10),
//
//                 TextFormField(
//                   initialValue: FirebaseAuth.instance.currentUser?.displayName,
//                   // controller: profilePageController.nameController,
//                   // onSaved: (val) => Apis.chatUser.name = val ?? "",
//                   validator: (val) =>
//                   val != null && val.isNotEmpty ? null : 'Required Field',
//                   decoration: InputDecoration(
//                     prefixIcon: const Icon(
//                       Icons.person,
//                       color: Colors.green,
//                     ),
//                     border: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(12),
//                     ),
//                     hintText: 'eg: Kapil Sharma',
//                     label: const Text("name"),
//                   ),
//                 ),
//
//                 const SizedBox(height: 10),
//
//                 InkWell(
//                   onTap: () {
//                     // profilePageController.updateData();
//
//                     Map<String, String> user = {
//                       'name': profilePageController.nameController.text,
//                       'email': profilePageController.emailController.text,
//                     };
//
//                     profilePageController.upDate.child('users').update(user);
//
//                     // Apis.updateUserInfo().then((value) {
//                     //   print('--------------- Update f call');
//                     //   Get.snackbar(
//                     //     "Data Updated SuccessFully",
//                     //     "",
//                     //     backgroundColor: AppColors.primaryColor,
//                     //     snackPosition: SnackPosition.TOP,
//                     //   );
//                     //   Get.back();
//                     // });
//
//                   },
//                   child: Container(
//                     height: context.height / 15,
//                     width: context.width * 0.50 ,
//                     decoration:  BoxDecoration(
//                       color: AppColors.primaryColor,
//                       borderRadius: BorderRadius.circular(15),
//                     ),
//                     child: Center(
//                       child:  Row(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: const [
//
//                           Icon(Icons.edit,color: Colors.white,),
//
//                           SizedBox(width: 10,),
//
//                           Text('Update',
//                             style: FontStyle.textLabelWhite,
//                           ),
//
//                           SizedBox(width: 10,),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ),
//
//               ],
//             ),
//           ),
//
//
//
//         ),
//       ),
//     );
//   }
// }
