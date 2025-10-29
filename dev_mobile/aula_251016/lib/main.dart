import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() => runApp(MaterialApp(home: Usuarios()));

class Usuarios extends StatelessWidget {
  const Usuarios({super.key});
  Future<List> buscar() async {
    final r = await http.get(Uri.parse('http://testelegal.page.gd/db.php'));
    return json.decode(r.body);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Usuários')),
      body: FutureBuilder<List>(
        future: buscar(),
        builder: (c, s) {
          if (!s.hasData) return Center(child: CircularProgressIndicator());
          final dados = s.data!;
          return ListView.builder(
            itemCount: dados.length,
            itemBuilder:
                (c, i) => ListTile(
                  title: Text(dados[i]['nome']),
                  subtitle: Text(dados[i]['sobrenome']),
                ),
          );
        },
      ),
    );
  }
}
