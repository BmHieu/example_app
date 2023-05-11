import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../../config/config.dart';

class BuildWebView extends StatefulWidget {
  const BuildWebView({super.key, required this.url});
  final String url;

  @override
  State<BuildWebView> createState() => _BuildWebViewState();
}

class _BuildWebViewState extends State<BuildWebView> with WidgetsBindingObserver {
  final GlobalKey webViewKey = GlobalKey();

  InAppWebViewController? webViewController;
  PullToRefreshController? pullToRefreshController;

  @override
  void initState() {
    // TODO: implement initState

    WidgetsBinding.instance.addObserver(this);
    requestPermission();
    pullToRefreshController = kIsWeb || ![TargetPlatform.iOS, TargetPlatform.android].contains(defaultTargetPlatform)
        ? null
        : PullToRefreshController(
            options: PullToRefreshOptions(color: App.theme.colors.primary.yellow),
            onRefresh: () async {
              if (defaultTargetPlatform == TargetPlatform.android) {
                webViewController?.reload();
              } else if (defaultTargetPlatform == TargetPlatform.iOS || defaultTargetPlatform == TargetPlatform.macOS) {
                webViewController?.loadUrl(
                  urlRequest: URLRequest(
                    url: await webViewController?.getUrl(),
                  ),
                );
              }
            },
          );
    super.initState();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  void requestPermission() async {
    await Permission.camera.request();
    await Permission.photos.request();
    await Permission.microphone.request();
    await Permission.storage.request();
    print('11111 storage ${await Permission.storage.isGranted}');
    print('11111 camera ${await Permission.camera.isGranted}');
    print('11111 photos ${await Permission.photos.isGranted}');
    print('11111 microphone ${await Permission.microphone.isGranted}');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: InAppWebView(
          key: webViewKey,
          initialUrlRequest: URLRequest(url: Uri.parse(widget.url)),
          initialOptions: InAppWebViewGroupOptions(
            crossPlatform: InAppWebViewOptions(
              useShouldOverrideUrlLoading: true,
              useOnLoadResource: true,
              useOnDownloadStart: true,
              useShouldInterceptAjaxRequest: true,
              useShouldInterceptFetchRequest: true,
              javaScriptCanOpenWindowsAutomatically: true,
              preferredContentMode: UserPreferredContentMode.MOBILE,
              mediaPlaybackRequiresUserGesture: false,
            ),
            android: AndroidInAppWebViewOptions(allowFileAccess: true),
            ios: IOSInAppWebViewOptions(
              allowsLinkPreview: true,
            ),
          ),
          pullToRefreshController: pullToRefreshController,
          onWebViewCreated: (controller) {
            webViewController = controller;
          },
          androidOnPermissionRequest: (InAppWebViewController controller, String origin, List<String> resources) async {
            print('11111 resources $resources');
            return PermissionRequestResponse(resources: resources, action: PermissionRequestResponseAction.GRANT);
          },
          onLoadStart: (controller, url) {},
          shouldOverrideUrlLoading: (controller, navigationAction) async {
            if (!await checkUrl(navigationAction.request.url!)) {
              return NavigationActionPolicy.CANCEL;
            }

            return NavigationActionPolicy.ALLOW;
          },
          onLoadStop: (controller, url) {
            pullToRefreshController?.endRefreshing();
          },
          onLoadError: (controller, request, code, error) {
            pullToRefreshController?.endRefreshing();
          },
          onProgressChanged: (controller, progress) {
            if (progress == 100) {
              pullToRefreshController?.endRefreshing();
            }
          },
          onUpdateVisitedHistory: (controller, url, isReload) {},
        ),
      ),
    );
  }

  Future<bool> checkUrl(Uri url) async {
    if (!["http", "https", "file", "chrome", "data", "javascript", "about"].contains(url.scheme)) {
      return false;
    }

    return true;
  }
}
