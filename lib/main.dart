import 'package:flutter/material.dart';
import 'package:horix_v2/screens/login_screen.dart';
import 'package:horix_v2/screens/register_screen.dart';
import 'package:horix_v2/screens/home_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Horix',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/login',
      routes: {
        '/login': (context) => LoginScreen(),
        '/register': (context) => RegisterScreen(),
        '/home': (context) => HomeScreen(), 
      },
    );
  }
}
