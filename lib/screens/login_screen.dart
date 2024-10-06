import 'package:flutter/material.dart';
import 'package:horix_v2/database_helper.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _cpfController = TextEditingController();
  final _passwordController = TextEditingController();

  void _login() async {
    final cpf = _cpfController.text;
    final password = _passwordController.text;

    if (cpf.isEmpty || password.isEmpty) {
      _showAlert('Por favor, preencha todos os campos.');
      return;
    }

    final db = DatabaseHelper();
    final user = await db.getUser(cpf, password);

    if (user != null) {
      // Login bem-sucedido, redirecionar para a home page
      Navigator.of(context).pushReplacementNamed('/home');
    } else {
      _showAlert('CPF ou senha incorretos.');
    }
  }

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
        centerTitle: true,
        title: const Text('Horix'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Image.asset(
              'assets/images/app_icon.png', // Caminho para o ícone do app
              height: 100.0, // Defina o tamanho do ícone
            ),
            SizedBox(height: 20.0), // Espaço entre o ícone e o primeiro campo
            TextField(
              controller: _cpfController,
              decoration: InputDecoration(
                labelText: 'CPF',
                labelStyle: const TextStyle(
                  color: Colors.white, // Cor branca para o label
                  fontSize:
                      20.0, // Aumentar em 25% (supondo que o padrão seja 16.0)
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12), // Borda arredondada
                  borderSide: const BorderSide(
                    color: Colors.white, // Cor da borda (branca, se quiser)
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(
                      12), // Borda arredondada quando focado
                  borderSide: const BorderSide(
                    color: Color(0xFFDABB7A), // Cor da borda (branca) ao focar
                    width: 2.0,
                  ),
                ),
              ),
              keyboardType: TextInputType.number,
              style: const TextStyle(
                  color: Colors.white), // Cor do texto dentro do campo
            ),
            SizedBox(height: 16.0),
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(
                labelText: 'Senha',
                labelStyle: const TextStyle(
                  color: Colors.white, // Cor branca para o label
                  fontSize: 20.0, // Aumentar em 25%
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12), // Borda arredondada
                  borderSide: const BorderSide(
                    color: Colors.white, // Cor da borda
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(
                      12), // Borda arredondada quando focado
                  borderSide: const BorderSide(
                    color: Color(0xFFDABB7A), // Cor da borda quando focado
                    width: 2.0,
                  ),
                ),
              ),
              obscureText: true,
              style: const TextStyle(
                  color: Colors.white), // Cor do texto dentro do campo
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _login,
              child: const Text('Entrar'),
            ),
            TextButton(
              child: const Text('Não tem uma conta? Cadastre-se aqui!'),
              onPressed: () {
                Navigator.of(context).pushReplacementNamed('/register');
              },
            ),
          ],
        ),
      ),
    );
  }
}
