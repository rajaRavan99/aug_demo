import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:intl/intl.dart';

import '../../models/time_model.dart';
import '../../models/user_data_model.dart';

RxString keyValue = ''.obs;
String todayDateFormat = DateFormat('dd-MM-yyyy').format(DateTime.parse(DateTime.now().toString()));

RxString timingKey = ''.obs;
RxString email = ''.obs;
List adminFind = [];
RxList<UserModel> dataList = RxList();

RxList<TimeModel> timeListData = RxList();

List? list = [];
RxBool isLoading  = false.obs;
RxBool signInLoader  = false.obs;