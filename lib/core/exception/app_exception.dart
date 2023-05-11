class AppException<T> implements Exception {
  const AppException({
    this.trace,
    this.displayMessage = 'Đã xảy ra lỗi',
    this.name = 'AppException',
    this.error,
    this.message = '',
    this.displayTitle = 'Lỗi!!!',
    this.errorCode = 'error',
    this.time,
  });

  final String displayMessage;
  final String displayTitle;
  final String message;
  final T? error;
  final StackTrace? trace;
  final String errorCode;
  final String name;
  final DateTime? time;

  @override
  String toString() => """========================================
  $displayTitle: $displayMessage
  Info: $time $errorCode: $message
  Error: $error
  Trace: $trace""";
}
