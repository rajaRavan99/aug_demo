
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../models/UsersModel.dart';
import '../../../models/msg_model.dart';

RxList<UserModel> userList = RxList();
RxList<UserModel> anotherList = RxList();

RxList<MsgData> msgDataList = RxList();
RxString email = ''.obs;
RxString timingKey = ''.obs;

List? list = [];
RxBool isLoading  = false.obs;
RxBool signInLoader  = false.obs;

String todayDateFormat = DateFormat('dd-MM-yyyy').format(DateTime.parse(DateTime.now().toString()));

