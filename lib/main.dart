import 'package:flutter/material.dart';
import 'package:newsapp/viewmodel/viewmodelarticle.dart';
import 'package:provider/provider.dart';

import 'package:newsapp/view/home.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_)=> ArticleViewModel(),
        )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Home(),
      ),
    );
  }
}
