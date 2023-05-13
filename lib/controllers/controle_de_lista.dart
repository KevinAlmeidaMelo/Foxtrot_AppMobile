
class Controllers {
  List<dynamic> listaDeCarrinho = [];
  List<dynamic> adicionarProdutoNoCarrinho(Map<String, dynamic> produto){
   listaDeCarrinho.add(produto); 
   return listaDeCarrinho;
  }
}

