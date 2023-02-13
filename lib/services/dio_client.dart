import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:webviewtest/constant/api_constant.dart';
import 'package:webviewtest/constant/constant.dart';
import 'package:webviewtest/services/app_exceptions.dart';
import 'package:webviewtest/services/custom_log_interceptor.dart';
import 'package:webviewtest/services/shared_preferences/shared_pref_services.dart';

class DioClient {
  // Time out duration 20s
  static const int timeOutDuration = 20000;

  static final Dio _dio = Dio();

  static final Dio _dioFormData = Dio();

  static Future<Dio> initService(Function onUserDelete) async {
    final sPref = await SharedPreferencesService.instance;
    final token = sPref.token;
    log('token dio $token');
    _dio
      ..options.baseUrl = ApiConstant.baseUrl
      ..options.connectTimeout = timeOutDuration
      ..options.receiveTimeout = timeOutDuration
      ..options.headers = {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      };
    _dio.interceptors.add(
      InterceptorsWrapper(
        onError: (DioError e, handler) async {
          try {
            if (e.response?.data['detail'] == Constant.userNotFound) {
              onUserDelete(e.response?.data['detail']);
            } else if (e.response?.data['detail'] == Constant.userRoleUpdated) {
              onUserDelete(e.response?.data['detail']);
            } else if (e.response?.statusCode == 401) {
              await refreshSession();
              final tokenNew = await sPref.token;
              DioClient.setToken(tokenNew);
              e.requestOptions.headers['Authorization'] = 'Bearer $tokenNew';
              //create request with new access token
              final opts = Options(
                method: e.requestOptions.method,
                headers: e.requestOptions.headers,
              );
              final cloneReq = await _dio.request(
                e.requestOptions.path,
                options: opts,
                data: e.requestOptions.data,
                queryParameters: e.requestOptions.queryParameters,
              );
              return handler.resolve(cloneReq);
            }
            if (e.response?.statusCode == 404) {
              handler.reject(e);
            }
            if (e.response?.statusCode == 401) {
              handler.reject(e);
            }
            if (e.response?.statusCode == 400) {
              final result = _processResponse(e.response);
              final Response response = Response(
                  requestOptions: e.requestOptions,
                  data: result,
                  statusCode: 200);
              handler.reject(DioError(
                requestOptions: e.requestOptions,
                response: response,
                type: DioErrorType.response,
              ));
            }
          } catch (e) {
            if (e is DioError) {
              final result = _processResponse(e.response);
              final Response response = Response(
                  requestOptions: e.requestOptions,
                  data: result,
                  statusCode: 200);
              handler.reject(DioError(
                requestOptions: e.requestOptions,
                response: response,
                type: DioErrorType.response,
              ));
            }
            debugPrint('Dio initService $e');
          }
        },
      ),
    );
    _dioFormData
      ..options.baseUrl = ApiConstant.baseUrl
      ..options.connectTimeout = timeOutDuration
      ..options.receiveTimeout = timeOutDuration
      ..options.headers = {
        'Accept': 'application/json',
      };
    if (kDebugMode) {
      _dio.interceptors.add(CustomLogInterceptor());
      _dioFormData.interceptors.add(CustomLogInterceptor());
    }
    if (token != null) {
      DioClient.setToken(token);
    }
    return _dio;
  }

  static void setToken(String token) {
    _dio.options.headers['Authorization'] = 'Bearer $token';
    _dioFormData.options.headers['Authorization'] = 'Bearer $token';
  }

  static void logOut() {
    _dio.interceptors.clear();
    _dio.options.headers.remove('Authorization');

    _dioFormData.interceptors.clear();
    _dioFormData.options.headers.remove('Authorization');
  }

  // refresh token
  static Future<void> refreshSession() async {
    final sPref = await SharedPreferencesService.instance;
    try {} catch (e) {
      logOut();
    }
  }

  //GET
  Future<dynamic> get(String api) async {
    try {
      var response = await _dio.get(ApiConstant.baseUrl + api);
      print('get ${ApiConstant.baseUrl + api}');
      return _processResponse(response);
    } catch (e) {
      if (e is DioError) {
        if (DioErrorType.receiveTimeout == e.type ||
            DioErrorType.connectTimeout == e.type) {
          throw ApiNotRespondingException('API not responded in time', api);
        } else if (DioErrorType.sendTimeout == e.type) {
          throw FetchDataException('No Internet connection', api);
        } else if (DioErrorType.response == e.type) {
          // 4xx 5xx response
          // throw exception...
          throw NotFoundException('${e.response?.data['message']}', api);
        } else if (DioErrorType.other == e.type) {
          if (e.message.contains('SocketException')) {
            throw 'No internet connection';
          } else if (e.message.contains('Unhandled Exception')) {
            throw NotFoundException('Not found exception', api);
          }
        } else if (DioErrorType.cancel == e.type) {
          throw CancelRequestException('Cancel Request', api);
        } else {
          throw Exception(
            'Problem connecting to the server. Please try again.',
          );
        }
      } else {
        print(e.toString());
      }
    }
  }

  // DELETE
  Future<dynamic> delete(String api, {dynamic payloads}) async {
    try {
      var response =
          await _dio.delete(ApiConstant.baseUrl + api, data: payloads);
      return _processResponse(response);
    } on DioError catch (e) {
      if (DioErrorType.receiveTimeout == e.type ||
          DioErrorType.connectTimeout == e.type) {
        throw ApiNotRespondingException('API not responded in time', api);
      } else if (DioErrorType.sendTimeout == e.type) {
        throw FetchDataException('No Internet connection', api);
      } else if (DioErrorType.response == e.type) {
        // 4xx 5xx response
        // throw exception...
        throw NotFoundException('${e.response?.data['message']}', api);
      } else if (DioErrorType.other == e.type) {
        if (e.message.contains('SocketException')) {
          throw 'No internet connection';
        } else if (e.message.contains('Unhandled Exception')) {
          throw NotFoundException('${e.response?.data}', api);
        }
      } else if (DioErrorType.cancel == e.type) {
        throw CancelRequestException('Cancel Request', api);
      } else {
        throw Exception('Problem connecting to the server. Please try again.');
      }
    }
  }

  //POST
  Future<dynamic> post(String api, dynamic payloadObj) async {
    var payload = jsonEncode(payloadObj);
    try {
      var response = await _dio.post(ApiConstant.baseUrl + api, data: payload);
      return _processResponse(response);
    } on DioError catch (e) {
      if (DioErrorType.receiveTimeout == e.type ||
          DioErrorType.connectTimeout == e.type) {
        throw ApiNotRespondingException('API not responded in time', api);
      } else if (DioErrorType.sendTimeout == e.type) {
        throw FetchDataException('No Internet connection', api);
      } else if (DioErrorType.response == e.type) {
        // 4xx 5xx response
        throw ResponseException(e.response?.data);
      } else if (DioErrorType.other == e.type) {
        if (e.message.contains('SocketException')) {
          throw 'No internet connection';
        } else if (e.message.contains('Unhandled Exception')) {
          throw NotFoundException('${e.error} : ${e.response?.data}', api);
        }
      } else if (DioErrorType.cancel == e.type) {
        throw CancelRequestException('Cancel Request', api);
      } else {
        throw Exception('Problem connecting to the server. Please try again.');
      }
    }
  }

  // OTHER
  static dynamic _processResponse(response) {
    switch (response.statusCode) {
      case 204:
        return true;
      case 200:
      case 201:
        return response.data;
      case 400:
        return response.data;
      case 401:
      case 403:
        throw UnAuthorizedException(
          utf8.decode(response.bodyBytes),
          response.request!.url.toString(),
        );
      case 404:
        throw BadRequestException(
          utf8.decode(response.bodyBytes),
          response.request!.url.toString(),
        );
      case 413:
        throw FileTooLargeException(utf8.decode(response.bodyBytes));
      case 500:
      default:
        throw FetchDataException(
          'Error occurred with code : ${response.statusCode}',
          response.request!.url.toString(),
        );
    }
  }

  //PUT
  Future<dynamic> put(String api, dynamic payloadObj) async {
    var payload = payloadObj;
    if (payloadObj is! FormData) {
      payload = json.encode(payloadObj);
    }
    try {
      var response = await _dio
          .put(ApiConstant.baseUrl + api, data: payload)
          .timeout(const Duration(seconds: timeOutDuration));
      return _processResponse(response);
    } on DioError catch (e) {
      if (DioErrorType.receiveTimeout == e.type ||
          DioErrorType.connectTimeout == e.type) {
        throw ApiNotRespondingException('API not responded in time', api);
      } else if (DioErrorType.sendTimeout == e.type) {
        throw FetchDataException('No Internet connection', api);
      } else if (DioErrorType.response == e.type) {
        // 4xx 5xx response
        // throw exception...
        throw NotFoundException('${e.error}', api);
      } else if (DioErrorType.other == e.type) {
        if (e.message.contains('SocketException')) {
          throw 'No internet connection';
        } else if (e.message.contains('Unhandled Exception')) {
          throw NotFoundException('Not found exception', api);
        }
      } else if (DioErrorType.cancel == e.type) {
        throw CancelRequestException('Cancel Request', api);
      } else {
        throw Exception('Problem connecting to the server. Please try again.');
      }
    }
  }
}
