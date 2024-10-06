import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // Para formatar a data/hora
import 'package:horix_v2/database_helper.dart';

class PointsScreen extends StatefulWidget {
  @override
  _PointsScreenState createState() => _PointsScreenState();
}

class _PointsScreenState extends State<PointsScreen> {
  List<Map<String, dynamic>> _points = [];

  @override
  void initState() {
    super.initState();
    _loadPoints(); // Carrega os pontos assim que a tela é iniciada
  }

  // Função para carregar os pontos do banco de dados
  void _loadPoints() async {
    final data = await DatabaseHelper().getPoints();
    setState(() {
      _points = data;
    });
  }

  // Função para excluir um ponto
  void _deletePoint(int id) async {
    await DatabaseHelper().deletePoint(id);
    _loadPoints(); // Recarrega os pontos após exclusão
    _showAlert('Ponto excluído com sucesso.'); // Mensagem de sucesso
  }

  // Função para editar o horário de um ponto
  void _editPoint(int id, String newTimestamp) async {
    final point = _points.firstWhere((point) => point['id'] == id);
    await DatabaseHelper().updatePoint(
      id,
      newTimestamp,
      point['latitude'],
      point['longitude'],
    );
    _loadPoints(); // Recarrega os pontos após edição
    _showAlert('Horário editado com sucesso.'); // Mensagem de sucesso
  }

  // Função que exibe o diálogo de edição apenas do horário usando TimePicker
  void _showEditDialog(int id, String currentTimestamp) async {
    DateTime currentDateTime = DateTime.parse(currentTimestamp);

    TimeOfDay? selectedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.fromDateTime(currentDateTime),
    );

    if (selectedTime != null) {
      // Convertemos o TimeOfDay para DateTime
      final now = DateTime.now();
      final newDateTime = DateTime(
        now.year,
        now.month,
        now.day,
        selectedTime.hour,
        selectedTime.minute,
      );

      String formattedNewTimestamp = newDateTime.toIso8601String(); // Converte para o formato ISO
      _editPoint(id, formattedNewTimestamp);
    }
  }

  // Função para formatar a data/hora de forma amigável
  String _formatTimestamp(String timestamp) {
    DateTime parsedDate = DateTime.parse(timestamp);
    return DateFormat('dd/MM/yyyy HH:mm').format(parsedDate); // Formato DD/MM/YYYY HH:MM
  }

  // Função para mostrar um alerta
  void _showAlert(String message) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Atenção'),
        content: Text(message),
        actions: <Widget>[
          TextButton(
            child: const Text('OK'),
            onPressed: () {
              Navigator.of(ctx).pop();
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pontos Registrados'),
      ),
      body: _points.isEmpty
          ? Center(
              child: Text(
                'Nenhum ponto registrado.',
                style: TextStyle(color: Colors.white), // Texto em branco
              ),
            )
          : ListView.builder(
              itemCount: _points.length,
              itemBuilder: (context, index) {
                final point = _points[index];
                return Card(
                  margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                  child: ListTile(
                    contentPadding: EdgeInsets.all(16),
                    title: Text(
                      'Horário: ${_formatTimestamp(point['timestamp'])}',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 8),
                        Text('Latitude: ${point['latitude'].toStringAsFixed(5)}'),
                        Text('Longitude: ${point['longitude'].toStringAsFixed(5)}'),
                      ],
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: Icon(Icons.edit),
                          onPressed: () {
                            _showEditDialog(point['id'], point['timestamp']);
                          },
                        ),
                        IconButton(
                          icon: Icon(Icons.delete),
                          onPressed: () {
                            _deletePoint(point['id']);
                          },
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }
}
