import 'package:direct_message/Screen/BottombarScreen/bottombar_screen.dart';
import 'package:direct_message/Screen/CreateNewMessageScreen/create_new_message_screen.dart';
import 'package:direct_message/Screen/CustomMessageScreen/select_custom_message_screen.dart';
import 'package:direct_message/Screen/DirectMessageScreen/Direct_message_screen.dart';
import 'package:direct_message/Screen/HistoryScreen/history_screen.dart';
import 'package:direct_message/Screen/HowToUseScreen/howtouse_screen.dart';
import 'package:direct_message/Screen/NewHomeScreen/new_home_screen.dart';
import 'package:direct_message/Screen/PrivacyPolicyScreen/privacy_policy.dart';
import 'package:direct_message/Screen/Private_Note/private_note.dart';
import 'package:direct_message/Screen/QrGeneratePages/Qr_Scan/qr_scan.dart';
import 'package:direct_message/Screen/QuotesImageViewScreen/qutoes_image_view_screen.dart';
import 'package:direct_message/Screen/QuotesScreen/quotes_screen.dart';
import 'package:direct_message/Screen/ReadCallLogScreen/read_call_log_screen.dart';
import 'package:direct_message/Screen/TermsAndCondition/terms_condition.dart';
import 'package:direct_message/Screen/WhatsappWeb/whatsapp_web_screen.dart';
import 'package:get/get.dart';
import '../Screen/Private_Note/Create_Note/create_note.dart';
import '../Screen/QrGeneratePages/QrGenerate/qr_generate.dart';
import '../Screen/QrGeneratePages/TypeQrList/TypeQrList.dart';
import '../Screen/QrGeneratePages/qr_generate_view.dart';
import '../Screen/QrGeneratePages/qr_scan_result/qr_scan_result.dart';
import '../Screen/RemiderScreen/Reminder_List/reminder_list.dart';
import '../Screen/RemiderScreen/create_reminder.dart';
import '../Screen/SettingScreen/setting_screen.dart';


class AppRoute {
  AppRoute._();

  static const newHomeScreen = '/newHomeScreen';
  static const homeScreen = '/homeScreen';
  static const settingsScreen = '/settingsScreen';
  static const historyScreen = '/historyScreen';
  static const howToUseScreen = '/howToUseScreen';
  static const privacyPolicy = '/privacyPolicy';
  static const termsAndCondition = '/termsAndCondition';
  static const customMessageScreen = '/customMessageScreen';
  static const createNewMessageScreen = '/createNewMessageScreen';
  static const whatsappWebScreen = '/whatsappWebScreen';
  static const bottomBarScreen = '/bottomBarScreen';
  static const readCallLogScreen = '/readCallLogScreen';
  static const quotesScreen = '/quotesScreen';
  static const quotesViewScreen = '/quotesViewScreen';
  static const qrGenerate = '/qrGenerate';
  static const qrGenerateView = '/qrGenerateView';
  static const scanQr = '/scanQr';
  static const typeQrList = '/typeQrList';
  static const privateNote = '/privateNote';
  static const createNote = '/createNote';
  static const settingScreen = '/settingScreen';
  static const reminderScreen = '/reminderScreen';
  static const remindUser = '/remindUser';
  static const qrResult = '/qrResult';

  static List<GetPage> routList = [
    GetPage(name: bottomBarScreen, page: () => BottomBarScreen(), transition: Transition.rightToLeft, transitionDuration: const Duration(milliseconds: 300)),
    GetPage(name: newHomeScreen, page: () => NewHomeScreen(), transition: Transition.rightToLeft, transitionDuration: const Duration(milliseconds: 300)),
    GetPage(name: homeScreen, page: () => DirectMessageScreen(), transition: Transition.rightToLeft, transitionDuration: const Duration(milliseconds: 300)),
    GetPage(name: historyScreen, page: () => HistoryScreen(), transition: Transition.rightToLeft, transitionDuration: const Duration(milliseconds: 300)),
    GetPage(name: howToUseScreen, page: () => HowToUseScreen(), transition: Transition.rightToLeft, transitionDuration: const Duration(milliseconds: 300)),
    GetPage(name: privacyPolicy, page: () => PrivacyPolicy(), transition: Transition.rightToLeft, transitionDuration: const Duration(milliseconds: 300)),
    GetPage(name: termsAndCondition, page: () => TermsAndConditionScreen(), transition: Transition.rightToLeft, transitionDuration: const Duration(milliseconds: 300)),
    GetPage(name: customMessageScreen, page: () => CustomMessageScreen(), transition: Transition.rightToLeft, transitionDuration: const Duration(milliseconds: 300)),
    GetPage(name: createNewMessageScreen, page: () => CreateNewMsgScreen(), transition: Transition.rightToLeft, transitionDuration: const Duration(milliseconds: 300)),
    GetPage(name: whatsappWebScreen, page: () => const WhatsappWebScreen(), transition: Transition.rightToLeft, transitionDuration: const Duration(milliseconds: 300)),
    GetPage(name: readCallLogScreen, page: () => ReadCallLogScreen(), transition: Transition.rightToLeft, transitionDuration: const Duration(milliseconds: 300)),
    GetPage(name: quotesScreen, page: () => QuotesScreen(), transition: Transition.rightToLeft, transitionDuration: const Duration(milliseconds: 300)),
    GetPage(name: quotesViewScreen, page: () => QuotesViewScreen(), transition: Transition.rightToLeft, transitionDuration: const Duration(milliseconds: 300)),
    GetPage(name: qrGenerate, page: () => QrGenerate(), transition: Transition.rightToLeft, transitionDuration: const Duration(milliseconds: 300)),
    GetPage(name: qrGenerateView, page: () => QrGenerateView(), transition: Transition.rightToLeft, transitionDuration: const Duration(milliseconds: 300)),
    GetPage(name: scanQr, page: () => QrScan(), transition: Transition.rightToLeft, transitionDuration: const Duration(milliseconds: 300)),
    GetPage(name: typeQrList, page: () => TypeQrList(), transition: Transition.rightToLeft, transitionDuration: const Duration(milliseconds: 300)),
    GetPage(name: settingScreen, page: () => SettingScreen(), transition: Transition.rightToLeft, transitionDuration: const Duration(milliseconds: 300)),
    GetPage(name: reminderScreen, page: () => RemindScreen(), transition: Transition.rightToLeft, transitionDuration: const Duration(milliseconds: 300)),
    GetPage(name: remindUser, page: () => RemindUser(), transition: Transition.rightToLeft, transitionDuration: const Duration(milliseconds: 300)),
    GetPage(name: privateNote, page: () => PrivateNote(), transition: Transition.rightToLeft, transitionDuration: const Duration(milliseconds: 300)),
    GetPage(name: createNote, page: () => CreateNote(), transition: Transition.rightToLeft, transitionDuration: const Duration(milliseconds: 300)),
    GetPage(name: qrResult, page: () => QrResult(), transition: Transition.rightToLeft, transitionDuration: const Duration(milliseconds: 300)),
  ];
}
