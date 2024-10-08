import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // Para formatar a data/hora
import 'package:horix_v2/database_helper.dart'; // Importa o helper do banco de dados

// Tela de consulta de pontos
class PointsScreen extends StatefulWidget {
  @override
  _PointsScreenState createState() => _PointsScreenState();
}

// Estado da tela de consulta de pontos, onde ocorre a lógica
class _PointsScreenState extends State<PointsScreen> {
  List<Map<String, dynamic>> _points = []; // Lista que armazena os pontos registrados

  @override
  void initState() {
    super.initState();
    _loadPoints(); // Carrega os pontos do banco de dados ao iniciar a tela
  }

  // Função para carregar os pontos do banco de dados
  void _loadPoints() async {
    final data = await DatabaseHelper().getPoints(); // Busca os pontos do banco de dados
    setState(() {
      _points = data; // Atualiza o estado com os pontos carregados
    });
  }

  // Função para excluir um ponto
  void _deletePoint(int id) async {
    await DatabaseHelper().deletePoint(id); // Exclui o ponto do banco de dados
    _loadPoints(); // Recarrega a lista de pontos após a exclusão
    _showAlert('Ponto excluído com sucesso.'); // Mostra uma mensagem de confirmação
  }

  // Função para editar o horário de um ponto
  void _editPoint(int id, String newTimestamp) async {
    // Busca o ponto a ser editado
    final point = _points.firstWhere((point) => point['id'] == id);
    await DatabaseHelper().updatePoint(
      id, // ID do ponto a ser editado
      newTimestamp, // Novo timestamp a ser salvo
      point['latitude'], // Mantém a latitude original
      point['longitude'], // Mantém a longitude original
    );
    _loadPoints(); // Recarrega a lista de pontos após a edição
    _showAlert('Horário editado com sucesso.'); // Mostra uma mensagem de confirmação
  }

  // Função para exibir o diálogo de edição do horário utilizando o TimePicker
  void _showEditDialog(int id, String currentTimestamp) async {
    DateTime currentDateTime = DateTime.parse(currentTimestamp); // Converte o timestamp atual para DateTime

    // Exibe um seletor de horário para o usuário
    TimeOfDay? selectedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.fromDateTime(currentDateTime), // Define o horário atual como padrão
    );

    // Se o usuário selecionou um horário
    if (selectedTime != null) {
      final now = DateTime.now(); // Pega a data atual
      final newDateTime = DateTime(
        now.year, now.month, now.day, // Mantém a data atual
        selectedTime.hour, selectedTime.minute, // Atualiza o horário selecionado
      );

      String formattedNewTimestamp = newDateTime.toIso8601String(); // Converte para o formato ISO
      _editPoint(id, formattedNewTimestamp); // Atualiza o ponto com o novo horário
    }
  }

  // Função para formatar a data/hora de forma mais amigável
  String _formatTimestamp(String timestamp) {
    DateTime parsedDate = DateTime.parse(timestamp); // Converte o timestamp para DateTime
    return DateFormat('dd/MM/yyyy HH:mm').format(parsedDate); // Formata no estilo DD/MM/YYYY HH:MM
  }

  // Função para mostrar um alerta com uma mensagem
  void _showAlert(String message) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Atenção'), // Título do alerta
        content: Text(message), // Conteúdo do alerta com a mensagem
        actions: <Widget>[
          TextButton(
            child: const Text('OK'),
            onPressed: () {
              Navigator.of(ctx).pop(); // Fecha o alerta ao pressionar 'OK'
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
        title: Text('Pontos Registrados'), // Título na barra de navegação
      ),
      body: _points.isEmpty // Se a lista de pontos estiver vazia
          ? Center(
              child: Text(
                'Nenhum ponto registrado.', // Exibe a mensagem de "Nenhum ponto"
                style: TextStyle(color: Colors.white), // Estilo do texto (em branco)
              ),
            )
          : ListView.builder( // Se houver pontos, exibe-os em uma lista
              itemCount: _points.length, // Número de itens na lista
              itemBuilder: (context, index) {
                final point = _points[index]; // Pega cada ponto individualmente
                return Card(
                  margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16), // Margem do cartão
                  child: ListTile(
                    contentPadding: EdgeInsets.all(16), // Padding dentro do cartão
                    title: Text(
                      'Horário: ${_formatTimestamp(point['timestamp'])}', // Exibe o horário formatado
                      style: TextStyle(fontWeight: FontWeight.bold), // Texto em negrito
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 8), // Espaço entre os textos
                        Text('Latitude: ${point['latitude'].toStringAsFixed(5)}'), // Exibe a latitude
                        Text('Longitude: ${point['longitude'].toStringAsFixed(5)}'), // Exibe a longitude
                      ],
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min, // Define o tamanho mínimo para os ícones
                      children: [
                        IconButton(
                          icon: Icon(Icons.edit), // Ícone de editar
                          onPressed: () {
                            _showEditDialog(point['id'], point['timestamp']); // Abre o diálogo de edição
                          },
                        ),
                        IconButton(
                          icon: Icon(Icons.delete), // Ícone de excluir
                          onPressed: () {
                            _deletePoint(point['id']); // Exclui o ponto
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
