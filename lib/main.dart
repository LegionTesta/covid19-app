import 'package:app/home_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'COVID19 App',
      theme: ThemeData(
        fontFamily: "Poppins",
        primarySwatch: Colors.blue,
        textTheme: TextTheme(
          bodyText1: TextStyle(
            color: Colors.grey
          )
        )
      ),
      home: HomeScreen(),
    );
  }
}
