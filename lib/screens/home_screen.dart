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
              child: Text('Marcar Ponto'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => PointsScreen()),
                );
              },
              child: Text('Consultar Pontos'),
            ),
          ],
        ),
      ),
    );
  }
}
