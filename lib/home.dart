import 'package:flutter/material.dart';
import 'carrinho_page.dart';
import 'controllers/controle_de_lista.dart';
import 'login.dart';
import 'produtos.dart';

class Home extends StatelessWidget {
   Home({Key? key}) : super(key: key);
final Controllers controllers =Controllers();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      appBar: AppBar(
        title: const Text('Foxtrot'),
      ),
      body: const ProdutosPage(),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            ListTile(
              leading: const Icon(Icons.home),
              title: const Text('Home'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.shopping_cart),
              title: Text('Carrinho'),
              onTap: () {
                 Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => CarrinhoPage(produtos: controllers.listaDeCarrinho,)),
                );
              },
              
            ),
            Authentication.isLoggedIn
                ? ListTile(
                    leading: const Icon(Icons.logout),
                    title: const Text('Logout'),
                    onTap: () {
                      Authentication.isLoggedIn = false;
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => LoginPage()),
                      );
                    },
                  )
                : ListTile(
                    leading: const Icon(Icons.login),
                    title: const Text('Login'),
                    onTap: () {
                      Navigator.pushReplacementNamed(context, '/login');
                    },
                  ),
          ],
        ),
      ),
    );
  }
}
