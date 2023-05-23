class ProdutoModel {
  final String name;
  final String? id;
  final String image;
  final String descricao;
  final double price;
  
  ProdutoModel ({
    this.id,
    required this.name, required this.descricao, this.image ='', this.price =0  
  }); 
  factory ProdutoModel.fromJson(Map<String,dynamic> json){
    return ProdutoModel(
      name: json['nome'],
      id: json['id'],
      descricao: json['descricao'],
      image: json['foto'],
      price: json['price']



    );
  } 
}