import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:horix_v2/database_helper.dart';  // Certifique-se que este é o caminho correto

class MarkPointScreen extends StatefulWidget {
  const MarkPointScreen({super.key});

  @override
  _MarkPointScreenState createState() => _MarkPointScreenState();
}

class _MarkPointScreenState extends State<MarkPointScreen> {
  bool _showMessage = false; // Controla a exibição da mensagem

  Future<void> _markPoint() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Serviço de localização está desativado.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Permissão de localização negada.');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error('Permissão de localização negada permanentemente.');
    }

    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );

    DateTime now = DateTime.now();

    // Salva no banco de dados
    await DatabaseHelper().insertPoint(
      now.toIso8601String(),
      position.latitude,
      position.longitude,
    );

    setState(() {
      _showMessage = true; // Exibe a mensagem de sucesso
    });

    // Oculta a mensagem após 3 segundos
    Future.delayed(Duration(seconds: 3), () {
      setState(() {
        _showMessage = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Marcar Ponto'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // Removido os Texts que exibem a latitude, longitude e horário
            SizedBox(height: 20), // Espaçamento entre os textos e o botão
            ElevatedButton(
              onPressed: _markPoint,
              style: ElevatedButton.styleFrom(
                minimumSize: Size(100, 100), // Tamanho mínimo do botão
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8), // Borda arredondada
                ),
                padding: EdgeInsets.all(20), // Padding para aumentar o botão
              ),
              child: Text(
                'Registrar Ponto',
                style: TextStyle(
                  fontSize: 20, // Aumenta o tamanho da letra
                ),
              ),
            ),
            SizedBox(height: 20), // Espaçamento
            // Mensagem de sucesso
            if (_showMessage)
              Container(
                padding: EdgeInsets.all(12),
                color: Colors.green,
                child: Text(
                  "Ponto registrado com sucesso!",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
