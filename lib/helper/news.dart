import 'dart:convert';

import 'package:news_app/models/article_model.dart';
import 'package:http/http.dart' as http;
class News{
  
  List<ArticleModel> news = [];

  Future<void> getNews(String country) async{
    String url = "https://newsapi.org/v2/top-headlines?country=$country&apiKey=21572b3fc3604adc82f2c5fa9a5e65b1";

    var response = await http.get(url);

    var jsonData = jsonDecode(response.body);

    if(jsonData['status'] == "ok"){
      jsonData["articles"].forEach((element){
        if(element['urlToImage'] !=null && element['description'] !=null)
        {
          ArticleModel articleModel = ArticleModel(
            title: element['title'],
            author: element['author'],
            description: element['description'],
            url: element['url'],
            urltoImage: element['urlToImage'],
          );

          news.add(articleModel);
        }
      });
    }
  }
}

class CategoryNewsClass{
  
  List<ArticleModel> news = [];

  Future<void> getCategoryNews(String country, String category) async{
    String url = "https://newsapi.org/v2/top-headlines?country=$country&category=$category&apiKey=21572b3fc3604adc82f2c5fa9a5e65b1";

    var response = await http.get(url);

    var jsonData = jsonDecode(response.body);

    if(jsonData['status'] == "ok"){
      jsonData["articles"].forEach((element){
        if(element['urlToImage'] !=null && element['description'] !=null)
        {
          ArticleModel articleModel = ArticleModel(
            title: element['title'],
            author: element['author'],
            description: element['description'],
            url: element['url'],
            urltoImage: element['urlToImage'],
          );

          news.add(articleModel);
        }
      });
    }
  }
}