import 'package:firebasedemo/Screen/HomeScreen/home_screen.dart';
import 'package:firebasedemo/Screen/Login/SignIn/sign_in_screen.dart';
import 'package:firebasedemo/Screen/Login/SignUp/sign_up_screen.dart';
import 'package:get/get.dart';
import '../Screen/UserOfficeTime/user_office_time.dart';

class AppRoutes{
  AppRoutes._();

  static const homeScreen = "/homePage";
  static const signUpScreen = "/signUpScreen";
  static const signInScreen = "/signInScreen";
  static const userOfficeTime = "/userOfficeTime";

  static List<GetPage> routeList = [
    GetPage(name: homeScreen, page: () =>  HomeScreen(), transition: Transition.leftToRight, transitionDuration: const Duration(milliseconds: 300)),
    GetPage(name: signInScreen, page: () =>   SignInScreen(), transition: Transition.leftToRight, transitionDuration: const Duration(milliseconds: 300)),
    GetPage(name: signUpScreen, page: () =>   SignUpScreen(), transition: Transition.leftToRight, transitionDuration: const Duration(milliseconds: 300)),
    GetPage(name: userOfficeTime, page: () =>   UserOfficeTime(), transition: Transition.leftToRight, transitionDuration: const Duration(milliseconds: 300)),

  ];
}