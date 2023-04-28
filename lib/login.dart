import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Authentication {
  static bool isLoggedIn = false;
}

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _showPassword = false;
  final _passwordController = TextEditingController();
  final _emailController = TextEditingController();

  void _submitForm() async {
    final email = _emailController.text;
    final password = _passwordController.text;
    final url = Uri.parse('http://localhost:3000/users');

    final response = await http.post(url, body: {
      'username': email,
      'password': password,
    });

    if (mounted && response.statusCode == 200) {
      Authentication.isLoggedIn = true;
      Navigator.pushReplacementNamed(context, '/home');
    } else if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Usuário ou senha inválidos"),
        ),
      );
    }
  }

  void _continueWithoutLogin() {
    Navigator.pushReplacementNamed(context, '/home');
  }

  @override
  void dispose() {
    // Limpa o controlador quando o estado é eliminado
    _passwordController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Foxtrot'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FractionallySizedBox(
              widthFactor: 0.3,
              child: TextFormField(
                controller: _emailController,
                decoration: InputDecoration(
                  hintText: 'Login',
                ),
                style: TextStyle(
                  fontSize: 16.0,
                ),
              ),
            ),
            SizedBox(height: 20),
            FractionallySizedBox(
              widthFactor: 0.3,
              child: TextFormField(
                controller: _passwordController,
                obscureText: !_showPassword,
                decoration: InputDecoration(
                  hintText: 'Senha',
                  suffixIcon: IconButton(
                    icon: Icon(
                      _showPassword ? Icons.visibility : Icons.visibility_off,
                    ),
                    onPressed: () {
                      setState(() {
                        _showPassword = !_showPassword;
                      });
                    },
                  ),
                ),
                style: TextStyle(
                  fontSize: 16.0,
                ),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _submitForm,
              child: Text('Confirmar'),
            ),
            SizedBox(height: 20),
            TextButton(
              onPressed: _continueWithoutLogin,
              child: Text('Continuar sem login'),
            ),
          ],
        ),
      ),
    );
  }
}
