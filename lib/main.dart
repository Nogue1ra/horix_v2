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
        primaryColor: const Color(0xFF254485), // Cor principal
        hintColor: const Color(0xFFDABB7A),  // Cor invertida
        scaffoldBackgroundColor: const Color(0xFF3A599A),  // Fundo da página
        textTheme: const TextTheme(
          displayLarge: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          bodyLarge: TextStyle(color: Color(0xFFDABB7A)), // Texto com cor invertida
          bodyMedium: TextStyle(color: Color(0xFF555555)), // Texto em cinza
        ),
        buttonTheme: const ButtonThemeData(
          buttonColor: Color(0xFF254485), // Cor dos botões
          textTheme: ButtonTextTheme.primary,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            foregroundColor: Colors.white, backgroundColor: const Color(0xFF254485),    // Cor do texto do botão
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
          ),
        ),
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
            foregroundColor: const Color(0xFFDABB7A), // Cor do botão "Cadastrar" ou secundário
          ),
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF254485), // Cor do AppBar
          titleTextStyle: TextStyle(color: Colors.white, fontSize: 20),
          elevation: 0,
        ),
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
