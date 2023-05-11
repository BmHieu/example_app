import 'package:dio/dio.dart';

import 'app_exception.dart';

enum NetworkErrorCode {
  networkUnauthenticated,
  networkUndefined,
  networkTimeout,
}

class NetworkException extends AppException<DioError> {
  NetworkException({
    String errorCode = 'network',
    DioError? error,
    StackTrace? stackTrace,
    String message = 'Error in network',
    String displayMessage = 'Xảy ra lỗi khi gọi API',
    String displayTitle = 'Lỗi kết nối',
    String? url,
  }) : super(
          errorCode: errorCode,
          error: error,
          trace: stackTrace,
          time: DateTime.now(),
          message: '$url: $message',
          displayTitle: displayTitle,
          displayMessage: displayMessage,
        );
}
