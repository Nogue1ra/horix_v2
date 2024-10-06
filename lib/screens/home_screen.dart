import 'package:flutter/material.dart';
import 'mark_point_screen.dart';
import 'points_screen.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MarkPointScreen()),
                );
              },
              style: ElevatedButton.styleFrom(
                minimumSize: Size(200, 150), // Tamanho do botão
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12), // Bordas arredondadas
                ),
                textStyle: TextStyle(
                  fontSize: 20, // Tamanho da fonte
                ),
              ),
              child: Text('Marcar Ponto'),
            ),
            SizedBox(height: 20), // Espaço entre os botões
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => PointsScreen()),
                );
              },
              style: ElevatedButton.styleFrom(
                minimumSize: Size(200, 150), // Tamanho do botão
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12), // Bordas arredondadas
                ),
                textStyle: TextStyle(
                  fontSize: 20, // Tamanho da fonte
                ),
              ),
              child: Text('Consultar Pontos'),
            ),
          ],
        ),
      ),
    );
  }
}
