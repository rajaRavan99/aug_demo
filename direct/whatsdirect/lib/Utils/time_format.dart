import 'package:intl/intl.dart';

String convertTime12HrFormat(time) {
  var temp = int.parse(time.split(':')[0]);
  String? t;
  if (temp >= 12 && temp < 24) {
    t = " PM";
  } else {
    t = " AM";
  }
  if (temp > 12) {
    temp = temp - 12;
    if (temp < 10) {
      time = time.replaceRange(0, 2, "0$temp");
      time += t;
    } else {
      time = time.replaceRange(0, 2, "$temp");
      time += t;
    }
  } else if (temp == 00) {
    time = time.replaceRange(0, 2, '12');
    time += t;
  } else {
    time += t;
  }

  return time;
}

String changeDateFormatYMD(String date) {
  /// 26/05/2022

  String year = date.split('/').last;
  String day = date.split('/').first;
  String month =
      date.replaceAll(year, '').replaceAll(day, '').replaceAll('/', '');
  String yMDDate = year + '-' + month + '-' + day;

  return yMDDate;
}

String timeStampToTime(String timeStamp, String s) {
  DateTime createDate = DateFormat("yyyy-MM-dd' 'HH:mm:ss'").parse(timeStamp);

  switch (s) {
    case 'date':
      return DateFormat('yyyy-MM-dd HH:mm:ss').format(createDate).toString();
      break;
    case 'time':
      return convertTime12HrFormat(
          DateFormat('HH:mm:ss').format(createDate).toString());
      break;
    default:
      {
        return '';
        break;
      }
  }
}
