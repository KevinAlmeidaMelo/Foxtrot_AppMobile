import 'dart:convert';

import 'package:exemplo/models/product_models.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';


class ProdutoService{
  Future<void> addToCart() async {
    var url = Uri.parse('http://localhost:3000/carrinho');
    var response = await http.get(url);
    
    if (response.statusCode == 200) {
      var jsonResponse = json.decode(response.body);
    } else {
      print('Erro ao chamar a API');
    }
  }
}