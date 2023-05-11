import 'dart:async';
import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';

import '../helper/theme/theme_provider.dart';
import 'app_modules.dart';
import 'routes.dart';
import 'setup/setup.dart';

void mainDelegate() async {
  WidgetsFlutterBinding.ensureInitialized();

  EasyLocalization.logger.printer = (object, {level, name, stackTrace}) {
    log(
      '\x1B[32m$object\x1B[0m',
      name: name!,
      stackTrace: stackTrace,
    );
  };

  await EasyLocalization.ensureInitialized();

  await setup(
    modules: appModuleList,
  );

  runZoned(() {
    runApp(
      EasyLocalization(
        supportedLocales: const [
          Locale('en', 'US'),
          Locale('vi', 'VN'),
        ],
        path: 'locales',
        fallbackLocale: const Locale('vi', 'VN'),
        child: ChangeNotifierProvider(
          create: (_) => ThemeProvider(),
          child: const MaterialApp(
            debugShowCheckedModeBanner: false,
            home: Routes(),
          ),
        ),
      ),
    );
  });
}
