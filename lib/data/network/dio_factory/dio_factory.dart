import 'package:dio/dio.dart';

import 'package:flutter/foundation.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import '../../../app/app_prefs.dart';
import '../../../app/constant.dart';

const String applicationJson = 'application/json';
const String contentType = "Content-Type";
const String accept = "Accept";
const String authorization = 'Authorization';
const String lang = 'lang';

class DioFactory {
  final AppPreferences _appPreferences;
  DioFactory(this._appPreferences);

  Future<Dio> getDio() async {
    Dio dio = Dio();

    String language = await _appPreferences.getAppLanguage();
    // one min time out
    Map<String, String> headers = {
      contentType: applicationJson,
      accept: applicationJson,
      lang: language,
    };

    dio.options = BaseOptions(
      responseType: ResponseType.plain,
      baseUrl: Constant.baseUrl,
      headers: headers,
      receiveDataWhenStatusError: true,
      sendTimeout: const Duration(milliseconds: Constant.apiTimeOut),
      receiveTimeout: const Duration(milliseconds: Constant.apiTimeOut),
      connectTimeout: const Duration(milliseconds: Constant.apiTimeOut),
    );



       dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          options.headers['Authorization'] =
              _appPreferences.isAccessToken();

          return handler.next(options);
        },
        onError: (error, handler) async {
         if (error.response?.statusCode == 401) {
       

        // Update the request header with the new access token
        error.requestOptions.headers['Authorization'] = _appPreferences.isAccessToken();

        // Repeat the request with the updated header
        return handler.resolve(await dio.fetch(error.requestOptions));
      }
      return handler.next(error);
    },
  
         
      ),
    );

    if (!kReleaseMode) {
      //its debug mode so print app logs
      dio.interceptors.add(PrettyDioLogger(
          requestHeader: true, requestBody: true, responseHeader: true));
    }

    return dio;
  }
}
