import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';  // Para acessar a localização do dispositivo
import 'package:horix_v2/database_helper.dart';  // Certifique-se de que o caminho para o DatabaseHelper está correto

class MarkPointScreen extends StatefulWidget {
  const MarkPointScreen({super.key});

  @override
  _MarkPointScreenState createState() => _MarkPointScreenState();
}

class _MarkPointScreenState extends State<MarkPointScreen> {
  bool _showMessage = false; // Controla a exibição da mensagem de sucesso

  // Função responsável por marcar o ponto
  Future<void> _markPoint() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Verifica se o serviço de localização está habilitado
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Serviço de localização está desativado.');
    }

    // Verifica se as permissões de localização foram concedidas
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

    // Obtém a posição atual do dispositivo
    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,  // Alta precisão
    );

    DateTime now = DateTime.now(); // Obtém o horário atual

    // Insere os dados no banco de dados
    await DatabaseHelper().insertPoint(
      now.toIso8601String(),  // Converte o horário para o formato ISO
      position.latitude,      // Latitude obtida
      position.longitude,     // Longitude obtida
    );

    // Atualiza o estado para exibir a mensagem de sucesso
    setState(() {
      _showMessage = true;
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
        title: Text('Marcar Ponto'),  // Título da AppBar
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(height: 20),  // Espaçamento entre o topo e o botão
            ElevatedButton(
              onPressed: _markPoint,  // Chama a função _markPoint ao pressionar
              style: ElevatedButton.styleFrom(
                minimumSize: Size(100, 100),  // Define o tamanho mínimo do botão
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),  // Define bordas arredondadas
                ),
                padding: EdgeInsets.all(20),  // Padding para aumentar o botão
              ),
              child: Text(
                'Registrar Ponto',  // Texto dentro do botão
                style: TextStyle(
                  fontSize: 20,  // Aumenta o tamanho da fonte
                ),
              ),
            ),
            SizedBox(height: 20),  // Espaçamento entre o botão e a mensagem
            // Exibe a mensagem de sucesso, se _showMessage for verdadeiro
            if (_showMessage)
              Container(
                padding: EdgeInsets.all(12),  // Padding interno da mensagem
                color: Colors.green,  // Fundo verde para sucesso
                child: Text(
                  "Ponto registrado com sucesso!",  // Texto da mensagem
                  style: TextStyle(
                    color: Colors.white,  // Texto branco
                    fontSize: 16,  // Tamanho da fonte da mensagem
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
