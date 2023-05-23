import 'package:dio/dio.dart'; // Importação do pacote 'dio' para fazer solicitações HTTP
import 'package:exemplo/controllers/controle_de_lista.dart'; // Importação do controlador de lista
import 'package:exemplo/models/product_models.dart'; // Importação do modelo de produto
import 'package:exemplo/services/product_services.dart'; // Importação dos serviços relacionados a produtos
import 'package:flutter/material.dart'; // Importação do pacote Flutter
import 'carrinho_page.dart'; // Importação da página do carrinho de compras

class DetalhePage extends StatefulWidget {
  Map<String, dynamic> produto; // Mapa de dados do produto

  DetalhePage({Key? key, required this.produto}) : super(key: key);

  @override
  State<DetalhePage> createState() => _DetalhePageState();
}

class _DetalhePageState extends State<DetalhePage> {
  Controllers controller = Controllers(); // Instância do controlador

  Future<List<ProdutoModel>> addToCart() async {
    final dio = Dio(); // Instância do objeto Dio para fazer solicitações HTTP
    var url = "http://localhost:3000/carrinho"; // URL do endpoint para adicionar produtos ao carrinho
    final data = widget.produto; // Dados do produto a serem enviados
    var response = await dio.post(url, data: data); // Solicitação POST para adicionar o produto ao carrinho
    // Decodificar a resposta para obter a lista de produtos do carrinho
    return (response.data as List).map((e) => ProdutoModel.fromJson(e)).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.produto['nome']), // Título da barra de aplicativo com o nome do produto
      ),
      body: ListView(
        children: [
          Image.network(widget.produto['foto']), // Imagem do produto
          Text(widget.produto['nome']), // Nome do produto
          Text(widget.produto['descricao']), // Descrição do produto
          Text(widget.produto['price'].toString()), // Preço do produto

          ElevatedButton(
            onPressed: () {
              addToCart().then((data) {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => CarrinhoPage(produtos: data,)),
                );
              });
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.shopping_cart), // Ícone do carrinho de compras
                SizedBox(width: 5),
                Text(
                  'Ir para o carrinho', // Texto do botão
                  style: TextStyle(fontSize: 14),
                ),
              ],
            ),
            style: ButtonStyle(
              fixedSize: MaterialStateProperty.all<Size>(Size(250, 50)), // Tamanho fixo do botão
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20), // Borda arredondada do botão
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
