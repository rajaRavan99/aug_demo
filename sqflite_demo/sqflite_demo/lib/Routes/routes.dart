import 'package:get/get.dart';
import 'package:sqflite_demo/Screen/AddData/add_Data.dart';
import 'package:sqflite_demo/Screen/GetListDB/get_list_db.dart';
import '../Screen/HomeScreen/home_screen.dart';
import '../Screen/ViewScreen/view_screen.dart';

class AppRoutes{
  AppRoutes._();

  static const homeScreen = "/homeScreen";
  static const viewScreen = "/viewScreen";
  static const addData = "/addData";
  static const getList = "/getList";
  static const chatScreen = "/chatScreen";
  static const loginPageFirebase = "/loginPageFirebase";

  static List<GetPage> routeList = [
    GetPage(name: homeScreen, page: () => HomeScreen(), transition: Transition.leftToRight, transitionDuration: const Duration(milliseconds: 300)),
    GetPage(name: viewScreen, page: () => ViewScreen(), transition: Transition.leftToRight, transitionDuration: const Duration(milliseconds: 300)),
    GetPage(name: addData, page: () =>  AddData(), transition: Transition.leftToRight, transitionDuration: const Duration(milliseconds: 300)),
    GetPage(name: getList, page: () =>  GetListDB(), transition: Transition.leftToRight, transitionDuration: const Duration(milliseconds: 300)),
  ];
}