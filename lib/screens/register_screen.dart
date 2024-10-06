import 'package:flutter/material.dart';
import 'package:horix_v2/database_helper.dart';

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _nameController = TextEditingController();
  final _cpfController = TextEditingController();
  final _passwordController = TextEditingController();
  final _emailController = TextEditingController();

  void _register() async {
    final name = _nameController.text;
    final cpf = _cpfController.text;
    final password = _passwordController.text;
    final email = _emailController.text;

    if (name.isEmpty || cpf.isEmpty || password.isEmpty || email.isEmpty) {
      _showAlert('Por favor, preencha todos os campos.');
      return;
    }

    final db = DatabaseHelper();
    await db.registerUser(name, cpf, password, email);
    _showAlert('Usuário cadastrado com sucesso!');
    Navigator.of(context).pushReplacementNamed('/login');
  }

  void _showAlert(String message) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text('Pronto!'),
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
        title: Text('Cadastrar'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _nameController,
              decoration: InputDecoration(
                labelText: 'Nome completo',
                labelStyle: const TextStyle(
                  color: Colors.white, // Cor branca para o label
                  fontSize: 15.0, // Aumentar em 25%
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
              style: const TextStyle(
                  color: Colors.white), // Cor do texto dentro do campo
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _cpfController,
              decoration: InputDecoration(
                labelText: 'CPF',
                labelStyle: const TextStyle(
                  color: Colors.white, // Cor branca para o label
                  fontSize: 15.0, // Aumentar em 25%
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
              style: const TextStyle(color: Colors.white),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(
                labelText: 'Senha',
                labelStyle: const TextStyle(
                  color: Colors.white, // Cor branca para o label
                  fontSize: 15.0, // Aumentar em 25%
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
              style: const TextStyle(color: Colors.white),
              obscureText: true,
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _emailController,
              decoration: InputDecoration(
                labelText: 'E-mail',
                labelStyle: const TextStyle(
                  color: Colors.white, // Cor branca para o label
                  fontSize: 15.0, // Aumentar em 25%
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
              style: const TextStyle(color: Colors.white),
              keyboardType: TextInputType.emailAddress,
            ),
            SizedBox(height: 25),
            ElevatedButton(
              onPressed: _register,
              child: Text('Cadastrar'),
            ),
          ],
        ),
      ),
    );
  }
}
