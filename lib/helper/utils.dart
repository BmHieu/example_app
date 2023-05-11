// ignore_for_file: avoid_print

import 'dart:io';

// import 'package:device_info_plus/device_info_plus.dart';
import 'package:android_id/android_id.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../config/config.dart';
import 'exceptions.dart';

class Utils {
  static final Utils _singleton = Utils._internal();

  factory Utils() {
    return _singleton;
  }

  Utils._internal();

  // only use this if reuse image for both dark & light theme
  // otherwise using getSvgPicture in Themes class
  static getSvgPicture(String name) => SvgPicture.asset('assets/$name.svg');

  logError({Exception? exception, dynamic error, dynamic content}) {
    exception ??= Exception(error);
    if (!Config.isProd && content != null) print(content);
  }

  static bool isValidEmail(String email) {
    var p = r"^[a-zA-Z0-9._]+@[a-zA-Z0-9]+\.[a-zA-Z]+";
    var regExp = RegExp(p);
    return regExp.hasMatch(email);
  }

  static bool isValidPhone(String phone) {
    var p = r"^(?:[+0]9)?[0-9]{10}$";
    var regExp = RegExp(p);
    return regExp.hasMatch(phone);
  }

  String localeCurrency(
    double money,
    BuildContext context, {
    required String symbol,
    int decimalDigits = 0,
    shorten = false,
  }) {
    var currencyFormat = shorten
        ? NumberFormat.compactCurrency(
            locale: context.locale.toString(),
            decimalDigits: decimalDigits,
            symbol: symbol,
          )
        : NumberFormat.currency(
            locale: context.locale.toString(),
            decimalDigits: decimalDigits,
            symbol: symbol,
          );
    return currencyFormat.format(money);
  }

  String parseDatetime(DateTime dateTime, {String format = "d/M/y - H:m"}) {
    return DateFormat(format).format(dateTime);
  }

  String parseTime(DateTime dateTime) {
    return DateFormat("H:m").format(dateTime);
  }

  String parseTimeFormDouble(double duration) {
    return '${duration ~/ 60} giờ ${(duration % 60).toStringAsFixed(0)} phút';
  }

  String getTimeStartEvent(DateTime date, int duration) {
    var toHour = date.hour;
    var toMinute = 0;
    var totalMinute = 0;
    var totalHour = 0;

    if (duration % 60 == 0) {
      totalHour = duration ~/ 60;
      totalMinute = 0;
    } else {
      totalHour = duration ~/ 60;
      totalMinute = duration % 60;
    }

    if (date.minute + totalMinute >= 60) {
      toMinute = (date.minute + totalMinute) - 60;
      toHour += 1;
    } else {
      toMinute += (date.minute + totalMinute);
    }

    if (date.hour + totalHour > 24) {
      toHour = (date.hour + totalHour) - 24;
    } else if (date.hour + totalHour < 24) {
      toHour += totalHour;
    } else {
      toHour = 0;
    }

    var fromTimeStr =
        " đến ${(toHour < 10) ? "0$toHour" : toHour.toString()}:${(toMinute < 10) ? "0$toMinute" : toMinute.toString()}";
    var toTimeStr =
        "Từ ${(date.hour < 10) ? "0${date.hour}" : date.hour.toString()}:${(date.minute < 10) ? "0${date.minute}" : date.minute.toString()}";
    return toTimeStr + fromTimeStr;
  }

  Duration checkTimeToEvent(DateTime time) {
    var timeDiffNow = time.difference(DateTime.now());
    var duration = Duration(
      days: timeDiffNow.inDays,
      hours: timeDiffNow.inHours,
      minutes: timeDiffNow.inMinutes,
      seconds: timeDiffNow.inSeconds,
    );
    if (DateTime.now().compareTo(time) > 0) {
      return const Duration(
        hours: 0,
      );
    } else {
      if (timeDiffNow.inDays > 0) {
        return Duration(days: timeDiffNow.inDays);
      } else {
        return Duration(
          hours: time
              .subtract(
                duration,
              )
              .hour,
          minutes: time
              .subtract(
                duration,
              )
              .minute,
          seconds: time
              .subtract(
                duration,
              )
              .second,
        );
      }
    }
  }

  String parseDate(DateTime dateTime, {String format = "d/M"}) {
    return DateFormat(format).format(dateTime);
  }

  bool isEmptyString(String str) {
    return str.isEmpty;
  }

  DateTime? parseDateFromStringAndLocalize(String date) {
    var dateTime = DateTime.tryParse(date)?.toLocal();
    return dateTime;
  }

  Color darken(Color color, [double amount = .1]) {
    assert(amount >= 0 && amount <= 1);

    final hsl = HSLColor.fromColor(color);
    final hslDark = hsl.withLightness((hsl.lightness - amount).clamp(0.0, 1.0));

    return hslDark.toColor();
  }

  Color lighten(Color color, [double amount = .1]) {
    assert(amount >= 0 && amount <= 1);

    final hsl = HSLColor.fromColor(color);
    final hslLight =
        hsl.withLightness((hsl.lightness + amount).clamp(0.0, 1.0));

    return hslLight.toColor();
  }

  String getDoW(int dow) {
    return dow < 7 ? "Thứ ${dow + 1}" : "Chủ nhật";
  }

  Future<bool> noInternet() async {
    try {
      return await (Connectivity().checkConnectivity()) ==
          ConnectivityResult.none;
    } catch (e) {
      utils.logError(content: e.toString());
      throw NoInternetException();
    }
  }

  Future<List<String>> getDeviceDetails() async {
    var deviceName = "";
    var deviceVersion = "";
    var identifier = "";
    final deviceInfoPlugin = DeviceInfoPlugin();
    try {
      if (Platform.isAndroid) {
        var build = await deviceInfoPlugin.androidInfo;
        const androidIdPlugin = AndroidId();
        deviceName = build.model;
        deviceVersion = build.version.toString();
        identifier = (await androidIdPlugin.getId())!; //UUID for Android
      } else if (Platform.isIOS) {
        var data = await deviceInfoPlugin.iosInfo;
        deviceName = data.name!;
        deviceVersion = data.systemVersion!;
        identifier = data.identifierForVendor!; //UUID for iOS
      }
    } on PlatformException {
      print('Failed to get platform version');
    }
    return [
      identifier,
      deviceName,
      deviceVersion,
    ];
  }

  DateTime toDateTime(String dateTimeStr) {
    try {
      return DateTime.parse(dateTimeStr);
    } catch (e) {
      utils.logError(content: e.toString());
      rethrow;
    }
  }

  String getDiscountPercent(String oldPrice, String newPrice) {
    var oldPrice0 = double.parse(oldPrice);
    var newPrice0 = double.parse(newPrice);

    return "${(oldPrice0 / newPrice0).toString()}%";
  }

  showAlert(BuildContext context, dynamic error) {
    String message;
    if (error is DioError) {
      final errors = error.response?.data["errors"];
      if (errors != null && errors is Map) {
        message = errors.values.first.toString();
      } else {
        message = error.response?.data["message"];
      }
    } else {
      if (error is CustomError) {
        message = error.errorMessage;
      } else if (error is Error) {
        message = error.toString();
      } else {
        message = error;
      }
    }
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Thông báo"),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text("Đóng"),
          ),
        ],
      ),
    );
  }

  String getNumberFormat(int number) {
    return NumberFormat.compact().format(number);
  }

  String formatDate(DateTime dateTime, {String format = "HH:mm"}) {
    var local = dateTime.toLocal();
    var hourMinute = DateFormat(format).format(local);
    String day;
    if (local.year == DateTime.now().year) {
      if (local.day == DateTime.now().day) {
        day = "Hôm nay";
      } else if (local.day == DateTime.now().day - 1) {
        day = "Hôm qua";
      } else {
        day = DateFormat("d 'tháng' M").format(local);
      }
    } else {
      day = DateFormat("d/M/y").format(local);
    }
    return "$day lúc $hourMinute";
  }

  String getFileExtension(String fileName) {
    return fileName.split('.').last;
  }
}

final utils = Utils();

class CustomError implements Exception {
  String errorMessage;
  CustomError.string(this.errorMessage);
  CustomError.dioError(DioError errorMessage)
      : errorMessage = errorMessage.response?.data["message"];

  @override
  String toString() {
    return errorMessage;
  }
}

//capitalize first letter of string
extension StringExtension on String {
  String capitalize() {
    var str = trim();
    if (str.isEmpty) {
      return str;
    } else {
      str = "${str[0].toUpperCase()}${str.substring(1)}";
    }
    return str;
  }
}
