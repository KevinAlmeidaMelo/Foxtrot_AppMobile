import 'package:dio/dio.dart';
import 'package:exemplo/models/product_models.dart';
import 'package:flutter/material.dart';

class CarrinhoPage extends StatefulWidget {
  final List<ProdutoModel> produtos; // Lista de produtos do carrinho

  CarrinhoPage({required this.produtos});
  @override
  State<CarrinhoPage> createState() => _CarrinhoPageState();
}

class _CarrinhoPageState extends State<CarrinhoPage> {
  // Construtor que recebe a lista de produtos
  List<ProdutoModel> listaDeCarrinho = [];

  @override
  void initState() {
    super.initState();
    carregarCarrinho();
  }

  Future<void> carregarCarrinho() async {
    try {
      List<ProdutoModel> produtosCarrinho = await getToCart();
      setState(() {
        listaDeCarrinho = produtosCarrinho;
      });
    } catch (error) {
      // Tratar o erro, se necessário
      print('Erro ao carregar o carrinho: $error');
    }
  }

  Future<List<ProdutoModel>> getToCart() async {
    final dio = Dio();
    var url = "http://localhost:3000/carrinho";
    final data = widget.produtos;
    var response = await dio.get(url, data: data);
    return (response.data as List)
        .map((e) => ProdutoModel.fromJson(e))
        .toList();
  }

  Future<void> excluirProdutoDoCarrinho(String produtoId) async {
    final dio = Dio();
    var url = "http://localhost:3000/carrinho/$produtoId";
    var response = await dio.delete(url);

    if (response.statusCode == 200) {
      print('Produto removido do carrinho com sucesso.');
    } else if (response.statusCode == 404) {
      print('Produto não encontrado no carrinho.');
    } else {
      print(
          'Erro ao excluir o produto do carrinho. Código de status: ${response.statusCode}');
    }
  }

  @override
  Widget build(BuildContext context) {
    double valorTotal = 0; // Variável para armazenar o valor total

    // Calcular o valor total
    for (var produto in listaDeCarrinho) {
      valorTotal += produto.price;
    }

    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Icon(Icons.shopping_cart), // Ícone do carrinho de compras
            SizedBox(width: 5),
            Text(
                'Listagem do carrinho'), // Texto do título da barra de aplicativo
          ],
        ),
      ),
      body: ListView.builder(
        itemCount: listaDeCarrinho.length, // Número de produtos na lista
        padding: EdgeInsets.symmetric(vertical: 16),
        itemBuilder: (context, index) {
          final produto = listaDeCarrinho[index]; // Produto atual da iteração
          return ListTile(
            leading: CircleAvatar(
              radius: 20,
              backgroundImage:
                  NetworkImage(produto.image), // Imagem do produto no avatar
            ),
            title: Text(
              produto.name, // Nome do produto
              style: TextStyle(fontWeight: FontWeight.w600),
            ),
            subtitle: Text(
              "R\$ ${produto.price.toString()}", // Preço do produto
              style: TextStyle(color: Colors.green),
            ),
            trailing: IconButton(
              onPressed: () => excluirProdutoDoCarrinho(produto.id!),
              icon: Icon(Icons.delete),
            ),
          );
        },
      ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.all(16),
        color: Colors.grey[200],
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Valor total:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Text(
              'R\$ ${valorTotal.toStringAsFixed(2)}',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => PaginaCompra()),
                );
              },
              child: Text('Finalizar Compra'),
            ),
          ],
        ),
      ),
    );
  }
}

class PaginaCompra extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Finalizar Compra'),
      ),
      body: Center(
        child: Text('Página de finalização da compra'),
      ),
    );
  }
}

// ******************












// import 'package:dio/dio.dart';
// import 'package:exemplo/controllers/controle_de_lista.dart';
// import 'package:exemplo/models/product_models.dart';
// import 'package:flutter/material.dart';

// class CarrinhoPage extends StatefulWidget {
//   final List<ProdutoModel> produtos; // Lista de produtos do carrinho

//   CarrinhoPage({required this.produtos });

//   @override
//   State<CarrinhoPage> createState() => _CarrinhoPageState();
// }

// class _CarrinhoPageState extends State<CarrinhoPage> {
//   // Construtor que recebe a lista de produtos
//   List<ProdutoModel> listaDeCarrinho = [];

//   @override
//   void initState() {
//     super.initState();
//     carregarCarrinho();
//   }

//   Future<void> carregarCarrinho() async {
//     try {
//       List<ProdutoModel> produtosCarrinho = await getToCart();
//       setState(() {
//         listaDeCarrinho = produtosCarrinho;
//       });
//     } catch (error) {
//       // Tratar o erro, se necessário
//       print('Erro ao carregar o carrinho: $error');
//     }
//   }

//   Future<List<ProdutoModel>> getToCart() async {
//     final dio = Dio();
//     var url = "http://localhost:3000/carrinho";
//     var response = await dio.get(url);
//     return (response.data as List)
//         .map((e) => ProdutoModel.fromJson(e))
//         .toList();
//   }

//   Future<void> excluirProdutoDoCarrinho(String produtoId) async {
//     final dio = Dio();
//     var url = "http://localhost:3000/carrinho/$produtoId";
//     var response = await dio.delete(url);

//     if (response.statusCode == 200) {
//       print('Produto removido do carrinho com sucesso.');
//       carregarCarrinho(); // Recarrega o carrinho após a exclusão
//     } else if (response.statusCode == 404) {
//       print('Produto não encontrado no carrinho.');
//     } else {
//       print(
//           'Erro ao excluir o produto do carrinho. Código de status: ${response.statusCode}');
//     }
//   }

//   Future<void> finalizarCompra() async {
//     final dio = Dio();
//     var url = "http://localhost:3000/carrinho/finalizar";
//     var response = await dio.post(url);

//     if (response.statusCode == 200) {
//       print('Compra finalizada com sucesso.');
//       setState(() {
//         listaDeCarrinho = []; // Limpa o carrinho após a finalização da compra
//       });
//     } else {
//       print(
//           'Erro ao finalizar a compra. Código de status: ${response.statusCode}');
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Row(
//           children: [
//             Icon(Icons.shopping_cart), // Ícone do carrinho de compras
//             SizedBox(width: 5),
//             Text('Listagem do carrinho'), // Texto do título da barra de aplicativo
//           ],
//         ),
//       ),
//       body: ListView.builder(
//         itemCount: listaDeCarrinho.length, // Número de produtos na lista
//         padding: EdgeInsets.symmetric(vertical: 16),
//         itemBuilder: (context, index) {
//           final produto = listaDeCarrinho[index]; // Produto atual da iteração
//           return ListTile(
//             leading: CircleAvatar(
//               radius: 20,
//               backgroundImage:
//                   NetworkImage(produto.image), // Imagem do produto no avatar
//             ),
//             title: Text(
//               produto.name, // Nome do produto
//               style: TextStyle(fontWeight: FontWeight.w600),
//             ),
//             subtitle: Text(
//               "R\$ ${produto.price.toString()}", // Preço do produto
//               style: TextStyle(color: Colors.green),
//             ),
//             trailing: IconButton(
//               onPressed: () => excluirProdutoDoCarrinho(produto.id!),
//               icon: Icon(Icons.delete),
//             ),
//           );
//         },
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: finalizarCompra,
//         child: Icon(Icons.check),
//       ),
//     );
//   }
// }

