import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';

import '../../config/config.dart';
import '../../core/storage/secure_storage.dart';
import '../dev_config.dart';
import 'interceptors/default_error_handler_interceptor.dart';
import 'interceptors/json_file_logger.dart';
import 'interceptors/refesh_token.dart';

class API {
  String baseUrl = Config.getBaseUrl;

  late Dio _dio;

  Dio get dio => _dio;

  final Duration timeoutDuration = const Duration(seconds: 50);

  static final API _singleton = API._instance();

  factory API() {
    return _singleton;
  }

  API._instance() {
    _dio = Dio();
    _dio.options.baseUrl = baseUrl;
    _dio.options.connectTimeout = timeoutDuration;
    _dio.options.receiveTimeout = timeoutDuration;
    _dio.options.headers = {
      HttpHeaders.contentTypeHeader: "application/json",
      HttpHeaders.acceptHeader: "application/json",
    };
    configureInterceptors();
  }

  void configureInterceptors() {
    //read config from dev_config.yaml

    var jsonFileLogger = JsonFileLogger();
    _dio.interceptors.addAll([
      RefreshToken(),
      DefaultErrorHandlerInterceptor(),
    ]);
    if (!(Config.isProd)) {
      if (DevConfig.saveLogsToFile) {
        _dio.interceptors.add(jsonFileLogger);
        jsonFileLogger.clearLogs();
      }
      if (DevConfig.showConsoleLogs && DevConfig.showConsolePrints) {
        log(
          '\x1b[43m\x1b[37mShould NOT show console logs and prints at the same time\x1B[0m',
          name: "ERROR",
        );
      } else if (DevConfig.showConsoleLogs) {
        _dio.interceptors.add(
          LogInterceptor(
            request: false,
            requestHeader: false,
            requestBody: true,
            responseHeader: false,
            responseBody: true,
            error: true,
            logPrint: (msg) {
              log(
                '\x1B[36m$msg\x1B[0m',
                name: 'dio',
              );
            },
          ),
        );
      } else if (DevConfig.showConsolePrints) {
        _dio.interceptors.add(
          LogInterceptor(
            request: false,
            requestHeader: false,
            requestBody: true,
            responseHeader: false,
            responseBody: true,
            error: true,
            logPrint: print,
          ),
        );
      }
    }
  }

  Future<void> addAuthHeader() async {
    var accessToken = await secureStorage.getAccessToken();
    dio.options.headers['Authorization'] = "Bearer $accessToken";
  }

  refreshAccessToken() async {
    await addAuthHeader();
    return await dio.post("/auth/refresh");
  }
}
