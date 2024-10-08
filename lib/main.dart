import 'package:flutter/material.dart'; 
import 'package:horix_v2/screens/login_screen.dart'; 
import 'package:horix_v2/screens/register_screen.dart'; 
import 'package:horix_v2/screens/home_screen.dart';

// Função principal que inicializa o aplicativo.
void main() {
  runApp(MyApp());  // Chama o widget raiz do aplicativo.
}

// Definição do widget principal do aplicativo.
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Retorna o MaterialApp, que configura o tema e as rotas do app.
    return MaterialApp(
      title: 'Horix', // Define o título do app.
      
      // Definição do tema padrão para o aplicativo.
      theme: ThemeData(
        primaryColor: const Color(0xFF254485), // Cor principal (usada no AppBar, botões, etc.)
        hintColor: const Color(0xFFDABB7A),  // Cor alternativa (destaques, botões secundários)
        scaffoldBackgroundColor: const Color(0xFF3A599A),  // Cor de fundo das telas do app.

        // Definição de estilos de texto padrão para diferentes tipos de texto no app.
        textTheme: const TextTheme(
          displayLarge: TextStyle(color: Colors.white, fontWeight: FontWeight.bold), // Estilo para títulos grandes.
          bodyLarge: TextStyle(color: Color(0xFFDABB7A)), // Estilo para textos maiores, com cor de destaque.
          bodyMedium: TextStyle(color: Color(0xFF555555)), // Estilo para textos em cinza.
        ),
        
        // Estilos para botões, tanto para aparência quanto comportamento.
        buttonTheme: const ButtonThemeData(
          buttonColor: Color(0xFF254485), // Cor padrão dos botões.
          textTheme: ButtonTextTheme.primary, // Cor do texto dos botões padrão.
        ),
        
        // Estilos para botões elevados (elevated buttons).
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            foregroundColor: Colors.white, backgroundColor: const Color(0xFF254485), // Cor do texto e do fundo dos botões elevados.
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12), // Bordas arredondadas para os botões.
            ),
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20), // Padding interno nos botões.
          ),
        ),
        
        // Estilos para botões de texto (text buttons).
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
            foregroundColor: const Color(0xFFDABB7A), // Cor para os botões de texto (ex.: botões de link como "Cadastrar").
          ),
        ),

        // Estilo padrão para a barra de app (AppBar).
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF254485), // Cor de fundo do AppBar.
          titleTextStyle: TextStyle(color: Colors.white, fontSize: 20), // Cor e tamanho do texto no AppBar.
          elevation: 0, // Remove sombra sob o AppBar.
        ),
      ),
      
      // Define a rota inicial (tela de login) quando o app é aberto.
      initialRoute: '/login',

      // Define as rotas possíveis dentro do aplicativo.
      routes: {
        '/login': (context) => LoginScreen(), // Rota para a tela de login.
        '/register': (context) => RegisterScreen(), // Rota para a tela de registro.
        '/home': (context) => HomeScreen(), // Rota para a tela inicial após login.
      },
    );
  }
}
