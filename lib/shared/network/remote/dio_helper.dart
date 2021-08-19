import 'package:dio/dio.dart';

class DioHelper {
  static late Dio dio;

  static init() {
    dio = Dio(
      BaseOptions(
        baseUrl: 'https://student.valuxapps.com/api/',
        headers: {
          'Content-Type': 'application/json',
        },
        receiveDataWhenStatusError: true,
      ),
    );
  }

  static Future<Response> getData({
    required String url,
    required Map<String, dynamic> query,
    String lang = 'en',
    String? token,
  }) async {
    dio.options.headers = {
      'lang': lang,
      'Authorizarion': token,
    };
    return await dio.get(
      url,
      queryParameters: query,
    );
  }

  static Future<Response> postData({
    required String url,
    required Map<String, dynamic> data,
    Map<String, dynamic>? query,
    String lang = 'en',
    String? token,
  }) async {
    if (token != null) {
      dio.options.headers = {
        'lang': lang,
        'Authorizarion': token,
      };
    } else {
      dio.options.headers = {
        'lang': lang,
      };
    }

    if (query != null) {
      return await dio.post(
        url,
        data: data,
        queryParameters: query,
      );
    } else {
      return await dio.post(
        url,
        data: data,
      );
    }
  }
}
