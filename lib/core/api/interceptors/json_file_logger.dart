import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:path_provider/path_provider.dart';

/// This class is used to intercept the logs of the API calls
/// and write them to log files.
class JsonFileLogger extends Interceptor {
  final String filename = 'logs.json';
  bool didShowLogPath = false;

  Future<String> get logFilename async {
    final directory = await getApplicationDocumentsDirectory();
    var logFilePath = '${directory.path}/$filename';
    if (!didShowLogPath) {
      didShowLogPath = true;
      log('Log file path: $logFilePath');
    }
    return logFilePath;
  }

  // create

  JsonFileLogger();

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    final logMap = <String, dynamic>{
      'type': 'request',
      'method': options.method,
      'url': options.uri.toString(),
      'data': options.data,
    };
    final logText = jsonEncode(logMap);
    writeLogsToFile(logText);
    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    final logMap = <String, dynamic>{
      'type': 'response',
      'method': response.requestOptions.method,
      'url': response.requestOptions.uri.toString(),
      'data': response.data,
    };
    final logText = jsonEncode(logMap);
    writeLogsToFile(logText);
    super.onResponse(response, handler);
  }

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    final logMap = <String, dynamic>{
      'type': 'err',
      'method': err.requestOptions.method,
      'url': err.requestOptions.uri.toString(),
      'data': err.response?.data,
    };
    final logText = jsonEncode(logMap);
    writeLogsToFile(logText);
    super.onError(err, handler);
  }

  Future<void> writeLogsToFile(String logText) async {
    var file = File(await logFilename);
    var logs = <Map<String, dynamic>>[];

    // Read existing logs from file, if any
    if (file.existsSync()) {
      var contents = await file.readAsString();
      logs = List<Map<String, dynamic>>.from(json.decode(contents));
    }

    // Parse the new logText and add it to logs
    var log = <String, dynamic>{
      'timestamp': DateTime.now().toString(),
      'data': json.decode(logText),
    };
    logs.add(log);

    // Write logs back to file
    var encodedLogs = json.encode(logs);
    await file.writeAsString(encodedLogs, flush: true, mode: FileMode.write);
  }

  Future<void> clearLogs() async {
    var file = File(await logFilename);
    if (file.existsSync()) {
      file.deleteSync();
    }
  }
}
