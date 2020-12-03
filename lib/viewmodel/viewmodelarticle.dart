import 'package:flutter/material.dart';
import 'package:newsapp/models/modelarticle.dart';
import 'package:newsapp/models/modelarticles.dart';
import 'package:newsapp/services/news_service.dart';


class ArticleViewModel extends ChangeNotifier{
  List<Article> _listarticle=[];
  List<Article> _listarticlecategory=[];
  int result;

  fetchArticles(String countryId,String searchNews)async{
    _listarticle=await NewsApi().fetchArticle(countryId,searchNews);

  }

  fetchArticleCategory(String category,String countryId,String searchNews)async{
    _listarticlecategory=await NewsApi().fetchArticleCategory(category,countryId,searchNews);
  }

  fetchResults()async{
    result=await NewsApi().totalResults;
    print(result);
  }

  List<Article> get gelistarticles => _listarticle;

  List<Article> get gelistarticlescategory => _listarticlecategory;

  int get allRestult=>result;



}