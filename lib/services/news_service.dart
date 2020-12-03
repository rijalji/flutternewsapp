import 'dart:convert';
import 'package:newsapp/models/modelarticle.dart';
import 'package:http/http.dart' as http;
import 'package:newsapp/models/modelarticles.dart';
import 'package:flutter/material.dart';
class NewsApi {




  int totalResults;
  Future<List<Article>> fetchArticle(String countryId,String searchNews) async {
      String apiKey = '11bac32a1b474e898a8b1020ea2d2918';
    try {
      http.Response response = await http.get(
          'https://newsapi.org/v2/top-headlines?country=$countryId&q=$searchNews&apiKey=$apiKey');
      if (response.statusCode == 200) {
        final decode = jsonDecode(response.body);
         final data = jsonDecode(response.body)['totalResults'];
         totalResults=data;
         print(totalResults);
        Articles articles = Articles.fromJson(decode);
        List<Article> article = articles.listarticles.map((e) {
          return Article.fromJson(e);
        }).toList();
        return article;
      }
    } catch (e) {
      Exception(e);
    }
  }

  Future<Articles> fetchresultssss() async {
    String apiKey = '11bac32a1b474e898a8b1020ea2d2918';
    try {
      http.Response response = await http.get(
          'https://newsapi.org/v2/top-headlines?country=&apiKey=$apiKey');
      if (response.statusCode == 200) {
        final decode = jsonDecode(response.body)['totalResults'];
        return decode;
      }
    } catch (e) {
      Exception(e);
    }
  }

  List<Articles> listResults = [];

  Future<List<Article>> fetchArticleCategory(String category, String countryId,
      String searchNews) async {
    String apiKey = '11bac32a1b474e898a8b1020ea2d2918';
    try {
      http.Response response = await http.get(
          'https://newsapi.org/v2/top-headlines?country=$countryId&category=$category&q=$searchNews&apiKey=$apiKey');
      if (response.statusCode == 200) {
        final decode = jsonDecode(response.body)['articles'].cast<
            Map<String, dynamic>>();
        List<Article> article = decode.map<Article>((e) {
          return Article.fromJson(e);
        }).toList();
        print(article);
        return article;
      }
    } catch (e) {
      Exception(e);
    }
  }
}
