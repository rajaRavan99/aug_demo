
import 'package:get/get.dart';
import '../Screen/HomeScreen/home_screen.dart';
import '../Screen/Login/SignIn/sign_in_screen.dart';
import '../Screen/Login/SignUp/sign_up_screen.dart';
import '../Screen/TimeScreen/time_screen.dart';
import '../constData/AwesomeNotification/screen.dart';

class AppRoutes{
  AppRoutes._();

  // static const homePage = "/homePage";
  static const userProfile = "/userProfile";
  static const profilePage = "/profilePage";
  static const timeScreen = "/timeScreen";
  static const homeScreen = "/homeScreen";
  static const signUpScreen = "/signUpScreen";
  static const signInScreen = "/signInScreen";
  static const notificationPage = "/notificationPage";

  static List<GetPage> routeList = [
     // GetPage(name: homePage, page: () =>  const HomePage(), transition: Transition.leftToRight, transitionDuration: const Duration(milliseconds: 300)),
     GetPage(name: homeScreen, page: () =>   HomeScreen(), transition: Transition.leftToRight, transitionDuration: const Duration(milliseconds: 300)),
     // GetPage(name: userProfile, page: () =>   UserProfile(), transition: Transition.leftToRight, transitionDuration: const Duration(milliseconds: 300)),
     GetPage(name: timeScreen, page: () =>   TimeScreen(), transition: Transition.leftToRight, transitionDuration: const Duration(milliseconds: 300)),
     GetPage(name: signInScreen, page: () =>   SignInScreen(), transition: Transition.leftToRight, transitionDuration: const Duration(milliseconds: 300)),
     GetPage(name: signUpScreen, page: () =>   SignUpScreen(), transition: Transition.leftToRight, transitionDuration: const Duration(milliseconds: 300)),
     GetPage(name: notificationPage, page: () =>   NotificationPage(), transition: Transition.leftToRight, transitionDuration: const Duration(milliseconds: 300)),

  ];
}