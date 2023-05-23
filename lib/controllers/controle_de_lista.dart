import 'package:exemplo/models/product_models.dart';

class Controllers {
  List<ProdutoModel> listaDeCarrinho = []; // Lista para armazenar os produtos adicionados ao carrinho

  // Método para adicionar um produto ao carrinho
  List<ProdutoModel> adicionarProdutoNoCarrinho(Map<String, dynamic> produto) {
    ProdutoModel novoProduto = ProdutoModel.fromJson(produto);
    listaDeCarrinho.add(novoProduto); // Adiciona o produto à lista de carrinho
    return listaDeCarrinho; // Retorna a lista atualizada de carrinho
  }
}
