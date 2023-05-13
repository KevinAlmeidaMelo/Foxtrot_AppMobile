class ProdutoModel {
  final String name;
  final String image;
  final String descricao;
  final double price;
  
  ProdutoModel ({
    required this.name, required this.descricao, this.image ='', this.price =0  
  }); 
  factory ProdutoModel.fromJson(Map<String,dynamic> json){
    return ProdutoModel(
      name: json['nome'],
      descricao: json['descricao'],
      image: json['foto'],
      price: json['price']



    );
  } 
}