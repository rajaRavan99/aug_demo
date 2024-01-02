import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'home_screen_controller.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);

  final HomeScreenController homeScreenController = Get.put(HomeScreenController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home"),
      ),
      body: ListView.builder(
        itemCount: homeScreenController.tempList.value.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(homeScreenController.tempList.value[index].name),
            trailing: Obx(() => Checkbox(
              value: homeScreenController.tempList.value[index].isCheck.value,
              onChanged: (value) {
                if(homeScreenController.tempList.value[index].isCheck.value){
                  homeScreenController.tempList.value[index].isCheck.value = value!;
                } else{
                  homeScreenController.tempList.value[index].isCheck.value = value!;
                }
              },
            )),
          );
      },),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          homeScreenController.navigateToViewScreen();
        },child: const Text("Next"),),
    );
  }
}
