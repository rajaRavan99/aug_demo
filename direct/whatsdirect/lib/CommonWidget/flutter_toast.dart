import 'package:direct_message/ConstData/colors.dart';
import 'package:fluttertoast/fluttertoast.dart';

flutterToast({required text}){
  Fluttertoast.showToast(
    msg: text,
    toastLength: Toast.LENGTH_SHORT,
    gravity: ToastGravity.BOTTOM,
    timeInSecForIosWeb: 1,
    backgroundColor: properGreyColor,
    textColor: textfieldfillColor,
    fontSize: 16.0,
  );
}