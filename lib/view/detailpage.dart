import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:newsapp/viewmodel/viewmodelarticle.dart';
import 'package:webview_flutter/webview_flutter.dart';


import 'package:newsapp/models/modelarticle.dart';


class DetailPage extends StatelessWidget {

  Article article;

  DetailPage({this.article});

  final Completer<WebViewController> completer=Completer<WebViewController>();
  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays ([SystemUiOverlay.top]);
    ScreenUtil.init(context, designSize: Size(750, 1334), allowFontScaling: true);
    return  AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle(
            statusBarColor: Colors.transparent
        ),child: Scaffold(
      appBar: AppBar(
            centerTitle: true,
            title: Text('News',style: GoogleFonts.poppins(fontSize: ScreenUtil().setSp(70),fontWeight: FontWeight.w700,letterSpacing: 1))),
        body: Container(
          child: WebView(
            initialUrl: article.articleUrl,
            onWebViewCreated: ((WebViewController webviewcontroller){
              completer.complete(webviewcontroller);
            }),
          )
        ),
      ),
    );
  }
}
