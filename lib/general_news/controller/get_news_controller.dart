import 'dart:convert';

import 'package:dio/dio.dart';

import 'package:flutter/widgets.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:news_app/network_exception/api_exception.dart';

class GetNewsController extends GetxController {
  final Dio dio = Dio();
  final searchController = TextEditingController().obs;
  RxBool isLoading = false.obs;
  RxBool isRefreshLoading = false.obs;

//https://newsapi.org/v2/top-headlines?sources=bbc-news for bbc
  Future<String> fetchNews() async {
    final url =
        "https://newsapi.org/v2/everything?q=general&apiKey=${dotenv.env["apiKey"]}";
    try {
      final response = await dio.get(url);
      // final generalNews = NewsModel.fromJson(response.data);
      return json.encode(response.data['articles']);
    } on Exception catch (e) {
      if (e is DioException) {
        isRefreshLoading.value = false;
        //This is the custom message coming from the backend
        final ApiException apiException = ApiException.fromDioError(e);
        debugPrint("DioException Error: ${apiException.toString()}");
        throw e.response!.data['errors'] ?? "Error";
      } else {
        throw Exception("Error");
      }
    } catch (e) {
      debugPrint(e.toString());
      rethrow;
    }
  }

  Future<void> refreshNews() {
    isRefreshLoading.value = true;
    return fetchNews();
  }
}
