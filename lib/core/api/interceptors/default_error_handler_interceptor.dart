import 'package:dio/dio.dart';

import '../../exception/network_exception.dart';

class DefaultErrorHandlerInterceptor extends QueuedInterceptor {
  @override
  void onError(
    DioError err,
    ErrorInterceptorHandler handler,
  ) {
    var error = err.response?.data;
    if (err.response?.statusCode != null) {
      String message;
      if ((error != null && error is Map<String, dynamic>)) {
        message = err.response!.data['message'];
      } else {
        message = "Something went wrong";
      }
      // final message = err.response!.data['message'];
      return handler.next(
        DioError(
          requestOptions: err.requestOptions,
          error: NetworkException(
            errorCode: err.response!.statusCode!.toString(),
            error: err,
            url: err.requestOptions.uri.path,
            displayMessage: message.toString(),
          ),
          response: err.response,
          type: err.type,
        ),
      );
    }
    if ([
      DioErrorType.connectionTimeout,
      DioErrorType.sendTimeout,
      DioErrorType.sendTimeout,
    ].contains(err.type)) {
      handler.next(
        DioError(
          requestOptions: err.requestOptions,
          error: NetworkException(
            errorCode: NetworkErrorCode.networkTimeout.name,
            error: err,
          ),
          response: err.response,
          type: err.type,
        ),
      );
    }
    handler.next(err);
  }
}
