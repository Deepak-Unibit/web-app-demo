import 'package:intl/intl.dart';

class DateHelper {
  String dateFormat({required String date,required String format }) {
    DateTime dateTime = DateTime.parse(date);
    final DateFormat formatter = DateFormat(format);
    final String formatted = formatter.format(dateTime);
    return formatted;
  }

  String dateFormatNull({required String? date,required String format }) {
    if(date == null) return "Present";
    DateTime dateTime = DateTime.parse(date);
    final DateFormat formatter = DateFormat(format);
    final String formatted = formatter.format(dateTime);
    return formatted;
  }
}