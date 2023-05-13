import 'package:http/http.dart' as http;
import 'dart:convert';

Future<List<dynamic>> fetchProducts() async {
  try{
  final response = await http.get(Uri.parse('http://localhost:3000/produtos'));
  final jsonResponse = jsonDecode(response.body);
  return jsonResponse;}             
  catch(e){print(e);
    throw e;}
}
