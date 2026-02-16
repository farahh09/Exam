import 'package:dio/dio.dart';

//https://www.jsonkeeper.com/b/QXODW
class ApiManager {
  static late Dio dio;

  ApiManager() {
    dio = Dio(BaseOptions(baseUrl: 'https://www.jsonkeeper.com'));
  }

  static Future<Response> get(String url) async {
    return await dio.get(url);
  }
}