import 'package:webview_flutter/webview_flutter.dart';

class WebViewModel {
  String url;
  WebViewCookieManager? cookieManager;

  WebViewModel({required this.url, this.cookieManager});
}
