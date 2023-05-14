import 'package:dio/dio.dart';
import 'package:exemplo/controllers/controle_de_lista.dart';
import 'package:exemplo/models/product_models.dart';
import 'package:exemplo/services/product_services.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class DetalhePage extends StatefulWidget {
  Map<String, dynamic> produto;

  DetalhePage({Key? key, required this.produto}) : super(key: key);

  @override
  State<DetalhePage> createState() => _DetalhePageState();
}

class _DetalhePageState extends State<DetalhePage> {
      Controllers controller = Controllers();

  Future<List<ProdutoModel>> addToCart() async {
    final dio =Dio();
    var url = "http://localhost:3000/carrinho";
    final data =widget.produto; 
    var response = await dio.post(url, data: data);
    return (response.data as List).map((e) => ProdutoModel.fromJson(e)).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.produto['nome']),
      ),
      body: ListView(
        children: [
          Image.network(widget.produto['foto']),
          Text(widget.produto['nome']),
          Text(widget.produto['descricao']),
          Text(widget.produto['price'].toString()),
          ElevatedButton(
            onPressed: () {
              // controller.adicionarProdutoNoCarrinho(widget.produto).forEach((produto) {
              //   Navigator.push(
              //      context,
              //      MaterialPageRoute(builder: (context) => CarrinhoPage(name: widget.produto.)),
              //    );
              //  });   
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
                Icon(Icons.shopping_cart),
                SizedBox(width: 5),
                Text(
                  'Ir para o carrinho',
                  style: TextStyle(fontSize: 14),
                ),
              ],
            ),
            style: ButtonStyle(
              fixedSize: MaterialStateProperty.all<Size>(Size(250, 50)),
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class CarrinhoPage extends StatelessWidget {
 final List <ProdutoModel> produtos; 


  
    CarrinhoPage({required this.produtos });
    Controllers controller = Controllers();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Icon(Icons.shopping_cart),
            SizedBox(width: 5),
            Text('Listagem do carrinho'),
          ],
        ),
      ),body: ListView.builder(itemCount: produtos.length,
      padding: EdgeInsets.symmetric(vertical: 16),
      itemBuilder: (context, index) {
        final produto = produtos[index];
        return ListTile(
          leading: CircleAvatar(
            radius: 20,
            backgroundImage: NetworkImage(produto.image),),
            title: Text(produto.name,
            style: TextStyle(fontWeight: FontWeight.w600),
            ),
            subtitle: Text("R\$ ${produto.price.toString()}",
            style: TextStyle(color: Colors.green),
            ),
        );
      },),
    );
  }
}
