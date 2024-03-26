import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';

class CommonDataUtil{
  // 今日の日付取得(yyyy/MM/dd)
  static String getDate(){
    DateTime now = DateTime.now();
    DateFormat outputFormat = DateFormat('yyyy/MM/dd');
    return outputFormat.format(now);
  }

  // 今日の日付取得(yyyyMMdd)
  static String getDateNoSlash(){
    DateTime now = DateTime.now();
    DateFormat outputFormat = DateFormat('yyyyMMdd');
    return outputFormat.format(now);
  }

  // 日付取得(yyyyMMdd)
  static String changeDateNoSlash(day){
    DateFormat outputFormat = DateFormat('yyyyMMdd');
    return outputFormat.format(day);
  }

  // 今日の曜日取得('(月)')
  static String getDayOfWeek(){
    initializeDateFormatting("ja");
    return ' (${DateFormat.E('ja').format(DateTime.now())})';
  }
}