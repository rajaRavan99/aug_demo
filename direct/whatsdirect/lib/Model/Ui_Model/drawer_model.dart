import 'package:get/get.dart';

class DrawerModel{
  String? icon;
  String? title;
  RxBool? isSelected = false.obs;


  DrawerModel({
    this.icon,
    this.title,
    this.isSelected,


  });
}

