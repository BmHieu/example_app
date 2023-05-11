import 'package:flutter/material.dart';

import '../features/home/presentation/view/example_view.dart';
import '../features/home/presentation/view/webview.dart';
import 'root.dart';

class ScreenArgument {
  static const id = 'id';
  static const url = 'url';
}

class ScreenRouter {
  static const root = '/';
  static const example = '/example';
  static const webview = '/webview';

  Route<dynamic> generateRoute(RouteSettings settings) {
    var route = buildPageRoute(settings);
    var arguments = settings.arguments as Map<String, dynamic>?;

    switch (settings.name) {
      case root:
        return route(
          const Root(),
        );
      case example:
        return route(
          ExampleScreen(
            id: arguments?[ScreenArgument.id],
          ),
        );
      case webview:
        return route(
          BuildWebView(url: arguments?[ScreenArgument.url] ?? "",),
        );
      default:
        return unknownRoute(settings);
    }
  }

  Function buildPageRoute(RouteSettings settings) {
    return (builder) => MaterialPageRoute(
          builder: (context) => builder,
          settings: settings,
        );
  }

  Route<dynamic> unknownRoute(RouteSettings settings) {
    var unknownRouteText = "No such screen for ${settings.name}";

    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(unknownRouteText),
            const Padding(padding: EdgeInsets.all(10.0)),
            ElevatedButton(
              child: const Text("Go back"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
