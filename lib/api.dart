import 'package:http/http.dart' as http;
import 'dart:convert';

Future<List<dynamic>> fetchProducts() async {
  final response =
      await http.get(Uri.parse('https://fakestoreapi.com/products'));
  final jsonResponse = jsonDecode(response.body);
  return jsonResponse;
}
