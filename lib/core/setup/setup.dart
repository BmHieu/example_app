import 'package:flutter/cupertino.dart';

import '../injection/injection.dart';

Future<void> setup({required List<Module> modules}) async {
  WidgetsFlutterBinding.ensureInitialized();

  // Inject dependencies
  for (final module in modules) {
    await module.inject();
  }
}
