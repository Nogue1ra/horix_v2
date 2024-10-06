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
        title: Text('Atenção'),
        content: Text(message),
        actions: <Widget>[
          TextButton(
            child: Text('OK'),
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
        title: Text('Login'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _cpfController,
              decoration: InputDecoration(labelText: 'CPF'),
              keyboardType: TextInputType.number,
            ),
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(labelText: 'Senha'),
              obscureText: true,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _login,
              child: Text('Entrar'),
            ),
            TextButton(
              child: Text('Não tem uma conta? Cadastre-se aqui!'),
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
