import 'package:flutter/material.dart';
import 'api.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Minha Loja'),
      ),
      body: const Main(),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            ListTile(
              leading: const Icon(Icons.home),
              title: const Text('Home'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}

class Main extends StatefulWidget {
  const Main({Key? key}) : super(key: key);

  @override
  State<Main> createState() => _MainState();
}

class _MainState extends State<Main> {
  late Future<List<dynamic>> _futureProducts;

  @override
  void initState() {
    super.initState();
    _futureProducts = fetchProducts(); // Faz a solicitação HTTP para a API
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<dynamic>>(
      future: _futureProducts,
      builder: (BuildContext context, AsyncSnapshot<List<dynamic>> snapshot) {
        if (snapshot.hasData) {
          return ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (BuildContext context, int index) {
              return ListTile(
                leading: Image.network(snapshot.data![index]['image']),
                title: Text(snapshot.data![index]['title']),
                subtitle: Text(snapshot.data![index]['description']),
                trailing: Text('\$${snapshot.data![index]['price']}'),
              );
            },
          );
        } else if (snapshot.hasError) {
          return Text('${snapshot.error}');
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}
