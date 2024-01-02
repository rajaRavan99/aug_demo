import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sqflite_demo/Screen/ViewScreen/view_screen_controller.dart';

class ViewScreen extends StatelessWidget {
  ViewScreen({Key? key}) : super(key: key);

  final ViewScreenController viewScreenController = Get.put(ViewScreenController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("View"),
      ),
      body: ListView.builder(
        itemCount: viewScreenController.getList.length,
        itemBuilder: (context, index) {
          return viewScreenController.getList[index].isCheck.value ? ListTile(
            title: Text(viewScreenController.getList[index].name),
          ) : const SizedBox();
      },),
    );
  }
}
