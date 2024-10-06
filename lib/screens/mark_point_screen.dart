import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:horix_v2/database_helper.dart';  // Certifique-se que este é o caminho correto

class MarkPointScreen extends StatefulWidget {
  const MarkPointScreen({super.key});

  @override
  _MarkPointScreenState createState() => _MarkPointScreenState();
}

class _MarkPointScreenState extends State<MarkPointScreen> {
  String locationMessage = "";
  String timestampMessage = "";

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
      // ignore: deprecated_member_use
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
      locationMessage =
          "Latitude: ${position.latitude}, Longitude: ${position.longitude}";
      timestampMessage = "Horário: ${now.hour}:${now.minute}:${now.second}";
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
            Text(locationMessage),
            Text(timestampMessage),
            ElevatedButton(
              onPressed: _markPoint,
              child: Text('Registrar Ponto'),
            ),
          ],
        ),
      ),
    );
  }
}
