// import 'package:flutter/material.dart';

// class FinalizarCompraPage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Finalização de Compra'),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Icon(
//               Icons.check_circle_outline,
//               size: 100,
//               color: Colors.green,
//             ),
//             SizedBox(height: 16),
//             Text(
//               'Compra Finalizada!',
//               style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
//             ),
//             SizedBox(height: 16),
//             ElevatedButton(
//               onPressed: () {
//                 Navigator.pop(context); // Retorna à página anterior (carrinho)
//               },
//               child: Text('Voltar ao Carrinho'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }


// ******************* OU ***************************


// import 'dart:convert';

// import 'package:http/http.dart' as http;
// class ProdutoService {
//   Future<void> addToCart() async {
//     var url = Uri.parse('http://localhost:3000/carrinho');
//     var response = await http.get(url);

//     if (response.statusCode == 200) {
//       var jsonResponse = json.decode(response.body);
//     } else {
//       print('Erro ao chamar a API');
//     }
//   }
// }
