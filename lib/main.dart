import 'package:flutter/material.dart';
import 'package:movies/src/pages/home.page.dart';
import 'package:movies/src/pages/movie_detail.page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Movies',
      initialRoute: '/',
      routes: {
        '/': (BuildContext context) => HomePage(),
        'detail': (BuildContext context) => MovieDetail(),
      },
    );
  }
}
