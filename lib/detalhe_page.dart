import 'package:flutter/material.dart';

// ignore: must_be_immutable
class DetalhePage extends StatefulWidget {
  Map<String, dynamic> produto;

  DetalhePage({Key? key, required this.produto}) : super(key: key);

  @override
  State<DetalhePage> createState() => _DetalhePageState();
}

class _DetalhePageState extends State<DetalhePage> {
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
        ],
      ),
    );
  }
}
