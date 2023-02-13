import 'package:dio/dio.dart';
import 'package:webviewtest/services/log_utils.dart';

class CustomLogInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    LogUtils().info('METHOD: ${options.method}\n'
        'URL: ${options.uri}\n'
        'BODY: ${options.data}\n'
        'HEADERS: ${options.headers}\n');
    handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    LogUtils().info('*** RESPONSE ***\n'
        'URL: ${response.requestOptions.uri}\n'
        'Status Code: ${response.statusCode}\n'
        'Response: ${response.data}\n');
    handler.next(response);
  }

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    LogUtils().error('*** ERROR ***\n'
        'URL: ${err.requestOptions.uri}\n'
        'Response: ${err.response?.data}\n');
    handler.next(err);
  }
}
