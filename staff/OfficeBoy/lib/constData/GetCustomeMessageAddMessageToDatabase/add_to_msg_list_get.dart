import 'package:firebase_database/firebase_database.dart';

import '../../Screen/HomeScreen/home_screen.dart';
import '../../models/msg_get_model.dart';
import '../GlobalVariable/global_varible.dart';
import '../const.dart';

void addToMsgListGet({required String name, required String message}) async {
  DatabaseReference database = FirebaseDatabase.instance.ref().child('$type/${dataList[0].recordId}').child('Messages');
  String? newKey = database.push().key;

  MsgGetModel msgGetModel = MsgGetModel(
      name: name,
      message: message,
      dateTime: DateTime.now().toString(),
      isCheck: false,
      recordKey: newKey
  );
  await FirebaseDatabase.instance.ref('$type/${dataList[0].recordId}').child('Messages').child(newKey ?? '').set(msgGetModel.toJson());
}