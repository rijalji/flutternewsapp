

class Articles{
  List<dynamic> listarticles;
  int totalResults;

  Articles({this.listarticles,this.totalResults});

  factory Articles.fromJson(Map<String,dynamic>json){
    return Articles(
      listarticles: json['articles'],
      totalResults: json['totalResults']
    );
  }

  Map<String, dynamic> toJson() => {
    'totalResults':totalResults
  };
}
