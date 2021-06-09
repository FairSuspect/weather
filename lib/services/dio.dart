import 'dart:io';

import 'package:dio/dio.dart';
import 'package:weather/config/env.dart';

final Dio dio = new Dio();

void init() {
  dio.options.baseUrl = env.API_BASE_URL!;
  dio.options.connectTimeout = 12000;
  dio.interceptors.add(InterceptorsWrapper(
      onRequest: null, onError: _onError, onResponse: null));
}

// middleware for error
void _onError(DioError e, ErrorInterceptorHandler handler) async {
  print(
      "$e after request with path: ${e.requestOptions.path} [ ${e.requestOptions.method} ]");
  switch (e.type) {
    case DioErrorType.connectTimeout:
      {
        print("timeout");
      }
      break;
    case DioErrorType.response:
      {
        if (e.response!.statusCode == 401) print("unauthorized");
      }
      break;
    case DioErrorType.other:
      {
        if (e.error != null && e.error is SocketException)
          print("Socket exception: ${e.error}");
      }
      break;
    default:
  }
  // handler.
  handler.next(e);
}
