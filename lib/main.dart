import 'package:flutter/material.dart';
import 'home_page.dart';
import 'tool1_page.dart';
import 'tool2_page.dart';
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      routes: {
        '/': (context) => HomePage(),
        '/tool1': (context) => Tool1Page(),
        '/tool2': (context) => Tool2Page(),
       
      },
    );
  }
}
