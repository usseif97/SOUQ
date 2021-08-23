import 'package:dio/dio.dart';

class DioHelper {
  static late Dio dio;

  static init() {
    dio = Dio(
      BaseOptions(
        baseUrl: 'https://student.valuxapps.com/api/',
        receiveDataWhenStatusError: true,
      ),
    );
  }

  static Future<Response> getData({
    required String url,
    Map<String, dynamic>? query,
    String lang = 'en',
    String? token,
  }) async {
    if (token != null) {
      dio.options.headers = {
        'Content-Type': 'application/json',
        'lang': lang,
        'Authorizarion': token,
      };
    } else {
      dio.options.headers = {
        'Content-Type': 'application/json',
        'lang': lang,
      };
    }

    if (query != null) {
      return await dio.get(
        url,
        queryParameters: query,
      );
    } else {
      return await dio.get(
        url,
      );
    }
  }

  static Future<Response> postData({
    required String url,
    required Map<String, dynamic> data,
    Map<String, dynamic>? query,
    String lang = 'en',
    String? token,
  }) async {
    if (token != null) {
      print('Token != NULL');
      dio.options.headers = {
        'Content-Type': 'application/json',
        'lang': lang,
        'Authorizarion': token,
      };
    } else {
      dio.options.headers = {
        'Content-Type': 'application/json',
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
      print('QUERY == NULL');
      return await dio.post(
        url,
        data: data,
      );
    }
  }
}
