import 'package:flutter/material.dart';
import 'mark_point_screen.dart'; // Importa a tela de marcação de ponto
import 'points_screen.dart'; // Importa a tela de consulta de pontos

// Tela principal (HomeScreen) exibida após o login
class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Scaffold cria a estrutura básica da tela com barra de app e corpo
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'), // Título exibido na barra superior (AppBar)
      ),
      body: Center(
        // Centraliza os elementos dentro do corpo da tela
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center, // Centraliza os botões verticalmente
          children: [
            // Botão para navegar até a tela de marcação de ponto
            ElevatedButton(
              onPressed: () {
                // Ao clicar, navega para a tela de marcação de ponto
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MarkPointScreen()), // Define a rota para a tela de marcação
                );
              },
              style: ElevatedButton.styleFrom(
                minimumSize: Size(200, 150), // Define o tamanho mínimo do botão
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12), // Define bordas arredondadas para o botão
                ),
                textStyle: TextStyle(
                  fontSize: 20, // Define o tamanho da fonte do texto do botão
                ),
              ),
              child: Text('Marcar Ponto'), // Texto exibido no botão
            ),
            SizedBox(height: 20), // Espaço entre os botões

            // Botão para navegar até a tela de consulta de pontos
            ElevatedButton(
              onPressed: () {
                // Ao clicar, navega para a tela de consulta de pontos
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => PointsScreen()), // Define a rota para a tela de consulta
                );
              },
              style: ElevatedButton.styleFrom(
                minimumSize: Size(200, 150), // Define o tamanho mínimo do botão
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12), // Define bordas arredondadas para o botão
                ),
                textStyle: TextStyle(
                  fontSize: 20, // Define o tamanho da fonte do texto do botão
                ),
              ),
              child: Text('Consultar Pontos'), // Texto exibido no botão
            ),
          ],
        ),
      ),
    );
  }
}
