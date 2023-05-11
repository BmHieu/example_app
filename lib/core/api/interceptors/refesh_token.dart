import 'package:dio/dio.dart';

import '../../../core/storage/secure_storage.dart';
import '../api.dart';

class RefreshToken extends QueuedInterceptor {
  @override
  void onError(
    DioError err,
    ErrorInterceptorHandler handler,
  ) async {
    if (err.requestOptions.headers['Authorization'] == null) {
      return handler.next(err);
    }
    final dioTemp = API().dio;
    if (err.response!.statusCode == 401 &&
        err.response!.data["error_type"] == "ERROR_2003") {
      await refreshTokenAndRetryOnError(
        handler,
        dioTemp,
        err.response!.requestOptions,
      );
      return;
    }
    return handler.next(err);
  }

  Future<void> refreshTokenAndRetryOnError(
    ErrorInterceptorHandler handler,
    Dio dioTemp,
    RequestOptions options,
  ) async {
    final accessToken = await secureStorage.getAccessToken();

    if ("Bearer $accessToken" != options.headers['Authorization']) {
      options.headers['Authorization'] = "Bearer $accessToken";
      try {
        final response = await dioTemp.fetch(options);
        handler.resolve(response);
      } catch (error) {
        handler.reject(
          DioError(
            requestOptions: options,
            error: error,
          ),
        );
      }
      return;
    }

    try {
      final response = await API().refreshAccessToken();
      if (response.statusCode == 200) {
        final userId = response.data['data']['user']['id'];
        final newAccessToken = response.data['data']['access_token'];
        await secureStorage.saveUserId(userId);
        await secureStorage.saveAccessToken(newAccessToken);

        options.headers['Authorization'] = "Bearer $newAccessToken";
        final refreshedResponse = await dioTemp.fetch(options);
        handler.resolve(refreshedResponse);
        return;
      }
    } catch (error) {
      await secureStorage.saveAccessToken('');
      await secureStorage.removeUserId();
      handler.reject(
        DioError(
          requestOptions: options,
          error: error,
        ),
      );
      return;
    }
  }
}
