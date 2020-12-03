

class Article{

  final String title;
  final String imgUrl;
  final String description;
  final String articleUrl;
  final Source source;
  final DateTime publishedAt;
  final String content;

  Article({this.title,this.description,this.articleUrl,this.imgUrl,this.source,this.publishedAt,this.content});

  factory Article.fromJson(Map<String,dynamic> json){
    return Article(
      title: json['title'],
      imgUrl: json['urlToImage'],
      description: json['description'],
      articleUrl: json['url'],
      publishedAt: json['"publishedAt'],
      content: json['"content'],
      source: Source.fromJson(json['source']),
    );
  }

}


class Source{
  String name;

  Source({this.name});

  factory Source.fromJson(Map<String,dynamic>json){
    return Source(
       name: json['name']
    );
}


}