import 'package:intl/intl.dart';

class TimeFormatter {
  static String hhmm(DateTime time) => DateFormat.Hm().format(time);

  static String ddMMyyyy(DateTime time) =>
      DateFormat('dd/MM/yyyy').format(time);

  static String hhmmddMMyyyy(DateTime time) =>
      DateFormat('HH:mm - dd/MM/yyyy').format(time);
}
