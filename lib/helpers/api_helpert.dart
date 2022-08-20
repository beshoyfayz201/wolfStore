import 'package:dio/dio.dart';
import 'package:shoptemp/models/consts.dart';

class ApiHelper {
  static late Dio dio;
  static init() {
    dio = Dio(BaseOptions(
        baseUrl: "https://student.valuxapps.com/api/",
        receiveDataWhenStatusError: true,
        headers: {"Content-Type": "application/json"}));
  }

  static Future<Response> getData(
      {required String url,
      required Map<String, dynamic> quire,
      required String token,
      String lang = "en"}) async {
    dio.options.headers = {
      "Authorization": token,
      "Content-Type": "application/json",
      "lang": lang
    };
    return await dio.get(url, queryParameters: quire);
  }

  static Future<Response> postData(
      {required String url,
      required Map<String, dynamic> query,
      required Map<String, dynamic> data,
      String? tokken}) async {
    print(dio.options.baseUrl);
    dio.options.headers = {
      "Authorization": tokken,
      "lang": "en",
      "Content-Type": "application/json"
    };
    return dio.post(url, data: data);
  }


  static Future<Response> putData(
      {required String url,
      required Map<String, dynamic> query,
      required Map<String, dynamic> data,
      String? tokken}) async {
    print(dio.options.baseUrl);
    dio.options.headers = {
      "Authorization": tokken,
      "lang": "en",
      "Content-Type": "application/json"
    };
    return dio.put(url, data: data);
  }
}
