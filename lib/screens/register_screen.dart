import 'package:flutter/material.dart'; // Importa o pacote Material do Flutter para usar componentes visuais.
import 'package:horix_v2/database_helper.dart'; // Importa a classe DatabaseHelper, responsável por interações com o banco de dados.

class RegisterScreen extends StatefulWidget { // Define uma tela de registro que é um StatefulWidget.
  @override
  _RegisterScreenState createState() => _RegisterScreenState(); // Cria o estado da tela de registro.
}

class _RegisterScreenState extends State<RegisterScreen> {
  // Controladores para gerenciar os dados inseridos nos campos de texto.
  final _nameController = TextEditingController(); // Controlador para o campo de nome.
  final _cpfController = TextEditingController(); // Controlador para o campo de CPF.
  final _passwordController = TextEditingController(); // Controlador para o campo de senha.
  final _emailController = TextEditingController(); // Controlador para o campo de e-mail.

  // Função para registrar um novo usuário.
  void _register() async {
    // Obtém os textos digitados nos campos de entrada.
    final name = _nameController.text;
    final cpf = _cpfController.text;
    final password = _passwordController.text;
    final email = _emailController.text;

    // Verifica se todos os campos foram preenchidos.
    if (name.isEmpty || cpf.isEmpty || password.isEmpty || email.isEmpty) {
      _showAlert('Por favor, preencha todos os campos.'); // Exibe um alerta se algum campo estiver vazio.
      return; // Sai da função se houver campos vazios.
    }

    // Cria uma instância do DatabaseHelper para interagir com o banco de dados.
    final db = DatabaseHelper();
    await db.registerUser(name, cpf, password, email); // Registra o usuário no banco de dados.
    _showAlert('Usuário cadastrado com sucesso!'); // Exibe um alerta de sucesso após o registro.
    Navigator.of(context).pushReplacementNamed('/login'); // Redireciona para a tela de login após o cadastro.
  }

  // Função para mostrar um alerta com uma mensagem específica.
  void _showAlert(String message) {
    showDialog(
      context: context, // Contexto da tela atual para mostrar o alerta.
      builder: (ctx) => AlertDialog(
        title: Text('Pronto!'), // Título do alerta.
        content: Text(message), // Mensagem do alerta.
        actions: <Widget>[ // Ações disponíveis no alerta.
          TextButton(
            child: Text('OK'), // Texto do botão para fechar o alerta.
            onPressed: () {
              Navigator.of(ctx).pop(); // Fecha o alerta ao pressionar "OK".
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
        title: Text('Cadastrar'), // Título da AppBar para a tela de cadastro.
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0), // Define um espaçamento ao redor do corpo da tela.
        child: Column(
          children: [
            // Campo de entrada para o nome completo do usuário.
            TextField(
              controller: _nameController, // Controlador associado ao campo de nome.
              decoration: InputDecoration(
                labelText: 'Nome completo', // Texto do rótulo do campo.
                labelStyle: const TextStyle(
                  color: Colors.white, // Cor branca para o rótulo.
                  fontSize: 15.0, // Tamanho da fonte do rótulo.
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12), // Bordas arredondadas quando habilitado.
                  borderSide: const BorderSide(
                    color: Colors.white, // Cor da borda.
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12), // Bordas arredondadas quando focado.
                  borderSide: const BorderSide(
                    color: Color(0xFFDABB7A), // Cor da borda quando focado.
                    width: 2.0, // Largura da borda quando focado.
                  ),
                ),
              ),
              style: const TextStyle(
                  color: Colors.white), // Cor do texto digitado no campo.
            ),
            const SizedBox(height: 20), // Espaço entre os campos.
            // Campo de entrada para o CPF do usuário.
            TextField(
              controller: _cpfController, // Controlador associado ao campo de CPF.
              decoration: InputDecoration(
                labelText: 'CPF', // Texto do rótulo do campo.
                labelStyle: const TextStyle(
                  color: Colors.white, // Cor branca para o rótulo.
                  fontSize: 15.0, // Tamanho da fonte do rótulo.
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12), // Bordas arredondadas quando habilitado.
                  borderSide: const BorderSide(
                    color: Colors.white, // Cor da borda.
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12), // Bordas arredondadas quando focado.
                  borderSide: const BorderSide(
                    color: Color(0xFFDABB7A), // Cor da borda quando focado.
                    width: 2.0, // Largura da borda quando focado.
                  ),
                ),
              ),
              style: const TextStyle(color: Colors.white), // Cor do texto digitado no campo.
              keyboardType: TextInputType.number, // Define o tipo do teclado como numérico para CPF.
            ),
            const SizedBox(height: 20), // Espaço entre os campos.
            // Campo de entrada para a senha do usuário.
            TextField(
              controller: _passwordController, // Controlador associado ao campo de senha.
              decoration: InputDecoration(
                labelText: 'Senha', // Texto do rótulo do campo.
                labelStyle: const TextStyle(
                  color: Colors.white, // Cor branca para o rótulo.
                  fontSize: 15.0, // Tamanho da fonte do rótulo.
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12), // Bordas arredondadas quando habilitado.
                  borderSide: const BorderSide(
                    color: Colors.white, // Cor da borda.
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12), // Bordas arredondadas quando focado.
                  borderSide: const BorderSide(
                    color: Color(0xFFDABB7A), // Cor da borda quando focado.
                    width: 2.0, // Largura da borda quando focado.
                  ),
                ),
              ),
              style: const TextStyle(color: Colors.white), // Cor do texto digitado no campo.
              obscureText: true, // Oculta o texto digitado para a senha.
            ),
            const SizedBox(height: 20), // Espaço entre os campos.
            // Campo de entrada para o e-mail do usuário.
            TextField(
              controller: _emailController, // Controlador associado ao campo de e-mail.
              decoration: InputDecoration(
                labelText: 'E-mail', // Texto do rótulo do campo.
                labelStyle: const TextStyle(
                  color: Colors.white, // Cor branca para o rótulo.
                  fontSize: 15.0, // Tamanho da fonte do rótulo.
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12), // Bordas arredondadas quando habilitado.
                  borderSide: const BorderSide(
                    color: Colors.white, // Cor da borda.
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12), // Bordas arredondadas quando focado.
                  borderSide: const BorderSide(
                    color: Color(0xFFDABB7A), // Cor da borda quando focado.
                    width: 2.0, // Largura da borda quando focado.
                  ),
                ),
              ),
              style: const TextStyle(color: Colors.white), // Cor do texto digitado no campo.
              keyboardType: TextInputType.emailAddress, // Define o tipo do teclado como e-mail.
            ),
            SizedBox(height: 25), // Espaço antes do botão de cadastrar.
            ElevatedButton(
              onPressed: _register, // Chama a função de registro ao pressionar o botão.
              child: Text('Cadastrar'), // Texto do botão.
            ),
          ],
        ),
      ),
    );
  }
}
