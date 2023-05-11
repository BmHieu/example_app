import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../features/home/presentation/view/home_view.dart';
import '../helper/connectivity.dart';
import '../helper/dimension.dart';
import 'storage/storage.dart';

class Root extends StatefulWidget {
  const Root({super.key});

  @override
  State<Root> createState() => _RootState();
}

class _RootState extends State<Root> {
  late InternetConnectivity _connectivity;

  @override
  void initState() {
    _setupFirstTimeLaunchApp();
    _setupConnectivityStream();
    SystemChrome.setEnabledSystemUIMode(
      SystemUiMode.manual,
      overlays: [],
    ); // Remove status bar
    super.initState();
  }

  @override
  void dispose() {
    _connectivity.disposeStream();
    super.dispose();
  }

  _setupConnectivityStream() {
    _connectivity = InternetConnectivity.instance;
    _connectivity.initialize();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    return const HomeView();
  }

  _setupFirstTimeLaunchApp() async {
    await _setCurrentLocal();
  }

  _setCurrentLocal() async {
    try {
      context.setLocale(
        await storage.getLanguage() == 'vi'
            ? const Locale('vi', 'VN')
            : const Locale('en', 'US'),
      );
    } catch (error) {
      context.setLocale(
        const Locale('vi', 'VN'),
      );
    }
  }
}
