import 'package:http/http.dart' as http;
import 'package:news_app_bloc/logics/constant/constant.dart';
import 'package:news_app_bloc/logics/models/news_model.dart';

class NewsServices {
  Future<NewsModel> getNewsList() async {
    final response = await http.get(url);
    NewsModel newsModel = newsModelFromJson(response.body);
    return newsModel;
  }
}
