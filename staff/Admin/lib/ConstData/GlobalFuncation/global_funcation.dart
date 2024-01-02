import '../../../models/msg_model.dart';
import '../SqfliteHelper/sqlhelper_msg.dart';

customData() async {
  await SqlDatabaseHelper.instance.deleteTableAll();
  MsgData secondMsg = MsgData(title: "Please come with water",subtitle: '',isSelected: 0);
  MsgData thirdMsg = MsgData(title: "Please come",isSelected: 0,subtitle: '');
  MsgData forthMsg = MsgData(title: "Come with Water",isSelected: 0,subtitle: '');
  MsgData fifthMsg = MsgData(title: "Come with Juice",isSelected: 0,subtitle: '');
  MsgData sixMsg = MsgData(title: "Fill the water bottle",isSelected: 0,subtitle: '');

  List<MsgData> listOfMessage = [secondMsg, thirdMsg,forthMsg,fifthMsg,sixMsg];
  // if(msgDataList.isEmpty)
  // {
  await SqlDatabaseHelper.instance.customInsert(listOfMessage);
  // }
}