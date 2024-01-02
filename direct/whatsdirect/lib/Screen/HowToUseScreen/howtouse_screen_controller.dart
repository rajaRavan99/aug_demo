import 'package:direct_message/Routes/routes.dart';
import 'package:direct_message/Screen/SqliteDatabase/msg_model.dart';
import 'package:direct_message/Screen/SqliteDatabase/sqlhelper_msg.dart';
import 'package:get/get.dart';
import '../../Utils/SharedPreference/set_data.dart';

class HowToUseScreenController extends GetxController {


  navigateToHomeScreen() {
    customData();
    saveBoolHowToUseOpen(false);
    Get.offAllNamed(AppRoute.bottomBarScreen);
  }

  customData() async {
    MsgData firstMsg = MsgData(title: "Hello", subtitle: "Hi",isSelected: 0);
    MsgData secondMsg = MsgData(title: "Hello", subtitle: "How are you",isSelected: 0);
    MsgData thirdMsg = MsgData(title: "Email", subtitle: "Please add Email",isSelected: 0);
    MsgData forthMsg = MsgData(title: "How are you", subtitle: "How are you",isSelected: 0);
    MsgData fifthMsg = MsgData(title: "Contact", subtitle: "Contact",isSelected: 0);

    List<MsgData> listOfUsers = [firstMsg, secondMsg, thirdMsg, forthMsg, fifthMsg];
    await SqlDatabaseHelper.instance.customInsert(listOfUsers);
  }
}
