

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:toastification/toastification.dart';

import '../../features/4_history/data/models/history_data_model.dart';
import '../../my_app.dart';

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
  static List<HistoryDataModel> generateFakeHistoryData(int count) {
    Random random = Random();
    List<HistoryDataModel> historyList = [];

    for (int i = 0; i < count; i++) {
      // Generate a random date (e.g., past 30 days)
      DateTime dateTime = DateTime.now().subtract(Duration(days: random.nextInt(30)));
      String date = '${dateTime.year}-${dateTime.month.toString().padLeft(2, '0')}-${dateTime.day.toString().padLeft(2, '0')}';

      // Generate random values for each field
      double distance = random.nextDouble() * 1000.0; // distance in km (0 to 10 km)
      int pt = random.nextInt(100); // points (0 to 100)
      int kal = random.nextInt(500); // calories (0 to 500)
      int steps = random.nextInt(20000); // steps (0 to 20,000)

      // Create a new HistoryEntity instance and add it to the list
      historyList.add(HistoryDataModel(
        date: date,
        distance: distance,
        pt: pt,
        kal: kal,
        steps: steps,
      ));
    }

    return historyList;
  }


  static showToast(String msg,{ToastificationType type =  ToastificationType.info}) {
   return toastification.show(
      alignment: Alignment.bottomCenter,
      context: Get.context,
      title: Text(msg),
     showProgressBar: false,
      type: type,
      style: ToastificationStyle.flatColored,
      autoCloseDuration: const Duration(seconds: 3),
    );
  }

}