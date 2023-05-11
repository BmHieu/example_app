import 'package:easy_localization/easy_localization.dart';

import '../generated/locale_keys.g.dart';

class NoInternetException implements Exception {
  get message {
    return LocaleKeys.error_no_internet_connection.tr();
  }

  @override
  String toString() {
    return message;
  }
}

class SetupDbFailedException implements Exception {
  get message {
    return LocaleKeys.error_setup_db_failed.tr();
  }

  @override
  String toString() {
    return message;
  }
}
