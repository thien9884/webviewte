// Copyright 2013 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

// ignore_for_file: public_member_api_docs

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

// #docregion platform_imports
// Import for Android features.
import 'package:webview_flutter_android/webview_flutter_android.dart';

// Import for iOS features.
import 'package:webview_flutter_wkwebview/webview_flutter_wkwebview.dart';
import 'package:webviewtest/constant/list_constant.dart';
import 'package:webviewtest/constant/text_style_constant.dart';
import 'package:webviewtest/screen/navigation_screen/navigation_screen.dart';
// #enddocregion platform_imports

const String kNavigationExamplePage = '''
<!DOCTYPE html><html>
<head><title>Navigation Delegate Example</title></head>
<body>
<p>
The navigation delegate is set to block navigation to the youtube website.
</p>
<ul>
<ul><a href="https://www.youtube.com/">https://www.youtube.com/</a></ul>
<ul><a href="https://www.google.com/">https://www.google.com/</a></ul>
</ul>
</body>
</html>
''';

const String kLocalExamplePage = '''
<!DOCTYPE html>
<html lang="en">
<head>
<title>Load file or HTML string example</title>
</head>
<body>

<h1>Local demo page</h1>
<p>
  This is an example page used to demonstrate how to load a local file or HTML
  string using the <a href="https://pub.dev/packages/webview_flutter">Flutter
  webview</a> plugin.
</p>

</body>
</html>
''';

const String kTransparentBackgroundPage = '''
  <!DOCTYPE html>
  <html>
  <head>
    <title>Transparent background test</title>
  </head>
  <style type="text/css">
    body { background: transparent; margin: 0; padding: 0; }
    #container { position: relative; margin: 0; padding: 0; width: 100vw; height: 100vh; }
    #shape { background: red; width: 200px; height: 200px; margin: 0; padding: 0; position: absolute; top: calc(50% - 100px); left: calc(50% - 100px); }
    p { text-align: center; }
  </style>
  <body>
    <div id="container">
      <p>Transparent background test</p>
      <div id="shape"></div>
    </div>
  </body>
  </html>
''';

class ShopDunkWebView extends StatefulWidget {
  final bool hideBottom;
  final int index;
  final String? baseUrl;
  final String? url;

  const ShopDunkWebView({
    this.baseUrl,
    this.url,
    this.index = 2,
    this.hideBottom = true,
    super.key,
  });

  @override
  State<ShopDunkWebView> createState() => _ShopDunkWebViewState();
}

class _ShopDunkWebViewState extends State<ShopDunkWebView> {
  late final WebViewController _controller;

  @override
  void initState() {
    super.initState();

    // #docregion platform_features
    late final PlatformWebViewControllerCreationParams params;
    if (WebViewPlatform.instance is WebKitWebViewPlatform) {
      params = WebKitWebViewControllerCreationParams(
        allowsInlineMediaPlayback: true,
        mediaTypesRequiringUserAction: const <PlaybackMediaTypes>{},
      );
    } else {
      params = const PlatformWebViewControllerCreationParams();
    }

    final WebViewController controller =
        WebViewController.fromPlatformCreationParams(params);
    // #enddocregion platform_features

    controller
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) async {
            debugPrint('WebView is loading (progress : $progress%)');
          },
          onPageStarted: (String url) {
            debugPrint('Page started loading: $url');
          },
          onPageFinished: (String url) async {
            _controller.clearCache();
            debugPrint('Page finished loading: $url');
          },
          onWebResourceError: (WebResourceError error) {
            debugPrint('''
Page resource error:
  code: ${error.errorCode}
  description: ${error.description}
  errorType: ${error.errorType}
  isForMainFrame: ${error.isForMainFrame}
          ''');
          },
          onNavigationRequest: (NavigationRequest request) {
            if (request.url.startsWith('https://www.youtube.com/')) {
              debugPrint('blocking navigation to ${request.url}');
              return NavigationDecision.prevent;
            }
            debugPrint('allowing navigation to ${request.url}');
            return NavigationDecision.navigate;
          },
        ),
      )
      ..addJavaScriptChannel(
        'Toaster',
        onMessageReceived: (JavaScriptMessage message) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(message.message)),
          );
        },
      )
      ..loadRequest(Uri.parse(
          (widget.baseUrl ?? 'https://shopdunk.com/') + (widget.url ?? '')));

    // #docregion platform_features
    if (controller.platform is AndroidWebViewController) {
      AndroidWebViewController.enableDebugging(true);
      (controller.platform as AndroidWebViewController)
          .setMediaPlaybackRequiresUserGesture(false);
    }
    // #enddocregion platform_features

    _controller = controller;
  }

  @override
  Widget build(BuildContext context) {
    if (!Platform.isIOS) {
      return WillPopScope(
        onWillPop: () async {
          if (await _controller.canGoBack()) {
            await _controller.goBack();
            return false;
          } else {
            return true;
          }
        },
        child: _buildUI(),
      );
    } else {
      return GestureDetector(
        onHorizontalDragUpdate: (detail) async {
          if (await _controller.canGoBack()) {
            await _controller.goBack();
          } else {
            if (!mounted) return;
            if (detail.delta.dx > 0) {
              Navigator.pop(context);
            }
          }
        },
        child: WillPopScope(
          onWillPop: () async => false,
          child: _buildUI(),
        ),
      );
    }
  }

  Widget _buildUI() {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
          child: Column(
        children: [
          Expanded(child: WebViewWidget(controller: _controller)),
          Visibility(visible: widget.hideBottom, child: _buildBottomBar()),
        ],
      )),
    );
  }

  Widget _buildBottomBar() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            blurRadius: 25,
            offset: const Offset(0, -20),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: List.generate(ListCustom.listBottomBar.length, (index) {
          final item = ListCustom.listBottomBar[index];
          return GestureDetector(
            behavior: HitTestBehavior.translucent,
            onTap: () => Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => NavigationScreen(
                  isSelected: item.id,
                ),
              ),
            ),
            child: Column(
              children: [
                Image.asset(
                  widget.index == item.id
                      ? item.img.toString()
                      : item.imgUnselect.toString(),
                  height: 30,
                  width: 30,
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  item.name,
                  style: widget.index == item.id
                      ? CommonStyles.size12W400Grey86(context)
                          .copyWith(color: const Color(0xff0066CC))
                      : CommonStyles.size12W400Grey86(context),
                ),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }
}
