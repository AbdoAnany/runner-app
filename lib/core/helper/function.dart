

import 'package:intl/intl.dart';

class AppFunction {
  static String convertToTitleCase(String text) {
    if (text.isEmpty) return text;
    return text[0].toUpperCase() + text.substring(1);
  }

  static String capitalize(String text) {
    if (text.isEmpty) return text;
    return text[0].toUpperCase() + text.substring(1);
  }
  static String getHistoryCount(state) => NumberFormat('###').format(state??0);
  static String getDistance(val) => NumberFormat('###,#').format(val);
  static String getDateDayMonth(String date) => DateFormat('dd MMM').format(DateTime.parse(date));
  static String getDecimal(decimal,) =>  NumberFormat("#,###").format(decimal).toString();

}