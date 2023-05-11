import 'dart:async';
import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';

import '../config/config.dart';

class InternetConnectivity {
  InternetConnectivity._internal();

  static final InternetConnectivity _instance =
      InternetConnectivity._internal();
  static InternetConnectivity get instance => _instance;

  Connectivity connectivity = Connectivity();
  StreamController controller = StreamController.broadcast();
  Stream get myStream => controller.stream;

  void initialize() async {
    var result = await connectivity.checkConnectivity();
    _checkStatus(result);
    connectivity.onConnectivityChanged.listen(_checkStatus);
  }

  void _checkStatus(ConnectivityResult result) async {
    var isOnline = false;
    try {
      final result = await InternetAddress.lookup(
        Config.getBaseUrl,
      );
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        isOnline = true;
      } else {
        isOnline = false;
      }
    } on SocketException catch (_) {
      isOnline = false;
    }
    if (controller.isClosed) {
      controller = StreamController.broadcast();
    }
    controller.sink.add({result: isOnline});
  }

  void disposeStream() => controller.close();
}
