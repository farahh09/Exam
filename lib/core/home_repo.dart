import 'package:dio/dio.dart';
import 'package:exam/core/api_manager.dart';

class HomeRepo {
  ApiManager apiManager;

  HomeRepo(this.apiManager);

  Future<dynamic> getProducts() async {
    try {
      Response response = await ApiManager.get("/b/QXODW");
     return response.data;
    } catch (e) {
      throw Exception('Something went wrong');
    }
  }
}