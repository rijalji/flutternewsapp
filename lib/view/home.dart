import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:newsapp/models/modelarticles.dart';
import 'package:newsapp/view/detailpage.dart';
import 'package:newsapp/viewmodel/viewmodelarticle.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {


  String countryId='id';
  void handleClick(String value) {
    setState(() {
      countryId=value;
    });
  }

  final  chooseCountry=['id','us'];
  
  List<String> liststringname=[
    'Teknologi',
    'Kesehatan',
    'Olahraga',
    'Hiburan',
    'Ilmu',
    'Bisnis',
  ];
  List<String> liststringnameenglish=[
    'Technology',
    'Health',
    'Sports',
    'Entertainment',
    'Science',
    'Business',
  ];
  List<String> liststringAPI=[
    'technology',
    'health',
    'sports',
    'entertainment',
    'science',
    'business',
  ];

  String valueCategory;
  bool isprescategory=false;
  int thisindex;


  Widget makecontainer(String value,int index){
    return GestureDetector(
      onTap: (){
        setState(() {
           valueCategory=liststringAPI[index];
           isprescategory=true;
           thisindex=index;
        });
      },
      child: Container(
        padding: EdgeInsets.all(ScreenUtil().setHeight(14)),
        margin: EdgeInsets.all(ScreenUtil().setHeight(5)),
        decoration: BoxDecoration(
          color: thisindex==index? Colors.blue:Theme.of(context).backgroundColor,
          borderRadius: BorderRadius.circular(20)
        ),
        child: Center(child: countryId=='id'? Text(liststringname[index],style: GoogleFonts.poppins(color: Colors.white,fontWeight: FontWeight.w700),):
        Text(liststringnameenglish[index],style: GoogleFonts.poppins(color: Colors.white,fontWeight: FontWeight.w700),)),
      ),
    );
  }


  String  newsNameSearch='';
  searchNews(String value){
    setState(() {
      newsNameSearch=value;
    });
  }

  Future<ArticleViewModel> refresh()async{
    setState(() {
      Provider.of<ArticleViewModel>(context,listen: false).fetchArticles(countryId,newsNameSearch);
      isprescategory=false;
      thisindex=9;
    });
  }
  

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitDown,
      DeviceOrientation.portraitUp,
    ]);

    ScreenUtil.init(context, designSize: Size(750, 1334), allowFontScaling: true);
    final providerArticleViewModel=Provider.of<ArticleViewModel>(context);
    SystemChrome.setEnabledSystemUIOverlays ([SystemUiOverlay.top]);
    return   AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle(
        statusBarColor: Colors.transparent
    ),
      child: Scaffold(
        appBar: AppBar(
          actions: <Widget>[
            PopupMenuButton<String>(
              onSelected: handleClick,
              itemBuilder: (BuildContext context) {
                return chooseCountry.map((String choice) {
                  return PopupMenuItem<String>(
                    value: choice,
                    child: Text(choice),
                  );
                }).toList();
              },
            ),
          ],
          centerTitle: true,
          title: Text('News',style: GoogleFonts.poppins(fontSize: ScreenUtil().setSp(70),fontWeight: FontWeight.w700,letterSpacing: 1),),
        ),
        body:RefreshIndicator(
          onRefresh: refresh,
          child: Container(
            child: Column(
              children: <Widget>[
                SizedBox(
                height: ScreenUtil().setHeight(20),
            ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: ScreenUtil().setSp(15)),
                  child: TextField(
                  onChanged:searchNews,
                    decoration: InputDecoration(
                      hintText: countryId=='id' ? 'Cari Berita':'Search News',
                      filled: true,
                      contentPadding: EdgeInsets.symmetric(vertical: 10,horizontal: 20),
                      focusColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15.0),
                        borderSide: BorderSide(color: Colors.blue)
                      ),
                    ),
            ),
                ),
               Container(
                 margin: EdgeInsets.symmetric(vertical: ScreenUtil().setHeight(20)),
                 height: 50,
                 child: ListView(
                     scrollDirection: Axis.horizontal,
                     children: countryId=='id' ? liststringname.asMap().entries.map((MapEntry map)=> makecontainer(map.value,map.key),).toList():
                                                 liststringname.asMap().entries.map((MapEntry map)=> makecontainer(map.value,map.key),).toList()
                 ),
               ),
            isprescategory==true ? Expanded(
              child: FutureBuilder(
                future: providerArticleViewModel.fetchArticleCategory(valueCategory,countryId,newsNameSearch),
                builder: (context,snapshot){
                  return Container(
                    margin: EdgeInsets.symmetric(horizontal: 10),
                    child: GridView.builder(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisSpacing: 4,
                            mainAxisSpacing: 10,
                            crossAxisCount: 2
                        ),
                        itemCount: providerArticleViewModel.gelistarticlescategory.length,
                        itemBuilder: (context,i){
                          final listdata=providerArticleViewModel.gelistarticlescategory[i];
                          return InkWell(
                            onTap: (){
                              Navigator.push(context, MaterialPageRoute(builder: (context){
                                return DetailPage(article: listdata);
                              }));
                            },
                            child: Container(
                              child: Column(
                                children: <Widget>[
                                   snapshot.connectionState==ConnectionState.waiting ? SpinKitPulse(
                                    color: Colors.blue,
                                  ): Container(
                                    height:120,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10.0),
                                        image: DecorationImage(fit: BoxFit.cover,
                                            image: NetworkImage('${listdata.imgUrl}') )
                                    ),
                                  ),
                                  Text('${listdata.title}',maxLines: 3,)
                                ],
                              ),
                            ),
                          );
                        }),
                  );
                },
              ),
            ):
           Expanded(
                  child: FutureBuilder(
                    future: providerArticleViewModel.fetchArticles(countryId,newsNameSearch),
                    builder: (context,snapshot){
                      return Container(
                        margin: EdgeInsets.symmetric(horizontal: 10),
                        child:GridView.builder(
                            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisSpacing: 4,
                              mainAxisSpacing: 10,
                              crossAxisCount: 2
                            ),
                            itemCount: providerArticleViewModel.gelistarticles.length,
                            itemBuilder: (context,i){
                              final listdata=providerArticleViewModel.gelistarticles[i];
                              return InkWell(
                                onTap: (){
                                  Navigator.push(context, MaterialPageRoute(builder: (context){
                                    return DetailPage(article: listdata);
                                  }));
                                },
                                child:  Container(
                                  child: Column(
                                    children: <Widget>[
                                      snapshot.connectionState==ConnectionState.waiting ? SpinKitPulse(
                                        color: Colors.blue,
                                      ): Container(
                                        height: 120,
                                        width: double.infinity,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(10.0),
                                          image: DecorationImage(fit: BoxFit.cover,
                                              image: NetworkImage('${listdata.imgUrl}') )
                                        ),
                                      ),
                                      Text('${listdata.title}',maxLines: 3,)
                                    ],
                                  ),
                                ),
                              );
                            }),
                      );
                    },
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

